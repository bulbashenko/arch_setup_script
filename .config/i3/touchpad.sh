#!/bin/sh
# Toggle touchpad status
# Using libinput and xinput

# If it was activated disable it and if it wasn't disable it


[[ "$(xinput list-props 20 | grep -P ".*Device Enabled.*\K.(?=$)" -o)" == "1" ]] &&
	    xinput disable 20 ||
	        xinput enable 20
