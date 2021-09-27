function shorter_path {
    echo `variable_lenght_path.py` 2>/dev/null
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT='
%{$fg[yellow]%}$(envstatus)%{$reset_color%} 
%{$fg[cyan]%}${SHELL_USER}%{$reset_color%} %{$fg_bold[green]%}$(shorter_path) %(?,,%{${fg_bold[red]}%}[%?] )%{$reset_color%}$ '

local return_status="%{$fg[red]%}%(?..⤬)%{$reset_color%}"
RPROMPT='%{$fg_bold[white]%}%T%{$reset_color%} ${return_status}'

bindkey '^U' backward-kill-line
bindkey '^Y' yank
