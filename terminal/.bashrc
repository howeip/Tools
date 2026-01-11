#========================================================
#  Minimal but practical  ~/.bashrc   (bash ≥ 4)
#========================================================

#--------------------------------------------------------
# 0. 平台判定
#--------------------------------------------------------
case "$(uname -s)" in
    Linux*)  PLATFORM=LINUX64 ;;
    Darwin*) PLATFORM=MACOS   ;;
    *)       PLATFORM=UNKNOWN ;;
esac
export PLATFORM

#--------------------------------------------------------
# 1. 彩色终端开关函数
#    set_color_on  /  set_color_off
#--------------------------------------------------------
set_color_on(){
    # 使用 ANSI 颜色
    RED='\[\033[1;31m\]'
    GREEN='\[\033[0;32m\]'
    YELLOW='\[\033[1;33m\]'
    BLUE='\[\033[1;34m\]'
    MAGENTA='\[\033[1;35m\]'
    CYAN='\[\033[1;36m\]'
    WHITE='\[\033[0;37m\]'
    RESET='\[\033[0m\]'
    PS1="${GREEN}\u${RED}@${MAGENTA}\h${BLUE}:${CYAN}\w${WHITE}\\\$${RESET} "
}
set_color_off(){
    unset RED GREEN YELLOW BLUE MAGENTA CYAN WHITE RESET
    PS1='\u@\h:\w\$ '
}
# 默认打开
set_color_on

#--------------------------------------------------------
# 2. ls 颜色
#--------------------------------------------------------
export CLICOLOR=yes        # macOS 需要
export LSCOLORS=ExGxFxdxCxegedabagExEx
# Linux 用 LS_COLORS（bash 5 已自带 dircolors）
if [[ -x /usr/bin/dircolors && -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
elif [[ -x /usr/bin/dircolors ]]; then
    eval "$(dircolors -b)"
fi
alias ls='ls --color=auto' 2>/dev/null || alias ls='ls -G'  # macOS 用 -G

#--------------------------------------------------------
# 3. grep 高亮
#--------------------------------------------------------
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#--------------------------------------------------------
# 4. 安全选项 / 历史
#--------------------------------------------------------
# 更大的历史
HISTSIZE=5000
HISTFILESIZE=10000
# 避免重复、实时写入
shopt -s histappend
HISTCONTROL=ignoredups:erasedups
# 拼写纠正（bash 4+）
shopt -s cdspell dirspell 2>/dev/null

#--------------------------------------------------------
# 5. 常用 alias（按功能分组）
#--------------------------------------------------------
#--- 安全类 ------------------------------
#alias rm='rm -i'
#alias mv='mv -i'
#alias cp='cp -i'

#--- 目录与文件 --------------------------
alias la='ls -A'          # 不含 . 和 ..
alias ll='ls -alh'
alias lr='ls -R'
alias ..='cd ..'
alias ...='cd ../..'

#--- 磁盘用量 ----------------------------
alias dh='df -h -a -T'
alias ds='du -sh'

#--- 编辑器 ------------------------------
alias g='gvim'
alias xv='vimx'            # 如果装了
alias subl='sublime_text'  # 如果装了

#--- Git 快捷 ----------------------------
alias gpull='git pull origin HEAD:refs/for/master'
alias gpush='git push origin HEAD:refs/for/master'

#--------------------------------------------------------
# 6. 语言环境
#--------------------------------------------------------
# 中文
alias setlang-cn='export LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8'
# 英文
alias setlang-en='export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8'
# C / POSIX
alias setlang-c='unset LC_ALL; export LANG=C'

# 默认英文
setlang-en

#--------------------------------------------------------
# 7. 工具链加载（按需打开）
#--------------------------------------------------------
export TOOLS=/global/tools
export FREEFREWARE=${TOOLS}/freeware

# module 命令需要先装 environment-modules 或 lmod
module() { eval "$(/usr/bin/modulecmd bash "$@")"; } 2>/dev/null || true

# 示例：仅当 module 可用时才加载
if command -v module >/dev/null 2>&1; then
    module load git/2.33.0
    module load Python/3.10
    module load sublime/sublime_text_3
fi

#--------------------------------------------------------
# 8. 用户私有区 —— 把自己的东西放这里
#--------------------------------------------------------
# source ~/.my_private.sh
# export PROJ_HOME=/your/project/root
# ...
