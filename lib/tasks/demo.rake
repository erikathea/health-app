namespace :demo do
  desc 'load a set of sample laboratory data, calling the API provided by the app'
  task load_data: :environment do
    data = File.read "#{Rails.root}/lib/assets/payload.json"
    payload = JSON.parse(data)
    puts payload
  end

end
