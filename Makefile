all:
	@echo "usage: make install"

install:
	mkdir -p ~/.local/bin/
	ln -snf $(PWD)/photos-organize ~/.local/bin/
	cp -p files/bump-memory.desktop ~/Desktop/
	mkdir -p ~/.config/mpv/scripts/
	ln -snf $(PWD)/blacklist-mpv.lua ~/.config/mpv/scripts/
	ln -snf $(PWD)/trash-mpv.lua ~/.config/mpv/scripts/
