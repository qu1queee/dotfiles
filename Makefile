.PHONY: sync clean deps

sync:
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	touch ~/.hushlogin
	@echo "Done. Open a new terminal or run: source ~/.zshrc"

deps:
	brew bundle --file=$(PWD)/Brewfile

clean:
	[ -L ~/.zshrc ] && rm -f ~/.zshrc || true
	[ -L ~/.gitconfig ] && rm -f ~/.gitconfig || true
	@echo "Symlinks removed."
