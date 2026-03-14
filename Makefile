.PHONY: sync clean

sync:
	[ -f ~/.zshrc ]    || ln -s $(PWD)/zshrc    ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	@echo "Done. Open a new terminal or run: source ~/.zshrc"

clean:
	rm -f ~/.zshrc ~/.gitconfig
	@echo "Symlinks removed."
