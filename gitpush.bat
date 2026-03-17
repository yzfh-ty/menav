@echo off
chcp 65001 >nul
:: =============================================
:: 文件名：gitpush.bat
:: 用途：Windows 一键 git add + commit + push（自动英文消息只用“Modify bookmark information”）
:: 作者：已按要求简化消息 + 全中文提示
:: =============================================

echo 🚀 开始 Git 自动推送...

:: 1. 添加所有修改
git add .

:: 2. 检查是否有改动
git diff --cached --quiet
if %errorlevel% == 0 (
    echo ✅ 没有检测到更改，无需提交。
    exit /b 0
)

:: 3. 获取提交说明（直接回车 = 自动固定英文消息）
set "message="
set /p message=请输入提交说明（直接回车 = 自动生成英文消息）:

if "%message%"=="" (
    :: 自动生成固定英文消息（只用你指定的一句）
    set "message=Modify bookmark information"
    echo 🤖 使用自动英文消息: %message%
) else (
    echo 📝 使用你的消息: %message%
)

:: 4. 提交
git commit -m "%message%"

:: 5. 推送（自动当前分支）
for /f %%b in ('git branch --show-current') do set current_branch=%%b
git push origin %current_branch%

echo 🎉 推送完成！刷新 GitHub 查看更新～
pause