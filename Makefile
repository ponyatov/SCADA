# \ <section:var>
MODULE    = $(notdir $(CURDIR))
OS        = $(shell uname -s)
MACHINE   = $(shell uname -m)
# / <section:var>
# \ <section:dir>
CWD       = $(CURDIR)
DOC       = $(CWD)/doc
BIN       = $(CWD)/bin
SRC       = $(CWD)/src
TMP       = $(CWD)/tmp
# / <section:dir>
# \ <section:tool>
WGET      = wget -c
MIX       = mix
IEX       = iex
# / <section:tool>
# \ <section:obj>
S += mix.exs
S += src/scada.ex
# / <section:obj>
# \ <section:all>
# \ <section:all>
.PHONY: all
all: $(S)	
	$(IEX) -S $(MIX)
	$(MAKE) $@
# / <section:all>
# / <section:all>
# \ <section:install>
.PHONY: install
install: $(OS)_install
	# \ <section:install>
	$(MAKE) js
	# / <section:install>
.PHONY: update
update: $(OS)_update
.PHONY: $(OS)_install $(OS)_update
$(OS)_install $(OS)_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`
# \ <section:js>
JQUERY_VER     = 3.5.1
BOOTSTRAP_VER  = 3.4.1
.PHONY: js
js:
.PHONY: js
js: static/jquery.js \
	static/bootstrap.css static/bootstrap.js
static/jquery.js:
	$(WGET) -O $@ https://code.jquery.com/jquery-$(JQUERY_VER).min.js
static/bootstrap.css:
	$(WGET) -O $@ https://bootswatch.com/3/darkly/bootstrap.min.css
static/bootstrap.js:
	$(WGET) -O $@ https://maxcdn.bootstrapcdn.com/bootstrap/$(BOOTSTRAP_VER)/js/bootstrap.min.js
# / <section:js>
# / <section:install>
# \ <section:merge>
MERGE  = Makefile README.md apt.txt .gitignore .vscode $(S)
MERGE += .formatter.exs mix.exs
MERGE += static templates
# / <section:merge>
.PHONY: main
main:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
.PHONY: shadow
shadow:
	git pull -v
	git checkout $@
	git pull -v
