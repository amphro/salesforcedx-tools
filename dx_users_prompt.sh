#!/bin/bash 

function dx_user_prompt_fn {
    DX_USER=$(more .sfdx/sfdx-config.json 2> /dev/null | jq ".defaultusername" -r)
    DX_DEVHUB_USER=$(more .sfdx/sfdx-config.json 2> /dev/null | jq ".defaultdevhubusername" -r)

    if [[ $DX_USER == '' ]]
    then
        DX_USER=$(more $HOME/.sfdx/sfdx-config.json 2> /dev/null | jq ".defaultusername" -r)
    fi

    if [[ $DX_DEVHUB_USER == '' ]]
    then
        DX_DEVHUB_USER=$(more $HOME/.sfdx/sfdx-config.json 2> /dev/null | jq ".defaultdevhubusername" -r)
    fi

    local user=''

    if [[ $DX_DEVHUB_USER != '' ]]
    then
        user+=" %{$fg[green]%}hub:(${DX_DEVHUB_USER})%{$reset_color%}"
    fi

    if [[ $DX_USER != '' ]]
    then
        user+=" %{$fg[green]%}scratch:(${DX_USER})%{$reset_color%}"
    fi
    
    echo $user
}

local dx_user_prompt='$(dx_user_prompt_fn)'

export PS1="$PS1${dx_user_prompt}"$'\n'"-> "
setopt promptsubst