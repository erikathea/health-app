namespace :demo do
  desc 'load a set of sample laboratory data, calling the API provided by the app'
  task load_data: :environment do
    puts "#{Rails.root}/lib/assets/payload.json"
    data = File.read "#{Rails.root}/lib/assets/payload.json"
    payload = JSON.parse(data)
    post = Curl.post("http://api.health-serve.dev:3000/save", payload.to_json) do |curl|
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
    end
    puts post.status
    puts post.body_str
  end

end
