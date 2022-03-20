SHELL=/bin/bash -o pipefail

CL_GREEN=$(shell printf '\x1b[32m')
CL_RED=$(shell printf '\x1b[31m')
CL_RESET=$(shell printf '\x1b[0m')

test:	assert-test image-test

assert-test:	$(patsubst %.saty,%.pdf,$(wildcard tests/*.saty))
	rm tests/*.pdf tests/*.satysfi-aux

image-test:	$(patsubst %.saty,%.comp.pdf,$(wildcard image-tests/*.saty))
	rm image-tests/*.pdf image-tests/*.satysfi-aux

image-tests/%.comp.pdf:	image-tests/%.pdf image-tests-ans/%.pdf
	@echo "! BEGIN image test on $<"
	@[ 1000 -gt $(shell magick compare -metric AE "$<" "$(patsubst image-tests/%,image-tests-ans/%,$<)" "$@" 2>&1 ) ] && echo "$(CL_GREEN)! PASS image test on $<$(CL_RESET)" || echo "$(CL_RED)!FAILED image test on $<$(CL_RESET)"

image-tests/%.pdf:	image-tests/%.saty image-tests/test.satyh src
	@echo "! BEGIN test on $<"
	@opam exec satysfi $(SATYSFI_OPTION) "$<" | sed -ne '/^!/p' | sed -e 's/^\(.*PASS.*\)$$/$(CL_GREEN)\1$(CL_RESET)/' | sed -e 's/^\(.*FAIL.*\)$$/$(CL_RED)\1$(CL_RESET)/'

tests/%.pdf:	tests/%.saty tests/test.satyh src
	@echo "! BEGIN test on $<"
	@opam exec satysfi $(SATYSFI_OPTION) "$<" | sed -ne '/^!/p' | sed -e 's/^\(.*PASS.*\)$$/$(CL_GREEN)\1$(CL_RESET)/' | sed -e 's/^\(.*FAIL.*\)$$/$(CL_RED)\1$(CL_RESET)/'


