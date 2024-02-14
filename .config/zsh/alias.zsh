alias ..='cd ..'
alias branchclean='git branch --merged | grep -v "\*" | grep -v master | grep -v staging | xargs -n 1 git branch -d'
alias c='clear'
alias cdg='cd ~/Documents/Prog/GregsSandbox/'
alias cdm='cd ~/Documents/Prog/MyConfig'
alias cdp='cd ~/Documents/Prog/'
alias ghpr='gh pr checkout'
alias gitk='gitk --all'

alias gc='git commit'
alias gca='git commit --amend'
alias gce='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias grm='git rebase origin/main'
alias grmi='git rebase -i origin/main'

alias logj='jq -R -r ". as \$line | try (fromjson | \"[\" + .ts + \"][\" + (.level | ascii_upcase) + \"] \" + (if has(\"error\") then (.error + \" - \") else \"\" end)  + .msg + \" \" + (.block_number? | tostring) + \" (\" + .caller + \")\" + \"\\n\\t\" + (\$line|fromjson|del(.msg)|del(.ts)|del(.caller)|del(.level)|del(.block_number)|tostring)) catch \$line"'
alias ls='ls -Gh'
alias mcc='pushd $GITROOT/back; mvn clean install -DskipTests; popd'
alias mct='pushd $GITROOT/back; mvn clean test; popd'
alias mci='pushd $GITROOT/back; mvn clean install; popd'
alias nrb='pushd $GITROOT/front/cbs; npm run build; popd'
alias nrd='pushd $GITROOT/front/cbs; npm run dev; popd'
alias nrt='pushd $GITROOT/front/cbs; npm run test; popd'
alias mergeclean='rm $(find . -name "*BACKUP*");rm $(find . -name "*REMOTE*");rm $(find . -name "*LOCAL*");rm $(find . -name "*BASE*")'
alias mergedremotebranch='git branch -r --merged | grep origin | grep -v ">" | grep -v master | grep -v staging | grep -v "rc-" | xargs -L1'
alias nh='ssh nethack@eu.hardfought.org'
alias npmr='npm run'
alias npmrs='npm run -s'
alias origclean='find . -name "*.orig" -exec rm {} \;'
alias pm='python manage.py'
alias pmr='python manage.py runserver 0.0.0.0:8000'
alias pms='python manage.py shell_plus'
alias pmt='python manage.py test'
alias pmtk='LOG_LEVEL=WARNING python manage.py test -v 2 --keepdb'
alias pyclean='rm $(find . -name "*.pyc"); rm -r $(find . -name "__pycache__")'
alias rgall='rg --hidden --no-ignore'
alias sshadd='ssh-add ~/.ssh/id_rsa'
alias tf='terraform'
alias tiga='tig --all'
alias uuid='uuidgen | tr -d "\n" |  tr "[:upper:]" "[:lower:]" | pbcopy'
alias ys='yarn start'
alias yt='yarn test -- --verbose'
alias zor='zellij -l or'

cat()
{
  bat $@
}
unalias ll
ll()
{
  eza -la --git -F $@
}
alias l='ll'
tree()
{
  eza -la --git -F -T -I ".mypy_cache|.DS_Store|__pycache__|.git|node_modules" $@
}

if [ -f /usr/local/bin/nvim ]; then
  alias vi='/usr/local/bin/nvim'
elif [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
if [ -f /usr/local/bin/find ]; then
  alias find='/usr/local/bin/find'
fi
