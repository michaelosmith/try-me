module Mindbody
  class Service < Mindbody::Base

    def get_all_clients
      page_size = 200
      offset = 0
      all_clients_total = get_total_number_of_clients
      loops = calculate_request_loops(all_clients_total)

      requests = loops.times.map do
        request = Typhoeus::Request.new(
          "#{base_url}/client/clients",
          params: {
            limit: page_size,
            offset: offset
          },
          headers: headers
        )

        offset += page_size
        
        request_pool.queue(request)
        request
      end

      request_pool.run
      
      requests.reduce([]) do |clients, request|
        parsed = parse(request.response.body)[:Clients]
        parsed.each do |client|
          clients << client unless client.empty?
          member = Member.create(#mindbody_id: client[:Id],
                              first_name: client[:FirstName],
                              last_name: client[:LastName],
                              email: client[:Email],
                              gender: client[:Gender],
                              birth_date: client[:BirthDate],
                              profile_created_date: client[:CreationDate],
                              profile_last_modified_date: client[:LastModifiedDateTime]
                             )
        end
        clients
      end
    end

    def get_single_client(client_id)
      request = Typhoeus::Request.new(
        "#{base_url}/client/clients",
        params: { ClientIds: client_id },
        headers: headers
      ).run
      parse(request.response_body)[:Clients]
    end

    def add_client(first_name, last_name, email, dob)
      request = Typhoeus::Request.new(
        "#{base_url}/client/addclient",
        method: :post,
        headers: headers,
        body: JSON.dump({"FirstName": first_name, "LastName": last_name, "Email": email, "BirthDate": dob, "Test": false})
      ).run
      # p request.response_body
      parse(request.response_body)[:Client]
      debugger
    end

    def get_required_client_fields
      get_request("/client/requiredclientfields", :RequiredClientFields)
    end

    def get_services
      get_request("/sale/services", :Services)
    end

    def get_custom_payment_methods
      get_request("/sale/custompaymentmethods", :PaymentMethods)
    end

    def purchase_cart(client_id, service_id, amount = 0)
      request = Typhoeus::Request.new(
        "#{base_url}/sale/checkoutshoppingcart",
        method: :post,
        headers: headers,
        body: JSON.dump({
          "ClientID": client_id,
          "Test": false,
          "Items": [
            {
              "Item": {
                "Type": "Service",
                "Metadata": {
                  "Id": service_id
                }
              },
              "Quantity": 1
            }
          ],
          "Payments": [
            {
              "Type": "Custom",
              "Metadata": {
                "Amount": amount,
                "Id": 25
              }
            }
          ]
        })
      ).run
      p request.response_body
      parse(request.response_body)[:ShoppingCart]
    end


  private

    attr_reader :base_url, :headers, :request_pool

    def get_request(endpoint, response_key)
      request = Typhoeus::Request.new(
        "#{base_url}#{endpoint}",
        headers: headers
      ).run
      update_user_token_last_used(request.response_code)
      parse(request.response_body)[response_key]
    end
    
    def rate_limited?(response)
      response.code == 429
    end

    def get_total_number_of_clients
      request = Typhoeus::Request.new(
        "#{base_url}/client/clients",
        params: { 
          limit: 1,
          offset: 0
        },
        headers: headers
      ).run
      parse(request.response_body)[:PaginationResponse][:TotalResults]
    end

    def calculate_request_loops(total_clients)
      (total_clients / 200.00).ceil
    end
  end
end