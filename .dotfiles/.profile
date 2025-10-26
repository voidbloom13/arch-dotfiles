# PATH EXTENTIONS
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:/snap/bin"

# ALIASES
alias ll="ls -la --color=auto"
alias ls="ls -a --color=auto"
if [[ -x "$(command -v pgcli)" ]]; then
  alias psql="pgcli"
fi
alias intellij="flatpak run com.jetbrains.IntelliJ-IDEA-Community"
