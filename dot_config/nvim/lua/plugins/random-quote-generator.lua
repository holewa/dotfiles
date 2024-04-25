local http = require 'socket.http' -- Assuming you have a Lua HTTP client library available
local dkjson = require 'dkjson' -- Assuming you have a dkjson library available

local QuoteAPI = {}

-- Function to fetch a random quote from the API
function QuoteAPI.fetchRandomQuote()
  local param = '?maxLength=50'
  local param2 = '?tags=coding'

  local url = 'https://api.quotable.io/quotes/random' .. param .. param2
  local response, status = http.request(url)

  if status == 200 then
    -- Parse the JSON response into a Lua table
    local responseData = dkjson.decode(response)

    -- Check if responseData is an array and not empty
    if type(responseData) == 'table' and #responseData > 0 then
      local quoteData = responseData[1] -- Access the first element of the array
      return quoteData
    else
      return 'No quote data found in response'
    end
  else
    return 'Failed to fetch quote'
  end
end

return QuoteAPI
