local module = {}

module.WIFI = {}
module.WIFI.SSID = ""
module.WIFI.PASSWORD = ""

--module.NETWORK.HOSTNAME = ""

module.MQTT = {}
module.MQTT.BROKER = ""   -- Ip/hostname of MQTT broker
module.MQTT.PORT = 1883             -- MQTT broker port
module.MQTT.USERNAME = ""           -- If MQTT authenitcation is used then define the user
module.MQTT.PASSWORD  = ""            -- The above user password
module.MQTT.CLIENTID = "ESP8266-" ..  node.chipid() -- The MQTT ID. Change to something you like
module.MQTT.TOPIC = "node/" .. node.chipid()

return module
