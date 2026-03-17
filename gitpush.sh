#!/bin/bash
# =============================================
# 文件名：gitpush.sh
# 用途：Linux 一键 git add + commit + push（自动英文消息只用“Modify bookmark information”）
# 作者：已按要求提供 Linux 版 + 全中文提示
# =============================================

echo "🚀 开始 Git 自动推送..."

# 1. 添加所有修改
git add .

# 2. 检查是否有改动
git diff --cached --quiet
if [ $? -eq 0 ]; then
    echo "✅ 没有检测到更改，无需提交。"
    exit 0
fi

# 3. 获取提交说明（直接回车 = 自动固定英文消息）
echo -n "请输入提交说明（直接回车 = 自动生成英文消息）: "
read message

if [ -z "$message" ]; then
    # 自动生成固定英文消息（只用你指定的一句）
    message="Modify bookmark information"
    echo "🤖 使用自动英文消息: $message"
else
    echo "📝 使用你的消息: $message"
fi

# 4. 提交
git commit -m "$message"

# 5. 推送（自动当前分支）
current_branch=$(git branch --show-current)
git push origin "$current_branch"

echo "🎉 推送完成！刷新 GitHub 查看更新～"
read -p "按回车键继续..."