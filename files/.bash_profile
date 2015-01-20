# PATH var
export PATH=$HOME/.node/bin:$HOME/.ruby/default/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Turn off setting so git won't ask for commit message on merge
export GIT_MERGE_AUTOEDIT=no

# Change default installation for ruby gems
export GEM_HOME=$HOME/.ruby/default

# Command Prompt (possibly overwritten later with colored Git prompt)
# export PS1="\W $ "

# Custom Aliases
alias ..="cd .."
alias bp="source ~/.bash_profile"
alias brkt="open -a \"Brackets\" $*"
alias gs="git st"
alias jhu="cd ~/www/jhu/"
alias la="ls -la"
alias machado="cd ~/www/jhu/public/assets/themes/machado"

function new-terminal-tab () {
  projectDirectory=$(pwd)
  echo "Project directory set to \"$projectDirectory\""

  osascript -e "tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down"\
            -e "tell application \"Terminal\" to do script \"cd $projectDirectory\" in selected tab of the front window"
}

function prepare-browser () {
  browser=""

  if [ $1 ]; then
    if [ $1 = "chrome" ] || [ $1 = "Chrome" ] || [ $1 = "Google Chrome" ] || [ $1 = "Google\ Chrome" ]; then
      browser="Google Chrome"
      echo "Browser set to \"$browser\""
    elif [ $1 = "safari" ] || [ $1 = "Safari" ]; then
      browser="Safari"
      echo "Browser set to \"$browser\""
    elif [ $1 = "firefox" ] || [ $1 = "Firefox" ]; then
      browser="Firefox"
      echo "Browser set to \"$browser\""
    else
      browser="$1"
      echo "Browser set to \"$browser\""
    fi
  else
    browser="Google Chrome"
    echo "Browser defaulted to \"$browser\""
  fi

  osascript -e "set B to \"$browser\""\
            -e "tell application B to activate"
}

function define-project-server () {
  projectServer=""
  projectURL=""

  if [ $1 ]; then
    projectServer="localhost:$1"
    echo "Project server set to \"$projectServer\""
  else
    projectServer="localhost:4000"
    echo "Project server defaulted to \"$projectServer\""
  fi

  projectURL="http://$projectServer/"
  echo "Project URL set to \"$projectURL\""
}

function launch-project-server () {
  define-project-server $1
  
  php -S $projectServer -t public/
}

function launch-project-browser () {
  define-project-server $1

  prepare-browser $2

  osascript -e "tell application \"$browser\" to open location \"$projectURL\""
}

function open-project () {
  appOpenCommand=""
  appFullName=""

  if [ $1 ]; then
    if [ $1 = "subl" ] || [ $1 = "Sublime" ] || [ $1 = "Sublime Test" ] || [ $1 = "Sublime\ Text" ]; then
      appOpenCommand="subl"
      appFullName="Sublime Text"
      echo "Editing app set to \"$appFullName\""
    elif [ $1 = "atom" ] || [ $1 = "Atom" ]; then
      appOpenCommand="atom"
      appFullName="Atom"
      echo "Editing app set to \"$appFullName\""
    elif [ $1 = "brkt" ] || [ $1 = "brackets" ] || [ $1 = "Brackets"]; then
      appOpenCommand="brkt"
      appFullName="Brackets"
      echo "Editing app set to \"$appFullName\""
    else
      browser="$1"
      echo "Editing app set to \"$appFullName\""
    fi
    appFullName="$1"
    echo "Editing app set to \"$appFullName\""
  else
    appOpenCommand="subl"
    appFullName="Sublime Text"
    echo "Editing app defaulted to \"$appFullName\""
  fi

  osascript -e "tell application \"Terminal\" to do script \"$appOpenCommand .\" in selected tab of the front window"
}

function project-GO () {
  if [ ! -d "./public" ]; then
    gulp
  fi

  osascript -e "tell application \"Terminal\" to activate"\
            -e "tell application \"Terminal\" to do script \"launch-project-server $1\" in selected tab of the front window"

  new-terminal-tab

  osascript -e "tell application \"Terminal\" to do script \"gulp watch\" in selected tab of the front window"

	new-terminal-tab

  osascript -e "tell application \"Terminal\" to do script \"launch-project-browser $1 $3\" in selected tab of the front window"\
            -e "tell application \"Terminal\" to do script \"open-project $2\" in selected tab of the front window"
}

function open-jhu-where () {
  if [ $1 ]; then
    if [ $1 = machado ] || [ $1 = Machado ]; then
      machado
      echo "Opening machado directory"
    elif [ $1 = jhu ] || [ $1 = JHU ]; then
      jhu
      echo "Opening jhu directory"
    else 
      $1
      echo "Attempting to open $1 directory"
    fi
  else
    machado
    echo "Opening machado directory"
  fi
}

function launch-jhu-browser () {
  prepare-browser $1

  osascript -e "tell application \"$browser\" to open location \"http://local.jhu.edu\""
}

function jhu-GO () {
  osascript -e "tell application \"Terminal\" to activate"\
            -e "tell application \"Terminal\" to do script \"jhu\" in selected tab of the front window"\
            -e "tell application \"Terminal\" to do script \"vagrant up --provision\" in selected tab of the front window"\
            -e "tell application \"Terminal\" to do script \"YOUR PASSWORD\" in selected tab of the front window"

  new-terminal-tab

  osascript -e "tell application \"Terminal\" to do script \"machado\" in selected tab of the front window"\
            -e "tell application \"Terminal\" to do script \"gulp watch\" in selected tab of the front window"

  new-terminal-tab

  osascript -e "tell application \"Terminal\" to do script \"open-jhu-where $1\" in selected tab of the front window"\
            -e "tell application \"Terminal\" to do script \"launch-jhu-browser $3\" in selected tab of the front window"\
            -e "tell application \"Terminal\" to do script \"open-project $2\" in selected tab of the front window"
}

# alias stopmysql="sudo launchctl unload -w /Library/LaunchDaemons/com.mysql.mysqld.plist"
# alias startmysql="sudo launchctl load -w /Library/LaunchDaemons/com.mysql.mysqld.plist"

# Show/hide hidden files
alias showhiddenfiles="defaults write com.apple.Finder AppleShowAllFiles TRUE && killall Finder && open /System/Library/CoreServices/Finder.app"
alias hidehiddenfiles="defaults write com.apple.Finder AppleShowAllFiles FALSE && killall Finder && open /System/Library/CoreServices/Finder.app"

# Download ALL images from Hub production database. Hint: You have to be on JHU network or VPN
# alias gethubimages="mkdir -p ~/vhosts/hub/public/factory/sites/default/files && scp webuser@esgjhumktgprod.esg.johnshopkins.edu:/var/www/html/hub/shared/files/* ~/vhosts/hub/public/factory/sites/default/files"


# Git Aliases (kept in .gitconfig)

# SSH Aliases
alias sshstaging="ssh econrad2@esgjhumktgst.esg.johnshopkins.edu"
alias sshwebuserstaging="ssh webuser@esgjhumktgst.esg.johnshopkins.edu"
alias sshprod="ssh econrad2@esgjhumktgprod.esg.johnshopkins.edu"
alias sshwebuserprod="ssh webuser@esgjhumktgprod.esg.johnshopkins.edu"


# RVM
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# [[ -s "$HOME/.rvm/scripts/rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm/scripts/rvm" # Load RVM function

# rbenv (the better ruby version manager, IMO)
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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

source `xcode-select --print-path`/usr/share/git-core/git-completion.bash
source `xcode-select --print-path`/usr/share/git-core/git-prompt.sh

export PS1="${CYAN}\u@\h${WHITE}[${YELLOW}\w${WHITE}]\$(__git_ps1 '${WHITE}[${BOLD_GREEN}%s${BOLD_RED}'\$(parse_git_dirty)'${WHITE}]')${WHITE}${NO_COLOR} $ "
export PS2=" > "
export PS4=" + "

# export GIT_PS1_SHOWDIRTYSTATE="1"

# export PS1="${CYAN}\u@\h${WHITE}[${YELLOW}\w${WHITE}] $(__git_ps1)${NO_COLOR} $ "
# export PS2=" > "
# export PS4=" + "


### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
