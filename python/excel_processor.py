import sys
import openpyxl
import shutil
from datetime import datetime, timedelta
from openpyxl.utils import range_boundaries
import os

def copy_template_with_yesterday_date(template_file="./workspace/内衣销售数据.xlsx"):
    
    try:
        old_path = os.getcwd()
        # 切到模板所在目录，避免路径问题
        template_dir = os.path.dirname(os.path.abspath(template_file))
        os.chdir(template_dir)
        template_file = os.path.basename(template_file)   # 去掉路径，只保留文件名
        # 获取昨天的日期
        yesterday = datetime.now() - timedelta(days=1)
        
        # 格式化日期为中文格式：1月8日
        date_str = yesterday.strftime("%-m月%d日")  # %#m 去掉前导0
        
        # 获取文件扩展名
        file_extension = os.path.splitext(template_file)[1]
        
        # 生成新文件名
        new_filename = f"{date_str}{template_file}"
        
        # 检查模板文件是否存在
        if not os.path.exists(template_file):
            print(f"❌ 错误: 模板文件 '{template_file}' 不存在")
            return False
        
        # 如果目标文件已存在，先删除
        if os.path.exists(new_filename):
            os.remove(new_filename)
            print(f"✓ 已删除已存在的文件: {new_filename}")
        
        # 复制文件
        shutil.copy2(template_file, new_filename)
        
        print(f"✅ 成功创建文件: {new_filename}")
        print(f"📅 昨天的日期: {date_str}")
        os.chdir(old_path)
        return new_filename
        
    except Exception as e:
        print(f"❌ 处理过程中出现错误: {str(e)}")
        return False
#{{{
def copy_template_with_custom_date(template_file="内衣销售数据模板.xlsx", days_ago=1):
    """
    复制模板文件并在文件名前加上指定天前的日期
    
    参数:
        template_file: 模板文件路径
        days_ago: 几天前，默认为1（昨天）
    """
    try:
        # 获取指定天前的日期
        target_date = datetime.now() - timedelta(days=days_ago)
        
        # 格式化日期为中文格式
        date_str = target_date.strftime("%#m月%d日")
        
        # 获取文件扩展名
        file_extension = os.path.splitext(template_file)[1]
        
        # 生成新文件名
        new_filename = f"{date_str}{template_file}"
        
        # 检查模板文件是否存在
        if not os.path.exists(template_file):
            print(f"❌ 错误: 模板文件 '{template_file}' 不存在")
            return False
        
        # 如果目标文件已存在，先删除
        if os.path.exists(new_filename):
            os.remove(new_filename)
            print(f"✓ 已删除已存在的文件: {new_filename}")
        
        # 复制文件
        shutil.copy2(template_file, new_filename)
        
        print(f"✅ 成功创建文件: {new_filename}")
        print(f"📅 日期: {date_str} ({days_ago}天前)")
        
        return new_filename
        
    except Exception as e:
        print(f"❌ 处理过程中出现错误: {str(e)}")
        return False
#}}}

#copy start================================================
SELL_RANGES = [(6, 16), (18, 25), (27, 35), (37, 38), (40, 48), (50, 52), (54, 55), (57, 59)]
ROW_RANGES = [(65, 75), (77, 84), (86, 94),
            (96, 97), (99, 107), (109, 111),
            (113, 114), (116, 118)]

def copy_ranges(src_path, dst_path):
    # 1. 解析路径
    src_path = os.path.abspath(src_path)
    dst_path = os.path.abspath(dst_path)

    if not os.path.isfile(src_path):
        sys.exit(f'❌ 源文件不存在：{src_path}')

    # 2. 确保输出目录存在
    os.makedirs(os.path.dirname(dst_path), exist_ok=True)

    wb_src = openpyxl.load_workbook(src_path, data_only=True)
    ws_src = wb_src.active

    # 如果输出文件不存在，先复制一份模板（避免空文件报错）
    if not os.path.isfile(dst_path):
        wb_dst = openpyxl.Workbook()
        wb_dst.save(dst_path)
    wb_dst = openpyxl.load_workbook(dst_path)
    ws_dst = wb_dst.active

    # 3. 复制数据
    dst_row = 2
    for start, end in SELL_RANGES:
        for r in range(start, end + 1):
            ws_dst.cell(row=dst_row, column=3,
                        value=ws_src.cell(row=r, column=12).value)
            dst_row += 1

    wb_dst.save(dst_path)
    wb_src.close(); wb_dst.close()
    print(f'✅ 已复制 {dst_row-2} 条数据 → {os.path.basename(dst_path)}')


def pick_one_per_row(ws, row):
    """
    返回 J/K/L 三列里唯一有值的单元格值；
    若多列有值，优先 J > K > L；都无值返回 None
    """
    j = ws.cell(row=row, column=10).value   # J
    k = ws.cell(row=row, column=11).value  # K
    l = ws.cell(row=row, column=12).value  # L
    for v in (j, k, l):
        if v is not None and str(v).strip() != '':
            return v
    return None

def copy_j_ranges(src_path, dst_path):
    src_path = os.path.abspath(src_path)
    dst_path = os.path.abspath(dst_path)
    if not os.path.isfile(src_path):
        sys.exit(f'❌ 源文件不存在：{src_path}')

    os.makedirs(os.path.dirname(dst_path), exist_ok=True)

    wb_src = openpyxl.load_workbook(src_path, data_only=True)
    ws_src = wb_src.active

    # 1. 收集每行唯一值
    values = []
    for start, end in ROW_RANGES:
        for r in range(start, end + 1):
            val = pick_one_per_row(ws_src, r)
            values.append(val)

    # 2. 写入目标文件 D 列（从第 2 行开始）
    if os.path.isfile(dst_path):
        wb_dst = openpyxl.load_workbook(dst_path)
    else:
        wb_dst = openpyxl.Workbook()
    ws_dst = wb_dst.active

    for idx, val in enumerate(values, start=2):
        ws_dst.cell(row=idx, column=4, value=val)

    
    yyyymmdd = int((datetime.now() - timedelta(days=1)).strftime('%Y%m%d'))  # 20260113
    for r in range(2, 48):  # 2–48 行
        ws_dst.cell(row=r, column=2, value=yyyymmdd)
    print(yyyymmdd)
    
    wb_dst.save(dst_path)
    wb_src.close(); wb_dst.close()
    print(f'✅ 已写入 {len(values)} 行数据 → {os.path.basename(dst_path)}')
    
if __name__ == "__main__":
    print("Excel模板文件复制工具")
    print("=" * 40)
    
    # 使用方法1：复制昨天的文件
    result = copy_template_with_yesterday_date()
    des_file = os.path.join("./workspace", result)
    if result:
        print("=" * 40)
        print("✅ 复制完成！")
        print(f"新文件名: {result}")
    else:
        print("=" * 40)
        print("❌ 复制失败！")


    #if len(sys.argv) != 2:
     #   sys.exit('用法：python excel_processor.py <a.xlsx>')
    #copy_ranges(sys.argv[1], des_file)
   # print("visit begin")
   # copy_j_ranges(sys.argv[1], des_file)

    if len(sys.argv) != 2:
        sys.exit('用法 : python excel_processor.py <a.xlsx>')

    try:
        copy_ranges(sys.argv[1], des_file)
        print("visitbegin")
        copy_j_ranges(sys.argv[1], des_file)
    except Exception as e:
        print('运行出错：', e)
        sys.exit(1)
