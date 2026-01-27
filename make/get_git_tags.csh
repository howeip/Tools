#!/bin/csh -f
#-----------------------------------------------------------
# 批量读取 CSV → 切到对应仓库 → 检出指定 TAG
# 用法：git_gen.sh <tag_csv> <expected_repo_count>
#-----------------------------------------------------------

if ($#argv != 2) then
    echo "Error:need one argument"
    echo "Usage: $0 <tag_csv> <expected_repo_count>"
    exit 1
endif

set tag_csv = $1
set git_num = $2
set line_cnt = 0
set git_cnt = 0

alias show_banner 'echo ""; echo "************************************************"; echo "\!*"; echo ""'

foreach line (`cat $tag_csv`)
    @ line_cnt++
    if ("$line" == "") then
        continue
    endif
    # 按逗号拆成两部分：仓库路径 与 TAG 名
    set parts = ($line:as/,/ /)
    if ($#parts != 2) then
        echo "Line $line_cnt format error!"
        exit 1
    endif

    set git_dir  = $parts[1]
    set tag_str  = $parts[2]

    # 目录存在性检查
    if (! -d "$PROJ_DIR/../$git_dir") then
        echo "ERROR: $PROJ_DIR/../$git_dir does not exist or is not a directory"
        exit 1
    endif

    cd "$PROJ_DIR/../$git_dir"
    if (! -d .git) then
        echo "ERROR: $PROJ_DIR/../$git_dir is not a GIT repository"
        exit 1
    endif

    # 拉取最新标签 → 切到 master → 更新 → 切到目标 TAG
    git fetch --tags
    if (`git tag -l "$tag_str" | wc -l` == 0) then
        echo "ERROR: TAG \"$tag_str\" does not exist"
        exit 1
    endif

    git checkout master
    git pull --no-rebase
    git checkout "$tag_str"
    git branch                    # 仅用于显示当前 HEAD 指向
    git describe --tags           # 确认已落在 TAG 上

    @ git_cnt++
end

# 数量校验
if ($git_cnt != $git_num) then
    echo "Missing some repos! Expected: $git_num; Tagged: $git_cnt"
    exit 1
endif

show_banner "MAKE TAG DONE"
exit 0
