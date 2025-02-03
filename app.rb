require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"




get("/") do
  @currlist_resp = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}").to_s
  @parsed_currlist_resp = JSON.parse(@currlist_resp)
  @all_currencies = @parsed_currlist_resp["currencies"]
  erb(:pick_from_currency)
end

get("/:from_currency") do
  @from_curr = params["from_currency"]

  @currlist_resp = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}").to_s
  @parsed_currlist_resp = JSON.parse(@currlist_resp)
  @all_currencies = @parsed_currlist_resp["currencies"]
  erb(:pick_to_currency)
end

get("/:from_currency/:to_currency") do
  @from_curr = params["from_currency"]
  @to_curr = params["to_currency"]

  @results_resp = HTTP.get("https://api.exchangerate.host/convert?from=#{@from_curr}&to=#{@to_curr}&amount=1&access_key=#{ENV["EXCHANGE_RATE_KEY"]}").to_s
  @parsed_results_resp = JSON.parse(@results_resp)
  @result = @parsed_results_resp["result"]
  
  erb(:results)
end
