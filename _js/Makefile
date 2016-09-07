DI_TARGET = di.js
DI_SOURCES = \
	debug.js \
	jquery/jquery.js \
	jquery/jquery.livequery.js \
	jquery/jquery.imagesloaded.js \
	jquery/jquery.pjax.coffee.js \
	jquery/jquery.autotimestamp.coffee.js \
	di/di.coffee.js \
	di/di.utils.coffee.js \
	di/di.language.coffee.js \
	di/di.cover.coffee.js \
	di/di.post.coffee.js \

.PHONY: all
all:  ../static/js/$(DI_TARGET)

../static/js/$(DI_TARGET): $(DI_TARGET)
	mkdir -p ../static/js
	cat $(DI_TARGET) | sed 's/\/\*!/\/**/g' | yui-compressor --type js > ../static/js/$(DI_TARGET)

$(DI_TARGET): $(DI_SOURCES)
	cat $(DI_SOURCES) > $(DI_TARGET)

%.coffee.js: %.coffee
	cat $< | coffee -c -s > $<.js

.PHONY: clean
clean:
	find . -iname \*.coffee.js -exec rm -f {} \;
	rm -f $(DI_TARGET)
	rm -f ../static/js/$(DI_TARGET)
