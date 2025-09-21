mkdir -p ~/.zsh
if [ $# -eq 0 ]; then
	echo "Skipping plugin setup"
else
	echo "Running initial plugin clones"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	if type apt-get >/dev/null; then
		sudo apt-get install zsh-syntax-highlighting
	fi

	if type brew >/dev/null; then
		brew install zsh-syntax-highlighting
	fi
	git clone https://github.com/catppuccin/zsh-syntax-highlighting.git /tmp/zsh-syntax-highlighting
	cp -v /tmp/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
fi

cp .p10k.zsh ~
cp .zshrc ~
if type conda >/dev/null; then
	echo "Conda exists, rerunning conda init"
	conda init zsh
fi
