#!/bin/bash
# =============================================
# 文件名：gitpush
# 用途：一键 add + commit + push（自动消息强制英文）
# 作者：已按要求改成英文 commit message
# =============================================

echo "🚀 Starting Git auto push..."

# 1. 添加所有修改
git add .

# 2. 检查是否真的有改动
if git diff --cached --quiet; then
    echo "✅ No changes detected, nothing to commit."
    exit 0
fi

# 3. 获取提交说明（核心：自动生成英文）
echo "请输入提交说明（直接回车 = 自动生成英文消息）："
read -r message

if [ -z "$message" ]; then
    # 自动生成英文消息（你最想要的！）
    changed_files=$(git diff --cached --name-only | wc -l)
    message="Auto update at $(date '+%Y-%m-%d %H:%M:%S') - Modified ${changed_files} files"
    echo "🤖 Using auto English message: ${message}"
else
    echo "📝 Using your message: ${message}"
fi

# 4. 提交（英文消息已确保）
git commit -m "$message"

# 5. 推送（自动使用当前分支）
current_branch=$(git branch --show-current)
git push origin "$current_branch"

echo "🎉 Push completed! Refresh GitHub to see the update～"