alias ls='lsd --config-file /etc/lsd/config.yaml'
alias l='ls -l'
alias la='ls -la'
alias lt='ls --tree'

alias ports='netstat -tupln'
alias update='apt update && apt full-upgrade -y && apt autoremove -y && apt clean -y'

alias ipp='curl ip-api.com -v'
alias ippx='curl ip-api.com -v --socks5-hostname 192.168.1.180:2080'

alias fwd='firewall-cmd --list-all'
alias fwdstart='systemctl restart firewalld'
alias fwdstop='systemctl stop firewalld'
alias fwdstatus='systemctl status firewalld'
alias fwdreload='firewall-cmd --reload'

alias sgon='systemctl restart sing-box'
alias sgoff='systemctl stop sing-box'
alias sgstatus='systemctl status sing-box'
alias sgcheck='sing-box check -c /etc/sing-box/config.json'

alias proxy='proxychains4'
