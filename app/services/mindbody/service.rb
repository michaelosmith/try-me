module Mindbody
  class Service < Mindbody::Base

    def get_all_clients
      get_request("/client/clients", :Clients)
    end

    def get_single_client(client_id)
      get_request("/client/clients", "Clients", { ClientIds: client_id })
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

    def get_client_complete_info(client_id)
      get_request("/client/clientcompleteinfo", nil, { ClientId: client_id })
    end

    def get_client_purchases(client_id)
      get_request(
        "/client/clientpurchases",
        :Purchases,
        {
          ClientId: client_id,
          StartDate: "1980-01-01T00:00:00Z"
        }
      )
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

    def get_request(endpoint, response_key = nil, params = {})
      first_request = Typhoeus::Request.new(
        "#{base_url}#{endpoint}",
        params: params,
        headers: headers
      ).run

      if paginated?(parse(first_request.response_body)) && more_pages?(parse(first_request.response_body))
        pagination_response = parse(first_request.response_body)[:PaginationResponse]
        paginated_requests = paginated_get_request(
          endpoint,
          response_key,
          params,
          pagination_response[:PageSize],
          pagination_response[:TotalResults]
        )
      end
      
      str_to_symbol = response_key.intern if response_key
      result = parse(first_request.response_body)
      if paginated_requests
        response_key ? paginated_requests.prepend(result[str_to_symbol]) : paginated_requests.prepend(result)
      else
        response_key ? result[str_to_symbol] : convert_to_array(result)
      end
      # response_key ? result[str_to_symbol] : result
      # paginated_requests ? paginated_requests << first_request.response_body : first_request.response_body
    end

    def paginated_get_request(endpoint, response_key = nil, params = {}, offset = 0, total_results = 100)
      page_size = 200
      offset = offset
      total_results = total_results
      loops = calculate_request_loops((total_results - offset))

      requests = loops.times.map do
        params = params.merge({ limit: page_size, offset: offset })

        request = Typhoeus::Request.new(
          "#{base_url}#{endpoint}",
          params: params,
          headers: headers
        )

        offset += page_size

        request_pool.queue(request)
        request
      end
      request_pool.run
      
      str_to_symbol = response_key.intern if response_key
      responses = requests.map { |request|
        response_key ? parse(request.response.body)[str_to_symbol] : parse(request.response.body)
      }
    end
    
    def rate_limited?(response)
      response.code == 429
    end

    def calculate_request_loops(total_results, offset = 200)
      (total_results / offset.to_f).ceil
    end

    def paginated?(request)
      request[:PaginationResponse].present?
    end

    def more_pages?(request)
      if request[:PaginationResponse][:RequestedLimit].present? && request[:PaginationResponse][:TotalResults].present?
        request[:PaginationResponse][:RequestedLimit] < request[:PaginationResponse][:TotalResults]
      else
        return false
      end
    end

    def convert_to_array(request)
      arr = []
      arr.push(request)
    end
  end
end