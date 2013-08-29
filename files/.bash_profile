# PATH var
export PATH=/usr/local/bin/pear/bin:/usr/local/bin:/usr/bin/apache-ant:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:/usr/local/Cellar/ruby/1.9.2-p180/lib/ruby/gems/1.9.1/gems/capistrano-2.11.2/bin:/usr/local/bin/composer:/usr/local/Cellar/php54/5.4.12/bin:/usr/local/share/npm/bin:$PATH
export GIT_MERGE_AUTOEDIT=no

# Command Prompt (possibly overwritten later with colored Git prompt)
# export PS1="\W $ "

# Custom Aliases
alias ..="cd .."
alias la="ls -la"
alias stopmysql="sudo launchctl unload -w /Library/LaunchDaemons/com.mysql.mysqld.plist"
alias startmysql="sudo launchctl load -w /Library/LaunchDaemons/com.mysql.mysqld.plist"

# Git Aliases (kept in .gitconfig)

# SSH Aliases
alias sshstaging="ssh jwachte2@esgjhumktgst.esg.johnshopkins.edu"
alias sshwebuserstaging="ssh webuser@esgjhumktgst.esg.johnshopkins.edu"
alias sshprod="ssh jwachte2@esgjhumktgprod.esg.johnshopkins.edu"
alias sshwebuserprod="ssh webuser@esgjhumktgprod.esg.johnshopkins.edu"


# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.rvm/scripts/rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm/scripts/rvm" # Load RVM function


##
# Bash completion scripts
##

if type brew > /dev/null 2>&1 && [ -f `brew --prefix`/etc/bash_completion ]; then
  # Homebrew: http://mxcl.github.com/homebrew/
  . `brew --prefix`/etc/bash_completion
fi

if [ -f /contrib/completion/git-completion.bash ]; then
  # Git OS X Installer: http://code.google.com/p/git-osx-installer/
  . /contrib/completion/git-completion.bash
elif type brew > /dev/null 2>&1 && [ -f `brew --prefix`/etc/bash_completion ]; then
  # Homebrew: http://mxcl.github.com/homebrew/
  . `brew --prefix`/etc/bash_completion
elif [ -f /opt/local/etc/bash_completion.d/git ]; then
  # MacPorts: http://www.macports.org/
  . /opt/local/etc/bash_completion.d/git
fi

##
# Shell colors
##
BLACK="\[\e[0;30m\]"  BOLD_BLACK="\[\e[1;30m\]"  UNDER_BLACK="\[\e[4;30m\]"
RED="\[\e[0;31m\]"    BOLD_RED="\[\e[1;31m\]"    UNDER_RED="\[\e[4;31m\]"
GREEN="\[\e[0;32m\]"  BOLD_GREEN="\[\e[1;32m\]"  UNDER_GREEN="\[\e[4;32m\]"
YELLOW="\[\e[0;33m\]" BOLD_YELLOW="\[\e[1;33m\]" UNDER_YELLOW="\[\e[4;33m\]"
BLUE="\[\e[0;34m\]"   BOLD_BLUE="\[\e[1;34m\]"   UNDER_BLUE="\[\e[4;34m\]"
PURPLE="\[\e[0;35m\]" BOLD_PURPLE="\[\e[1;35m\]" UNDER_PURPLE="\[\e[4;35m\]"
CYAN="\[\e[0;36m\]"   BOLD_CYAN="\[\e[1;36m\]"   UNDER_CYAN="\[\e[4;36m\]"
WHITE="\[\e[0;37m\]"  BOLD_WHITE="\[\e[1;37m\]"  UNDER_WHITE="\[\e[4;37m\]"
NO_COLOR="\[\e[0m\]"

##
# Git shell prompt
#   requires Git bash completion to be installed
##
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

# alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"

export PS1="${PURPLE}\h${WHITE}[${YELLOW}\w${WHITE}]${WHITE}[${GREEN}\$(parse_git_branch)${RED}\$(parse_git_dirty)${WHITE}]${NO_COLOR} "
export PS2=" > "
export PS4=" + "

#show/hide hidden files
alias showhiddenfiles="defaults write com.apple.Finder AppleShowAllFiles TRUE && killall Finder && open /System/Library/CoreServices/Finder.app"
alias hidehiddenfiles="defaults write com.apple.Finder AppleShowAllFiles FALSE && killall Finder && open /System/Library/CoreServices/Finder.app"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
alias gethubimages="mkdir -p ~/vhosts/hub/public/factory/sites/default/files && scp webuser@esgjhumktgprod.esg.johnshopkins.edu:/var/www/html/hub/shared/files/* ~/vhosts/hub/public/factory/sites/default/files"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"