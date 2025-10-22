#linux commands
alias cl = clear
def cls [] {
    clear
    ls
}
alias ls = ls -a

#nvim
# not using chatgpt atm
# alias v = pass show personal/chatgpt && nvim

alias v = nvim

#Git aliases
alias gs = git status

# Lazygit
alias gg = lazygit

#Copypath
alias copa = copypath

#Chezmoi
alias ch = chezmoi

#cd directly to specicif directorys
alias vc = cd ~/.config/nvim/

#Open directory in vim
def vcv [] {
    vc
    v
}
#vimwiki.

#edit settings.json for windows terminal
def vwts [] {
    cd /mnt/c/Users/hoaje/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/c
    v settings.json

} 
#xclip
alias xclip = xclip -sel clip

#Disabled couse not working in nushell
#browser
# alias edge = /mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe

#mvn
alias mci = mvn clean install
alias mcist = mvn clean install -DskipTests
alias msr = mvn spring-boot:run

#Print env variables
alias pe = printenv

#autohotkey
def autohotkey [] {
    cd "/mnt/c/Users/hoaje/OneDrive - Arbetsförmedlingen/AutoHotkey"
    v "window switcher.ahk"
} 

#Python
alias python = python3

#eza removed in nushell couse maybe not as needed?

#fd-find
alias fd = fdfind

alias dns-switch = sudo ~/dns-switch.sh

#vimwiki
alias ww = v ~/vimwiki/index.wiki

#mci skip test docker build och docker run
def mcidbdr [] {
    mci -DskipTests 
    docker build -f src/main/docker/Dockerfile -t informationshistorik-sor . 
    docker run --network krh -i --rm -p 8081:8081 -p 64001:64001 -e AF_MIJO=test -e ORAUSERNAME=aisfpr -e ORAPASSWORD=aisfpr --name informationshistorik-sor informationshistorik-sor;
}
