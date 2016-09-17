local module = {}

local function ap_start()
    wifi.ap.config({
       ssid=config.WIFI.HOSTNAME,
       pwd=config.WIFI.HOSTNAME,
    })
    wifi.ap.setip({
        ip='192.168.1.1',
        netmask='255.255.255.0',
        gateway='192.168.1.1'
    })
    wifi.ap.dhcp.config({
        start='192.168.1.2'
    })
    wifi.ap.dhcp.start()
    require('server'):start()
    -- todo open a http server for the setup page
end

local function wifi_start(aps)
    for key,value in pairs(aps) do
        if string.lower(config.WIFI.SSID) == string.lower(key) then
            wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
                app.start()
                wifi.sta.eventMonStop(1)
            end)
            wifi.sta.eventMonStart()
            wifi.sta.config(config.WIFI.SSID, config.WIFI.PASSWORD)
            wifi.sta.sethostname(config.WIFI.HOSTNAME)
            wifi.sta.connect()
        end
    end
    -- the ssid of configured wifi is not in range
    -- go in ap mode and show a basic configuration webiste where user is able to change the ssid and pw or restart the esp
    ap_start()
end

function module.start()
    wifi.setmode(wifi.STATIONAP);
    wifi.sta.getap(wifi_start)
end

return module
