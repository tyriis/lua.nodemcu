local module = {}

local function wifi_start(aps)
    for key,value in pairs(aps) do
        if string.lower(config.WIFI.SSID) == string.lower(key) then
            wifi.sta.config(config.WIFI.SSID, config.WIFI.PASSWORD)
            wifi.sta.connect()
        end
    end
    -- the ssid of configured wifi is not in range
    -- go in ap mode and show a basic configuration webiste where user is able to change the ssid and pw or restart the esp
end

local function on_gotip_handler()
    app.start()
    wifi.sta.eventMonStop(1)
end

function module.start()
    wifi.setmode(wifi.STATION);
    wifi.sta.eventMonReg(wifi.STA_GOTIP, on_gotip_handler)
    wifi.sta.eventMonStart()
    wifi.sta.getap(wifi_start)
end

return module
