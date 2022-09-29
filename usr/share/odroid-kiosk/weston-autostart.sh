#!/bin/sh

AUTOSTART_DELAY=5

if [ -f /etc/default/odroid-kiosk ]; then
	. /etc/default/odroid-kiosk
fi

sleep $AUTOSTART_DELAY

if [ -f /usr/bin/qt-kiosk-browser ]; then
	/usr/bin/qt-kiosk-browser /etc/qt-kiosk-browser.conf
elif [ -f /usr/bin/chromium-browser ]; then
	/usr/bin/chromium-browser --ozone-platform=wayland --start-fullscreen --kiosk $URL
fi
