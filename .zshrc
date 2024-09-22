# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE

# Install Powerlevel10k
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source "$HOME/aliases.zsh"
source "$HOME/history.zsh"
source "$HOME/git.zsh"
source "$HOME/zsh-syntax-highlighting.zsh"

# vi mode
bindkey -v

# Bat pager
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
alias cat=bat

# Tells 'less' not to paginate if less than a page
export LESS="-F -X $LESS"

# Builder Toolbox
export PATH="$PATH:$HOME/.toolbox/bin"
# GNU SED
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# Set Neovim to the default editor
export EDITOR=$(which nvim)

# Set up mise for runtime management
eval "$(mise activate zsh)"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Lazygit config file directory
export CONFIG_DIR="$HOME/.config/lazygit"

# Use Finch when using Docker with CDK
export CDK_DOCKER="finch"
