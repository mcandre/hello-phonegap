all: debug

debug:
	ant debug

release:
	ant release

sign: release
	jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore ~/.android/production.keystore bin/HelloPhoneGap-release-unsigned.apk yellosoft

zipalign: sign
	-rm bin/HelloPhoneGap-release-aligned.apk # zipalign hates overwriting files
	zipalign -v 4 bin/HelloPhoneGap-release-unsigned.apk bin/HelloPhoneGap-release-aligned.apk

publish: zipalign

clean:
	-rm -rf bin