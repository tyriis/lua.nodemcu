REQUIREMENTS
============


MQTT
----
- normal production
- file transfer, data trnasmition, etc


HTTP WEB SERVER
---------------

- basic setup
- file transfer and fix
- emergency mode

RECOVERY
--------
the node enter in recovery mode when the startup was not completet, to archieve this we can f.e. at first after startup create a file recovery.mode when startup is finished we delete the file or write a 0 in it or something similar so when startup was not complete the node starts in recovery mode on next boot

in recovery mode, the noe starts in hybrid mode ap/client so we can if wlan is not reacheable connct directly with a phone or laptop to the device
we then can start a basic webpage where we can reboot the node, upload files, from an application maybe running on the esp i am not sure for this


JSON REST
---------
@todo test aRest serial on arduino <-> esp connection
return static files over the http web interface also also return json responses for standard calls like node.info() node.filesystem() node.bootreaseon() etc


