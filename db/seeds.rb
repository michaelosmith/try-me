# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# Uncomment the following to create an Admin user for Production in Jumpstart Pro
# User.create name: "name", email: "email", password: "password", password_confirmation: "password", admin: true, terms_of_service: true

AutopaySchedule.delete_all
FitnessClassBooking.delete_all
FitnessClassSchedule.delete_all
FitnessClass.delete_all
PurchasedItem.delete_all
Sale.delete_all
ClientContract.delete_all
Client.delete_all

CLIENT_STATUS = ["Active", "Expired", "Suspended", "Terminated"]
CLIENT_STATUS_ALT = ["Non-Member", "Declined"]
CONTRACT_NAMES = ["F45 Membership | Fortnightly", "F45 Membership | Fortnightly | 6 month contract", "Youth Membership"]
CONTRACT_PRICES = [139.90, 132, 110]
CONTRACT_LENGTH = 6.months

# User.create!(name: Faker::Name.name,
#   email: 'test@example.com',
#   password: "password1",
#   password_confirmation: "password1",
#   admin: true,
#   terms_of_service: true
# )

print "Creating Clients"

500.times do
  created_date = Faker::Time.between(from: DateTime.now - 1096, to: DateTime.now - 10)
  dob = Faker::Date.birthday(min_age: 17, max_age: 58)

  member = Client.create!(
    mindbody_id: Faker::Number.unique.number(digits: 9),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    photo: Faker::Avatar.image,
    gender: Faker::Gender.binary_type,
    date_of_birth: dob,
    status: CLIENT_STATUS.sample,
    mindbody_profile_created: created_date,
    mindbody_profile_updated: created_date,
    account_id: 1
  )

  iterations = ((Time.now - created_date)/(60*60*24)).to_i
  months = iterations.days.in_months.to_i
  contracts_count = (months.months / CONTRACT_LENGTH) + 1
  contract_name = CONTRACT_NAMES.sample
  contract_price = CONTRACT_PRICES[CONTRACT_NAMES.index(contract_name)]

  contract_date = created_date

  # print "Creating Contracts"

  contracts_count.times do
    contract_id = Faker::Number.unique.number(digits: 4)
    
    new_client_contract = member.client_contracts.create!(
      name: contract_name,
      autopay_status: "Inactive",
      start_date: contract_date,
      end_date: contract_date + CONTRACT_LENGTH,
      mindbody_contract_id: contract_id
    )
    contract_date = contract_date + CONTRACT_LENGTH
  end
  latest_contract = member.client_contracts.last
  if Faker::Boolean.boolean(true_ratio: 0.7)
    latest_contract.update!(autopay_status: "Active")
  end

  if latest_contract.autopay_status == "Active"
    6.times do
      date = Faker::Date.forward(days: 7)
      new_autopay_schedule = latest_contract.autopay_schedules.create!(
        date: date,
        charge: contract_price,
        mindbody_contract_id: latest_contract.mindbody_contract_id
      )
      date = date + 14.days
    end
  end

  # print "Creating Purchases"

  get_contracts = member.client_contracts
  get_contracts.each do |contract|
    days_between = (contract.end_date - contract.start_date).to_i
    sales_count = days_between / 14
    purchase_date = contract.start_date
    price = CONTRACT_PRICES[CONTRACT_NAMES.index(contract.name)]
    taxed = price / 1.1

    sales_count.times do
      break if purchase_date >= DateTime.now
      sale_id = Faker::Number.unique.number(digits: 5)

      new_sale = member.sales.create!(
        mindbody_sale_id: sale_id,
        mindbody_client_id: member.mindbody_id,
        date: purchase_date,
        price: taxed,
        tax: price - taxed,
        total_amount: price,
        description: contract.name,
        payment_type: "Visa / MC"
      )

      new_purchased_item = new_sale.purchased_items.create!(
        sale_id: sale_id,
        mindbody_purchased_item_id: Faker::Number.unique.number(digits: 5),
        is_service: true,
        description: contract.name,
        contract_id: contract.id,
        quantity: 1,
        unti_price: taxed,
        tax: price - taxed,
        amount: price
      )

      purchase_date = purchase_date + 14.days

    end
  end
end

print "Creating Non-member Clients"
1500.times do
  created_date = Faker::Time.between(from: DateTime.now - 1096, to: DateTime.now - 10)
  dob = Faker::Date.birthday(min_age: 17, max_age: 58)

  member = Client.create!(
    mindbody_id: Faker::Number.unique.number(digits: 9),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    photo: Faker::Avatar.image,
    gender: Faker::Gender.binary_type,
    date_of_birth: dob,
    status: "Non-Member",
    mindbody_profile_created: created_date,
    mindbody_profile_updated: created_date,
    account_id: 1
  )
end
