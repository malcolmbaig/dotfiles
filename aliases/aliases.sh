## ALIASES
  # TEXT EDITORS
alias n='nvim'

  # DIRECTORY SHORTCUTS
alias code='cd /Users/mo/code'
alias dotfiles='cd /Users/mo/Dropbox/_dev-env/dotfiles'
alias pnotes='cd /Users/mo/Dropbox/notes-personal'
alias wnotes='cd /Users/mo/Dropbox/notes-work'
alias dropbox='cd /Users/mo/Dropbox/'

  # GOLANG
alias gopath='cd $GOPATH'

  # GIT
  # status
alias gst="git status"
alias ga="git add"
alias gl="git log"
  # copy branch
alias cb="git symbolic-ref --short -q HEAD | tr -d '\n' | pbcopy"
  # wip
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
  # GitUp
alias gu="gitup open "

alias g='git'
alias gb='git branch'
alias gc='git commit --verbose'
alias gf='git fetch'
alias gs='git stash'

  # TMUX
alias t='tmux'
alias tl='tmux ls'
alias tn='tmux new -s '
alias ta='tmux a -t '
alias tk='tmux kill-session -t '
alias mux='tmuxinator'

  # RUBY/RAILS
alias be='bundle exec'
alias bs='bin/spring'
alias cuke='cucumber -f progress'

  # CLI
alias ls='ls -FGfho'
alias lsp='CLICOLOR_FORCE=1 ls -FGfho | less -R' # ls with paging
alias lsd='ls -d */' # ls directories only
alias psg='ps x | grep '
alias tailn='tail -n'
alias tailf='tail -f'
alias k9='kill -9'
alias show256colors='for code in {000..255}; do print -P -- "$code: %F{$code}Test%f"; done'
alias del="rmtrash"
alias wttr="curl -4 http://wttr\.in/london"
alias ia="open $1 -a /Applications/iA\ Writer.app"
if [ -x "$(command -v brew)" ]; then
  alias ctags="`brew --prefix`/bin/ctags"
fi
