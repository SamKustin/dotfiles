#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sam Kustin <samanthakustin@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Set default editor to vim
export VISUAL="/usr/local/bin/vim"
export EDITOR="/usr/local/bin/vim"

# Set Options
# setopt CLOBBER            # Allows files to be truncated (overwritten)
