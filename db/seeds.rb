require "csv"

Address.delete_all
Employee.delete_all

CITIES = %w[
  Mumbai Delhi Bangalore Hyderabad Chennai Kolkata Pune Ahmedabad
  Jaipur Surat Lucknow Kanpur Nagpur Indore Thane Bhopal Visakhapatnam
  Pimpri-Chinchwad Patna Vadodara Ghaziabad Ludhiana Agra Nashik
  Ranchi Faridabad Meerut Rajkot Kalyan-Dombivali Vasai-Virar
].freeze


STREETS = [
  "MG Road", "Brigade Road", "Residency Road", "Infantry Road",
  "Linking Road", "Hill Road", "Juhu Beach Road", "SV Road",
  "Anna Salai", "Nungambakkam High Road", "Rajaji Salai",
  "Park Street", "Camac Street", "AJC Bose Road", "Shakespeare Sarani",
  "Connaught Place", "Janpath", "Barakhamba Road", "Parliament Street",
  "Nehru Place", "Lajpat Nagar", "Greater Kailash", "Hauz Khas",
  "Banjara Hills Road", "Jubilee Hills Road", "Madhapur Main Road",
  "Hitech City Road", "Gachibowli Road", "Whitefield Main Road",
  "Koramangala 5th Block", "Indiranagar 100ft Road", "Jayanagar 4th T Block"
].freeze

job_titles = Employee.job_titles.keys
states     = Address.states.keys

first_names_path = Rails.root.join("db", "first_names.txt")
last_names_path = Rails.root.join("db", "last_names.txt")

first_names = File.readlines(first_names_path, chomp: true)
last_names  = File.readlines(last_names_path, chomp: true)

batch_size = 500
total      = 10000
batches    = (total.to_f / batch_size).ceil

batches.times do |batch|
    sampled_first_names = first_names.slice(batch * batch_size, batch_size)
    sampled_last_names = last_names.slice(batch * batch_size, batch_size)

    employees = (1..batch_size).map do |name|
    {
        first_name: first_names.sample,
        last_name:  last_names.sample,
        job_title:  job_titles.sample,
        salary:     rand(300_000..2_500_000),
        created_at: Time.current,
        updated_at: Time.current
    }
    end
    Employee.insert_all(employees)
end


inserted_ids = Employee.ids
addresses = inserted_ids.map do |employee_id|
    country = Address.countries.keys.sample
    state = LOCATIONS[country.to_sym].keys.sample

    {
    employee_id: employee_id,
    line_1:      "#{rand(1..999)}, #{STREETS.sample}",
    line_2:      "#{%w[Sector Block Phase Layout Colony].sample} #{rand(1..20)}",
    city:        CITIES.sample,
    state:       state,
    country:     country,
    created_at:  Time.current,
    updated_at:  Time.current
    }
end

Address.insert_all(addresses)
