local module = {}
local server = nil

local function hex_to_char(x)
  return string.char(tonumber(x, 16))
end

local function uri_decode(input)
  return input:gsub("%+", " "):gsub("%%(%x%x)", hex_to_char)
end

local function parseFormData(body)
   local data = {}
   --print("Parsing Form Data")
   for kv in body.gmatch(body, "%s*&?([^=]+=[^&]+)") do
      local key, value = string.match(kv, "(.*)=(.*)")
      print("Parsed: " .. key .. " => " .. value)
      data[key] = uri_decode(value)
   end
   return data
end

function receive_handler(response, request)
    -- json decode the payload do we need any error handling here?
    -- data = cjson.decode(payload)
    -- print(request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if method == nil then
         _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    if vars ~= nil then
        for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
            _GET[k] = v
        end
    end
    local mimeType = string.match(request, "Content%-Type: ([%w/-]+)")
    local bodyStart = request:find("\r\n\r\n", 1, true)
    local body = request:sub(bodyStart, #request)
    if mimeType == "application/x-www-form-urlencoded" then
        requestData = parseFormData(body)
        print(requestData)
    end
    -- print(method, path, vars, _GET)
    file.open("index.html", "r")
    buffer = ''
    buffer = buffer .. file.read()
    buffer = string.gsub(buffer, '{{title}}', 'Hello ESP8266-' .. node.chipid())
    file.close()
    response:send(buffer)
    response:close()
    collectgarbage()

end

function module:start()
    server = net.createServer(net.TCP, 10)
    server:listen(80, function(connection)
        connection:on('receive', receive_handler)
    end)
end

function module.stop()
    server:close()
end

return module
