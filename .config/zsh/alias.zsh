alias ..='cd ..'
alias branchclean='git branch --merged | grep -v "\*" | grep -v master | grep -v staging | xargs -n 1 git branch -d'
alias c='clear'
alias cdg='cd ~/Documents/Prog/GregsSandbox/'
alias cdm='cd ~/Documents/Prog/MyConfig'
alias cdp='cd ~/Documents/Prog/'
alias ghpr='gh pr checkout'
alias gitk='gitk --all'
alias ls='ls -Gh'
alias logj='jq -R -r ". as \$line | try (fromjson | \"[\" + .ts + \"][\" + (.level | ascii_upcase) + \"] \" + (if has(\"error\") then (.error + \" - \") else \"\" end)  + .msg + \" \" + (.block_number? | tostring) + \" (\" + .caller + \")\" + \"\\n\\t\" + (\$line|fromjson|del(.msg)|del(.ts)|del(.caller)|del(.level)|del(.block_number)|tostring)) catch \$line"'
alias mergeclean='rm $(find . -name "*BACKUP*");rm $(find . -name "*REMOTE*");rm $(find . -name "*LOCAL*");rm $(find . -name "*BASE*")'
alias mergedremotebranch='git branch -r --merged | grep origin | grep -v ">" | grep -v master | grep -v staging | grep -v "rc-" | xargs -L1'
alias npmr='npm run'
alias npmrs='npm run -s'
alias origclean='rm $(find . -name "*.orig")'
alias pm='python manage.py'
alias pmr='python manage.py runserver 0.0.0.0:8000'
alias pms='python manage.py shell_plus'
alias pmt='python manage.py test'
alias pmtk='LOG_LEVEL=WARNING python manage.py test -v 2 --keepdb'
alias pyclean='rm $(find . -name "*.pyc"); rm -r $(find . -name "__pycache__")'
alias rgall='rg --hidden --no-ignore'
alias sshadd='ssh-add ~/.ssh/id_rsa'
alias tf='terraform'
alias ys='yarn start'
alias yt='yarn test -- --verbose'

cat()
{
  bat $@
}
unalias ll
ll()
{
  exa -la --git -F $@
}
alias l='ll'
tree()
{
  exa -la --git -F -T -I ".mypy_cache|.DS_Store|__pycache__|.git|node_modules" $@
}

if [ -f /usr/local/bin/nvim ]; then
  alias vi='/usr/local/bin/nvim'
elif [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
if [ -f /usr/local/bin/find ]; then
  alias find='/usr/local/bin/find'
fi
