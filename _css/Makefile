DI_TARGET = di.css
DI_SOURCES = \
	normalize.css \
	skeleton.css \
	animation.css \
	di/di.sass.css \
	jvm.css \
	lity.css \

.PHONY: all
all: ../static/css/$(DI_TARGET)

../static/css/$(DI_TARGET): $(DI_TARGET)
	mkdir -p ../static/css
	cat $(DI_TARGET) | sed 's/\/\*!/\/**/g' | yui-compressor --type css > ../static/css/$(DI_TARGET)

$(DI_TARGET): $(DI_SOURCES) $(shell find opensans/ -type f -print)
	( ./opensans/opensans.bash; cat $(DI_SOURCES) ) > $(DI_TARGET)

%.sass.css: %.sass $(shell find . -type f -iname _\*.sass)
	cat $< | sass --compass --load-path . > $<.css

.PHONY: clean
clean:
	find . -iname \*.sass.css -exec rm -f {} \;
	rm -rf .sass-cache
	rm -f $(DI_TARGET)
	rm -f ../static/css/$(DI_TARGET)

