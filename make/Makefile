# =========================================================================
# 顶层生成 & RTL 编译总控 Makefile  （mc8860）
# =========================================================================

#----------- 环境变量 ----------
PROJ_NAME := mc8860
PROJ_DIR  := /project/panweiho/MC8860/mc8860/../mc8860

# ---------- 顶层生成 ----------
top_gen:
mc8860_top_gen: top_gen_pre_handle top_gen_handle
mc8860_empty_top_gen: top_gen_after_handle

# ---------- RTL 编译变量 ----------
RTL_BUILD_WORK_PATH   := $(PROJ_DIR)/design/rtl/top/top_gen
RTL_BUILD_OUT_PATH    := /output/panweihao
RTL_BUILD_TILE_NAME   := chip_top

RTL_BUILD_ASIC_FILE   := -f $(PROJ_DIR)/../mc8860/design/vc/chip_top.vc

RTL_BUILD_EMPTY_FILE  := -f $(PROJ_DIR)/../mc8860/design/vc/aichip_common_incdir.vc \
                         -f $(PROJ_DIR)/../mc8860/design/vc/chip_top_empty.vc

RTL_BUILD_LINT_FILE   := -f $(PROJ_DIR)/../mc8860/design/vc/aichip_common_incdir.vc \
                         -f $(PROJ_DIR)/../mc8860/design/vc/chip_top_empty.vc

RTL_BUILD_ADD_OPTION  :=
RTL_BUILD_SGLIB_FILES := ./project/spyglass_all/mc8860/mc8860_sglib.vc
RTL_BUILD_XLSX_FILE   := $(PROJ_DIR)/../mc8860/design/rtl/common/glb_reg/cpfd_sys/cpfd_sys_glb.xlsx
RTL_BUILD_MEM_FILE    := /project/xujian/work_mc8860/svn/Mc8860/02_RD/02_AsIc/02_Architecture/memlist/MemList_Mc8860_MM.xls

# ---------- 引入公共子模块 ----------
include ~/script/Makefile.top_gen
include ~/script/Makefile.rtl_build
include ~/script/Makefile.git_gen


