mkdir -p ~/.config/nvim/lua
if [ -f ~/.config/nvim/lua/plugins/cmake-tools.lua ]; then
    rm ~/.config/nvim/lua/plugins/cmake-tools.lua
fi
if [ -f ~/.config/nvim/lua/plugins/conform.lua ]; then
    rm ~/.config/nvim/lua/plugins/conform.lua
fi
if [ -f ~/.config/nvim/lua/plugins/toggleterm.lua]; then
    rm ~/.config/nvim/lua/plugins/toggleterm.lua
fi

cp nvim/init.lua ~/.config/nvim/
cp -r nvim/lua ~/.config/nvim
