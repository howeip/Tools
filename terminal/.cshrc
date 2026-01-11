#========================================================
#  Minimal but practical  ~/.cshrc   (tcsh/csh)
#========================================================

#--------------------------------------------------------
# 0. 平台判定
#--------------------------------------------------------
switch ( `uname -s` )
case Linux:
    setenv PLATFORM  LINUX64
    breaksw
case Darwin:
    setenv PLATFORM  MACOS
    breaksw
default:
    setenv PLATFORM  UNKNOWN
endsw

#--------------------------------------------------------
# 1. 彩色终端开关函数
#    (set_color_on / set_color_off)
#--------------------------------------------------------
alias set_color_on  \
'set red="%{\033[1;31m%}" ; set green="%{\033[0;32m%}" ; set yellow="%{\033[1;33m%}" ; set blue="%{\033[1;34m%}" ; set magenta="%{\033[1;35m%}" ; set cyan="%{\033[1;36m%}" ; set white="%{\033[0;37m%}" ; set pend="%{\033[0m%}" ; set prompt="${green}%n${red}@${magenta}%m: ${blue}%~${white}%%${pend} "'

alias set_color_off  \
'unset red green yellow blue magenta cyan white pend ; set prompt="%n@%m:%~%% "'

# 默认打开
set_color_on

#--------------------------------------------------------
# 2. ls 颜色
#--------------------------------------------------------
setenv CLICOLOR        yes
setenv LSCOLORS        ExGxFxdxCxegedabagExEx

#--------------------------------------------------------
# 3. grep 高亮
#--------------------------------------------------------
setenv GREP_OPTIONS    --color=auto

#--------------------------------------------------------
# 4. 自动补全 / 拼写纠正
#--------------------------------------------------------
set autolist = ambiguous
set complete = enhance
set correct  = cmd

#--------------------------------------------------------
# 5. 常用 alias
#--------------------------------------------------------
#--- 安全类 ------------------------------
#alias rm   'rm -i'
#alias mv   'mv -i'
#alias cp   'cp -i'

#--- 目录与文件 --------------------------
alias la   'ls -al'
alias ll   'ls -lh'
alias lr   'ls -R'
alias ..   'cd ..'
alias ...  'cd ../..'

#--- 磁盘用量 ----------------------------
alias dh   'df -h -a -T'
alias ds   'du -sh'

#--- 编辑器 ------------------------------
alias g    'gvim'
alias xv   'vimx'
alias subl 'sublime_text'

#--- Git 快捷 ----------------------------
alias gpull 'git pull origin HEAD:refs/for/master'
alias gpush 'git push origin HEAD:refs/for/master'

#--------------------------------------------------------
# 6. 语言环境
#--------------------------------------------------------
# 中文
alias setlang-cn 'setenv LC_ALL zh_CN.UTF-8 && setenv LANG zh_CN.UTF-8'
# 英文
alias setlang-en 'setenv LC_ALL en_US.UTF-8 && setenv LANG en_US.UTF-8'
# C/POSIX
alias setlang-c  'unsetenv LC_ALL && setenv LANG C'

# 默认英文
setlang-en

#--------------------------------------------------------
# 7. 工具链加载（按需打开）
#--------------------------------------------------------
# 例：Git / Python / Sublime
setenv TOOLS    /global/tools
setenv FREEWARE ${TOOLS}/freeware

module load git/2.33.0
module load Python/3.10
module load sublime/sublime_text_3

#--------------------------------------------------------
# 8. 用户私有区 —— 把自己的东西放这里
#--------------------------------------------------------
# source ~/my_private.csh
# setenv PROJ_HOME /your/project/root
if ( -f ~/.alias ) source ~/.alias
# ...
