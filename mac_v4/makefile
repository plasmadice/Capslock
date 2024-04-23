compile:
	yq eval capslock.yml -o=json > capslock.json

install: compile
	mkdir -p $$HOME/.config/karabiner/assets/complex_modifications/
	cp capslock.json $$HOME/.config/karabiner/assets/complex_modifications/

up: install
	jq '.profiles[0].complex_modifications.rules = input.rules' $$HOME/.config/karabiner/karabiner.json capslock.json > temp.json
	mv temp.json $$HOME/.config/karabiner/karabiner.json


# all:
# 	mkdir -p $$HOME/.config/karabiner/
# 	cp karabiner.json $$HOME/.config/karabiner/

# .PHONY: compile,install,all