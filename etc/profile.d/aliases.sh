alias sudo='sudo '

alias ls='lsd --config-file /etc/lsd/config.yaml'
alias l='ls -l'
alias la='ls -la'
alias lt='ls --tree'

alias ports='sudo netstat -tupln'
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y'

alias ipp='curl ip-api.com -v'
alias ippx='curl ip-api.com -v --socks5-hostname 192.168.1.180:2080'

alias fwd='sudo firewall-cmd --list-all'
alias fwdstart='sudo systemctl restart firewalld'
alias fwdstop='sudo systemctl stop firewalld'
alias fwdstatus='sudo systemctl status firewalld'
alias fwdreload='sudo firewall-cmd --reload'

alias sgon='sudo systemctl restart sing-box'
alias sgoff='sudo systemctl stop sing-box'
alias sgstatus='sudo systemctl status sing-box'
alias sgcheck='sing-box check -c /etc/sing-box/config.json'

alias proxy='sudo proxychains4'
