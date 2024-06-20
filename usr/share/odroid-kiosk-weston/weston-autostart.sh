#!/bin/sh

AUTOSTART_DELAY=5

if [ -f /etc/default/odroid-kiosk ]; then
	. /etc/default/odroid-kiosk
fi

set -- $(cat /proc/cmdline)
for param in "$@"; do
	case "$param" in
		kiosk.url=*)
			URL=${param#kiosk.url=}
			;;
	esac
done

sleep $AUTOSTART_DELAY

if [ -f /usr/bin/qt-kiosk-browser ]; then
	cat>$XDG_RUNTIME_DIR/qt-kiosk-browser.conf<<__EOF
{
    "URL": "$URL"
}
__EOF

	/usr/bin/qt-kiosk-browser $XDG_RUNTIME_DIR/qt-kiosk-browser.conf
elif [ -f /usr/bin/chromium-browser ]; then
	/usr/bin/chromium-browser --ozone-platform=wayland --start-fullscreen --kiosk $URL
fi
