.PHONY: all clean
all: JupyterLab.app

JupyterLab.app: Info.plist JupyterLab.icns jupyterlab.py
	install -d $@/Contents/Resources
	install -m 644 Info.plist $@/Contents
	install -m 755 jupyterlab.py $@/Contents/JupyterLab
	install -m 644 JupyterLab.icns $@/Contents/Resources
	

Info.plist: app.json
	plutil -convert xml1 -o $@ $<

JupyterLab.icns: JupyterLab.iconset
	iconutil -c icns -o $@ $<

JupyterLab.iconset: 2000px-Tango_Jupiter.svg.png
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
	rm -rf Info.plist
	rm -rf JupyterLab.icns
	rm -rf JupyterLab.iconset
	rm -rf JupyterLab.app

install: JupyterLab.app
	cp -r $< /Applications
