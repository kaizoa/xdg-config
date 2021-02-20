set -x XDG_DATA_HOME ~/.local/share
set -x XDG_CONFIG_HOME ~/.config
set -x XDG_CACHE_HOME ~/.cache

set -x LANG en_US.UTF-8
#set -x PATH $PATH ~/Library/Android/sdk/platform-tools
set -x PATH $PATH /usr/local/bin
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

ulimit -n 1024


# Direnv settings {{{
# set -x EDITOR nvim
set -x EDITOR "code -r --wait"
eval (direnv hook fish)
# }}}


# Vim settings {{{
alias vim nvim
alias vi  vim
# }}}

# Editor settings {{{
alias ed $EDITOR
# }}}


# coreutils settings {{{
set COREUTILS_PATH /usr/local/opt/coreutils/libexec/gnubin
if [ -s $COREUTILS_PATH ]
  set -x PATH $COREUTILS_PATH $PATH
end
# }}}


# SSH settings {{{
if [ -s "$XDG_CONFIG_HOME/ssh/conendg" ]
  set SSH_CONFIG "-F $XDG_CONFIG_HOME/ssh/conendg"
end
if [ -s "$XDG_CONFIG_HOME/ssh/id_dsa" ]
  set SSH_ID "-i $XDG_CONFIG_HOME/ssh/id_dsa"
end
alias ssh         ssh $SSH_CONFIG $SSH_ID
alias ssh-copy-id ssh-copy-id $SSH_ID
# }}}


# cheat {{{
set -x DEFAULT_CHEAT_DIR $XDG_CONFIG_HOME/cheat
if [ ! -d $DEFAULT_CHEAT_DIR ]
  mkdir -p $DEFAULT_CHEAT_DIR
end
# }}}


# Tig settings {{{
set -x TIGRC_USER $XDG_CONFIG_HOME/tig/tigrc
# alias tig "tig --all"
# }}}


# Anyenv settings {{{
# if [ -d $HOME/.anyenv ]
#   set -x ANY_ENV_HOME $HOME/.anyenv
#   set -x PATH $HOME/.anyenv/bin $PATH
#   #eval (anyenv init -)
#   source ~/.anyenv/completions/anyenv.fish
#   function anyenv
#     set command $argv[1]
#     set -e argv[1]
#     command anyenv "$command" $argv
#   end
# end
# }}}


# PHP settings {{{
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/libxml2/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/bzip2/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/libiconv/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/bison/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths


# Ruby settings {{{
#set -x GEM_HOME $HOME/.gem
#set -x PATH     $GEM_HOME/ruby/2.0.0/bin:$PATH
#set -x PATH     $GEM_HOME/bin/:$PATH
#[ ! -d "~/.gem" ]; and mkdir ~/.gem
#set -x GEM_HOME ~/.gem
# }}}


# Go settings {{{
set -x GOPATH "$HOME/Codes"
if [ ! -d $GOPATH/bin ]
  mkdir -p $GOPATH/bin
end


# Term settings {{{
if [ (uname -s) = "Linux" ]
  set -x TERM "screen-256color"
end
if [ (uname -s) = "Darwin" ]; and [ ! -f ~/.cache/term/"$TERM".ti ]
  mkdir -p ~/.cache/term
  #infocmp "$TERM" | sed 's/kbs=^[hH]/kbs=\\177/' >| ~/.cache/term/"$TERM".ti
  #tic ~/.cache/term/"$TERM".ti
end
# }}}

alias gp 'cd (ghq root)/(ghq list | peco)'
alias gh-top 'hub browse (ghq list | peco | cut -d "/" -f 2,3)'
eval (hub alias -s)

# Run tmux
# pgrep tmux > /dev/null ^&1; or tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf

# asdf
set -x ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
set -x ASDF_DATA_DIR $XDG_DATA_HOME/asdf
set -x ASDF_GOLANG_VERSION 1.16
set -x ASDF_NODEJS_VERSION 15.9.0
source /usr/local/opt/asdf/asdf.fish
