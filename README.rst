***********
lua.nodemcu
***********

What is lua.nodemcu?
====================

lua.nodemcu is te code running on my ESP8266_ modules. At the moment each node works with his own code, maybe one day i will build a better abstraction.
Some of the nodes have an Arduino with sensors connected via serial.
the Arduino use Serial.print_ to call functions on ESP8266_ side.

.. _ESP8266: https://en.wikipedia.org/wiki/ESP826.. _https://en.wikipedia.org/wiki/ESP82666
.. _Serial.print: https://www.arduino.cc/en/Serial/Print

How does lua.nodemcu work?
==========================

The nodemcu calls the init.lua file on startup, the init.lua just call the app.lua, when developing i can just remove the init.lua so the code does not auto execute on reboot.
The app then include the required modules and wait for the wlan to start.
the nodes are intended to work as autonomus satelites, sending theyr information to an mqtt broker

What come next?
===============

* - when connection to the wifi is not possible, not configured / no wifi in range the node should go in AP mode offering a simple configuration interface
* - it should be possible to start a socket server to listen for incoming socket commands like restarting the node, configuring the wifi, reading the file system, write new files into the file system and doing other administration work
* - the node only needs wifi and mqtt configuration to startup, once connected to the mqtt it send a message to a special channel to initialize the registration procedure of the server, the node and the server will then commnunicate the channel the node will send his messages.
* - the node listen to an channel for actions, actions trigger previously registered callbacks on lua side.
* - the node should be able to send data to the arduino
* - on server application side (web ui) there is a place to manage the node via the socket server, update lua code, restart node, check health, debug
