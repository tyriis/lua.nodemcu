local module = {}

function publish(value)
    netcom.publish(value)
end

function pong(milis)
    netcom.publish({PING = milis})
end

function module.start()
    --print("application start")
    --print("IP address: " .. wifi.sta.getip())
    netcom.start(function()
        netcom.on('HEAP', 'NODE', function()
            netcom.publish({})
        end)
        uart.setup(0,9600,8,0,1)
        netcom.publish({
            message = "listen to serial"
        })
        netcom.on('STATUS', 'PIR', function()
            print("PIR\r")
        end)
        netcom.on('STATUS', 'LIGHT', function()
            print("LIGHT\r")
        end)
        netcom.on('STATUS', 'TSL2561', function()
            print("TSL2561\r")
        end)
        netcom.on('STATUS', 'SI7021', function()
            print("SI7021\r")
        end)
        netcom.on('PING', 'ARDUINO', function()
            print("PING\r")
        end)
        netcom.on('STATUS', 'RELAY', function()

        end)
    end)
end

return module
