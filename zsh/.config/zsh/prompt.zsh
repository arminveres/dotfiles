## autoload vcs and colors
autoload -U colors && colors

###################################################################################################
##   zsh builtin git prompt
###################################################################################################
# autoload -Uz vcs_info
## enable only git
# zstyle ':vcs_info:*' enable git

## setup a hook that runs before every ptompt.
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst

## add a function to check for untracked files in the directory.
## from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# +vi-git-untracked() {
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#         git status --porcelain | grep '??' &> /dev/null ; then
#         # This will show the marker if there are any untracked files in repo.
#         # If instead you want to show the marker only if there are untracked
#         # files in $PWD, use:
#         #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#         hook_com[staged]+='!' # signify new files with a bang
#     fi
# }

# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c %{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"

###################################################################################################
## END
###################################################################################################


PROMPT='
%{$fg[red]%}[%{$reset_color%}%n %{$fg[red]%}at %{$reset_color%}%m%{$fg[red]%}]%{$reset_color%} %{$fg[blue]%}in %{$fg[cyan]%}%~%{$reset_color%} '
# PROMPT+="\$vcs_info_msg_0_ " # Default git prompt
PROMPT+='$(gitprompt)' # plugin git prompt
PROMPT+='
%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'

RPROMPT='%t'
