local module = {}
local client
local topic
local callbacks = {}

function module.start(onComplete)
    topic = config.MQTT.TOPIC
    print "Connecting to MQTT broker. Please wait..."
    client = mqtt.Client(config.MQTT.CLENTID, 120, config.MQTT.USER, config.MQTT.PASSWORD)
    client:connect(config.MQTT.BROKER, config.MQTT.PORT, 0, function(conn)
        print("Connected to MQTT:" .. config.MQTT.BROKER .. ":" .. config.MQTT.PORT .." as " .. config.MQTT.CLIENTID )
        config.MQTT = nil  -- more secure and save memory
        client:subscribe(topic .. '/action' , 0, function(conn)
            module.publish({
                action = 'LISTEN',
                value = topic .. '/action'
            })
            print('Subscribing topic: ' .. topic .. '/action')
            onComplete()
        end)
        client:on("offline", function(con)
            print ('offline => ' .. node.heap())
            -- TODO write dc to a log file? and restart node, publish log file after reconnect
        end)
        client:on("message", function(conn, topic, json)
            if (json == nil) then
                return
            end
            data = cjson.decode(json)
            if (data.action == nil or callbacks[data.action] == nil ) then
                return
            end
            if (data.sensor == nil or callbacks[data.action][data.sensor] == nil) then
                return
            end
            print('execute callback for action: ' .. data.action .. ' on sensor: ' .. data.sensor)
            callbacks[data.action][data.sensor]()
        end)
        module.publish({
            action = 'START'
        })
    end)
end

function module.on(action, sensor, callback)
    if (callbacks[action] == nil) then
        callbacks[action] = {}
    end
    print('register callback for ' .. sensor .. ' on ' .. action)
    callbacks[action][sensor] = callback
end

function module.publish(data)
    data.heap = node.heap()
    json = cjson.encode(data)
    client:publish(topic, json, 0, 0, function(conn)
    end)
end

return module
