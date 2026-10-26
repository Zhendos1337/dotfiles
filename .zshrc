# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-tab virtualenv)
fpath=(~/.config/noctalia/completions "$HOME/.dotfiles/.config/zsh/completions" $fpath)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias l='eza -lah --git'
alias grm='git rm -r --cached' 
alias l='eza -lah --git --icons --group-directories-first --header --octal-permissions'
alias v='nvim'
alias cat='bat'
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias open='handlr open'
# Выбираешь под стрелочками, жмешь Enter — видишь логи
alias kl='kubectl get pods | fzf --header-lines=1 --preview "kubectl logs {1} --tail=50" | awk "{print \$1}" | xargs -r kubectl logs -f'
# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# colors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=green'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=blue'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=#7abcff'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7abcff'
ZSH_HIGHLIGHT_STYLES[identifier]='fg=#7abcff'
ZSH_HIGHLIGHT_STYLES[string]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[path]='fg=#73daca,underline'

#find preview
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range :500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
#history preview
export FZF_DEFAULT_OPTS="
  --height 40% --layout=reverse --border --margin=1 --padding=1
  --color='bg+:#283457,bg:#1a1b26,spinner:#bb9af7,hl:#7dcfff'
  --color='fg:#c0caf5,header:#9ece6a,info:#0db9d7,pointer:#7dcfff'
  --color='marker:#9ece6a,fg+:#7dcfff,prompt:#7dcfff,hl+:#7dcfff'"
source <(fzf --zsh)
#kube cluster confing
export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/work-cluster.yaml:$HOME/.kube/prod-cluster.yaml
eval "$(zoxide init zsh)"
eval $(thefuck --alias)

ZSH_THEME_GIT_PROMPT_UNTRACKED=" 🆕"  # Вместо ?
ZSH_THEME_GIT_PROMPT_MODIFIED=" 📝"   # Вместо !
ZSH_THEME_GIT_PROMPT_STAGED=" ✅"  

fpath=(~/.oh-my-zsh/completions $fpath)
autoload -U compinit && compinit

#compdef gitlab-ci-local
###-begin-gitlab-ci-local-completions-###
#
# yargs command completion script
#
# Installation: gitlab-ci-local completion >> ~/.zshrc
#    or gitlab-ci-local completion >> ~/.zprofile on OSX.
#
_gitlab-ci-local_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gitlab-ci-local --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _gitlab-ci-local_yargs_completions "$@"
else
  compdef _gitlab-ci-local_yargs_completions gitlab-ci-local
fi
###-end-gitlab-ci-local-completions-###

cx() {
  env \
    HTTP_PROXY=socks5h://127.0.0.1:20170 \
    HTTPS_PROXY=socks5h://127.0.0.1:20170 \
    ALL_PROXY=socks5h://127.0.0.1:20170 \
    http_proxy=socks5h://127.0.0.1:20170 \
    https_proxy=socks5h://127.0.0.1:20170 \
    all_proxy=socks5h://127.0.0.1:20170 \
    NO_PROXY=localhost,127.0.0.1,::1 \
    no_proxy=localhost,127.0.0.1,::1 \
    codex -c 'cli_auth_credentials_store="file"' "$@"
}
cxi() {
  env \
    HTTP_PROXY=socks5h://172.20.10.1:10808 \
    HTTPS_PROXY=socks5h://172.20.10.1:10808 \
    ALL_PROXY=socks5h://172.20.10.1:10808 \
    http_proxy=socks5h://172.20.10.1:10808 \
    https_proxy=socks5h://172.20.10.1:10808 \
    all_proxy=socks5h://172.20.10.1:10808 \
    NO_PROXY=localhost,127.0.0.1,::1 \
    no_proxy=localhost,127.0.0.1,::1 \
    codex -c 'cli_auth_credentials_store="file"' "$@"
}
export EDITOR=nvim


xcp() {
  tr -d '\n' < "$1" | xsel -ib
}
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export PATH="/home/zhendos/.cargo/bin:$PATH"

# The next line updates PATH for CLI.
if [ -f '/home/zhendos/yandex-cloud/path.bash.inc' ]; then source '/home/zhendos/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/zhendos/yandex-cloud/completion.zsh.inc' ]; then source '/home/zhendos/yandex-cloud/completion.zsh.inc'; fi

# Created by `pipx` on 2026-10-13 09:20:41
export PATH="$PATH:/home/zhendos/.local/bin"
