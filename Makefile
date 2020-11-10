.PHONY: fmt
fmt:
	@find app src test -name '*.hs' -exec stack exec -- stack exec -- ormolu --mode inplace {} \;

.PHONY: test
test:
	stack test

shuffle-exe: src/**/*.hs app/**/*.hs
	stack build --local-bin-path . --copy-bins