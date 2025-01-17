compile:
	yq eval capslock.yml -o=json > capslock.json

install: compile
	mkdir -p $$HOME/.config/karabiner/assets/complex_modifications/
	cp capslock.json $$HOME/.config/karabiner/assets/complex_modifications/

up: install # safe to use as of 2025-01-14, compiles and installs the karabiner config straight to complex modifications
	cp $$HOME/.config/karabiner/karabiner.json $$HOME/.config/karabiner/karabiner.json.bak
	jq '.profiles[0].complex_modifications.rules = input.rules' $$HOME/.config/karabiner/karabiner.json capslock.json > temp.json
	if [ -s temp.json ]; then mv temp.json $$HOME/.config/karabiner/karabiner.json; else echo "Error: temp.json is empty. Aborting."; exit 1; fi

# all:
# 	mkdir -p $$HOME/.config/karabiner/
# 	cp karabiner.json $$HOME/.config/karabiner/

# .PHONY: compile,install,all