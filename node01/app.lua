mqtt_client = require('mqtt_client') 
config      = require('config')
wlan        = require('wlan')

local app = {}

function publish(value)
    mqtt_client.publish(value)
end

function pong(milis)
    mqtt_client.publish({PING = milis})
end

function app.start()
    --print("application start")
    --print("IP address: " .. wifi.sta.getip())
    mqtt_client.start(function()
        mqtt_client.on('HEAP', 'NODE', function()
            mqtt_client.publish({})
        end)
        uart.setup(0,9600,8,0,1)
        mqtt_client.publish({
            message = "listen to serial"
        })
        mqtt_client.on('STATUS', 'PIR', function()
            print("PIR\r")
        end)
        mqtt_client.on('STATUS', 'LIGHT', function()
            print("LIGHT\r")
        end)
        mqtt_client.on('STATUS', 'TSL2561', function()
            print("TSL2561\r")
        end)
        mqtt_client.on('STATUS', 'SI7021', function()
            print("SI7021\r")
        end)
        mqtt_client.on('PING', 'ARDUINO', function()
            print("PING\r")
        end)
        mqtt_client.on('STATUS', 'RELAY', function()

        end)
    end)
end

wlan.start(app.start)
