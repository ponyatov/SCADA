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
# \ <section:inst>
.PHONY: install
install: $(OS)_install
.PHONY: update
update: $(OS)_update
.PHONY: $(OS)_install $(OS)_update
$(OS)_install $(OS)_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`
# / <section:inst>
# \ <section:merge>
MERGE  = Makefile README.md apt.txt .gitignore .vscode $(S)
MERGE += .formatter.exs mix.exs
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
