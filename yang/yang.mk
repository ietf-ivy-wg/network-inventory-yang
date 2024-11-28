YANGDIR ?= yang

STDYANGDIR ?= tools/yang
$(STDYANGDIR):
	git clone --depth 10 -b main https://github.com/YangModels/yang $@

OPTIONS=--tree-print-groupings --tree-no-expand-uses -f tree --tree-line-length=70
ifeq ($(OS), Windows_NT)
YANG_PATH="$(YANGDIR);$(STDYANGDIR)/standard/ietf/RFC/;$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
else
YANG_PATH="$(YANGDIR):$(STDYANGDIR)/standard/ietf/RFC/:$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
endif
YANG=$(wildcard $(YANGDIR)/*.yang)
STDYANG=$(wildcard $(YANGDIR)/ietf-*.yang)
TXT=$(patsubst $(YANGDIR)/%.yang,%-diagram.txt,$(YANG))

.PHONY: yang-lint yang-gen-diagram yang-clean

pyang-lint: $(STDYANG) $(STDYANGDIR)
	pyang -V --ietf -p $(YANG_PATH) $(STDYANG)
#	pyang -V -p $(YANG_PATH)

yang-lint: $(STDYANG) $(STDYANGDIR)
	yanglint --verbose -p $(YANGDIR) -p $(STDYANGDIR)/standard/ietf/RFC/ -p $(STDYANGDIR)/experimental/ietf-extracted-YANG-modules $(STDYANG) -i

yang-gen-diagram: yang-lint $(TXT)

yang-clean:
	rm -f $(TXT)

%-diagram.txt: $(YANGDIR)/%.yang
	pyang $(OPTIONS) -p $(YANG_PATH) $< > $@
