APP=JupyterLab
EXECUTABLE=jupyterlab.py
DESTDIR=/Applications

PB=/usr/libexec/PlistBuddy

.PHONY: all clean
.SUFFIXES: .png .iconset .icns
.PRECIOUS: $(APP).iconset # Workaround, make is unable to remove intermediate directories

all: $(APP).app

$(APP).app: $(APP).plist $(APP).icns $(EXECUTBALE)
	install -d $@/Contents/Resources
	install -m 644 $(APP).plist $@/Contents/Info.plist
	install -m 755 $(EXECUTABLE) $@/Contents/$(APP)
	install -m 644 $(APP).icns $@/Contents/Resources
	
$(APP).plist:
	$(PB) -c "add :CFBundleInfoDictionaryVersion string 6.0" $@
	$(PB) -c "add :CFBundleIconFile string $(APP)" $@
	$(PB) -c "add :CFBundleDisplayName string $(APP)" $@
	$(PB) -c "add :CFBundleExecutable string $(APP)" $@
	$(PB) -c "add :CFBundleIdentifier string $(APP)" $@

.iconset.icns:
	iconutil -c icns -o $@ $<

.png.iconset:
	install -d $@
	convert -background none -resize '!16x16' $< $@/icon_16x16.png
	convert -background none -resize '!32x32' $< $@/icon_16x16@2x.png
	convert -background none -resize '!32x32' $< $@/icon_32x32.png
	convert -background none -resize '!64x64' $< $@/icon_32x32@2x.png
	convert -background none -resize '!128x128' $< $@/icon_128x128.png
	convert -background none -resize '!256x256' $< $@/icon_128x128@2x.png
	convert -background none -resize '!256x256' $< $@/icon_256x256.png
	convert -background none -resize '!512x512' $< $@/icon_256x256@2x.png
	convert -background none -resize '!512x512' $< $@/icon_512x512.png
	convert -background none -resize '!1024x1024' $< $@/icon_512x512@2x.png

clean:
	rm -rf $(APP).plist
	rm -rf $(APP).icns
	rm -rf $(APP).iconset
	rm -rf $(APP).app

install: $(APP).app
	cp -r $< $(DESTDIR)
