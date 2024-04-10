-- password.lua

local function getPassword()
    -- Retrieve password from 'pass' command
    local api_key = io.popen("pass show chatgpt"):read("*a")

    -- Remove leading/trailing whitespace
    api_key = api_key and api_key:match("^%s*(.-)%s*$")

    return api_key
end

return {
    getPassword = getPassword
}
