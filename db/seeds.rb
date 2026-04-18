require "csv"

Address.delete_all
Employee.delete_all

INDIAN_CITIES = %w[
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

csv_path = Rails.root.join("db", "employees_names.csv")

names = CSV.read(csv_path, headers: true).map do |row|
    { first_name: row["first_name"], last_name: row["last_name"] }
end

batch_size = 500
total      = names.size
batches    = (total.to_f / batch_size).ceil

batches.times do |batch|
    batch_names = names.slice(batch * batch_size, batch_size)

    employees = batch_names.map do |name|
    {
        first_name: name[:first_name],
        last_name:  name[:last_name],
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
    {
    employee_id: employee_id,
    line_1:      "#{rand(1..999)}, #{STREETS.sample}",
    line_2:      "#{%w[Sector Block Phase Layout Colony].sample} #{rand(1..20)}",
    city:        INDIAN_CITIES.sample,
    state:       states.sample,
    created_at:  Time.current,
    updated_at:  Time.current
    }
end

Address.insert_all(addresses)
