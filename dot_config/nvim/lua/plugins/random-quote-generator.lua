local http = require 'socket.http' -- Assuming you have a Lua HTTP client library available
local dkjson = require 'dkjson'    -- Assuming you have a dkjson library available

local QuoteAPI = {}

function QuoteAPI.fetchRandomQuote()
  local url = 'https://ron-swanson-quotes.herokuapp.com/v2/quotes'
  local response, status = http.request(url)

  if status == 200 then
    -- Parse the JSON response into a Lua table
    local quoteData = dkjson.decode(response)

    -- Check if quoteData is a table
    -- if type(quoteData) == 'table' then
    return quoteData[1];
    -- else
    --   return { content = 'No quote data found', author = '' }
    -- end
  -- else
  --   return { content = 'Failed to fetch quote', author = '' }
  end
end

return QuoteAPI
