VIM配置流程

# GVIM基础配置

## 下载GVIM

1.  Debian / Ubuntu / Linux Mintr如下：

2.  sudoapt update

3.  sudoaptinstall vim-gtk3

## 下载.vimrc

1.  wget https://github.com/howeip/tools/raw/main/gvim -O gvim && chmod
    +x gvim

2.  放到\~即可，不需要source

## 下载vundle

1.  git clone git@github.com:VundleVim/Vundle.vim.git
    \~/.vim/bundle/Vundle.vim

## 下载vundle插件

1.  打开.vimrc中vundle板块，中文注释间的插件

2.  在.vimrc里面输入:PluginInstall ，然后回车。

3.  会弹出一个垂直分割窗口，开始 clone 或更新插件；等左下角状态条回到
    "Done" 即可。

4.  安装完 **重启 gvim**，插件立即生效。

5.  以后想增/删插件，同样是在 gvim 里 :PluginInstall（增）或
    :PluginClean（删）。

# 自动化集成工具

## automatic

支持时序图绘制（TimeWave）

支持快速插入代码段（Snippet）

支持自动生成标准文件头（Header）

支持快速注释（Comment）

自动例化（AutoInst）

自动参数（AutoPara）

自动寄存器（AutoReg）

自动线网（AutoWire）

自动定义（AutoDef）

自动声明（AutoArg）

通过RtlTree浏览Rtl结构

1.  git clone git@github.com:HonkW93/automatic-verilog.git
