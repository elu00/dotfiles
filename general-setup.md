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
## zsh setup
```
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
```
## tex stuff
```
sudo cpan YAML::Tiny
sudo cpan File::HomeDir
```
## Swap backslash and backspace
```
echo -e "keycode 22 = backslash bar \n keycode 51 = BackSpace" | xmodmap - 
```
