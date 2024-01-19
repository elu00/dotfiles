# Setup command dump
## ssh-key setup
```
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
https://github.com/settings/keys
## Ubuntu neovim install:
```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
```
## p10k setup
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```
