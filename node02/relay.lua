local module = {}
local pin = nil
local callbacks = {}

local function execute_callback(state)
    if (callbacks[state] == nil) then
        return
    end
    callbacks[state]()
end

function module.start(relay_pin)
    pin = relay_pin;
    gpio.mode(pin, gpio.OUTPUT)
end

function module.get_state()
    return gpio.read(pin) == gpio.HIGH
end

function module.set_state(state)
    if state then
        gpio.write(pin, gpio.HIGH)
    else
        gpio.write(pin, gpio.LOW)
    end
    execute_callback(state)
end

function module.on(state, callback)
    callbacks[state] = callback
end

function module.toggle_state()
    state = module.get_state()
    if state then
        gpio.write(pin, gpio.LOW)
    else
        gpio.write(pin, gpio.HIGH)
    end
    execute_callback(not state)
end

return module
