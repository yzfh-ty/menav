@echo off
chcp 65001 >nul
:: =============================================
:: 文件名：gitpush.bat
:: 用途：Windows 一键 git add + commit + push（自动英文消息已改为“Modify bookmark information”）
:: 作者：已按要求修改推送提示
:: =============================================

echo 🚀 Starting Git auto push...

:: 1. 添加所有修改
git add .

:: 2. 检查是否有改动
git diff --cached --quiet
if %errorlevel% == 0 (
    echo ✅ No changes detected, nothing to commit.
    exit /b 0
)

:: 3. 获取提交说明（直接回车 = 自动英文“Modify bookmark information”）
set "message="
set /p message=请输入提交说明（直接回车 = 自动生成英文消息）:

if "%message%"=="" (
    :: 自动生成英文消息（已改为你指定的“修改书签信息”英文版）
    for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set "dt=%%a"
    set "year=%dt:~0,4%"
    set "month=%dt:~4,2%"
    set "day=%dt:~6,2%"
    set "hour=%dt:~8,2%"
    set "min=%dt:~10,2%"
    set "sec=%dt:~12,2%"
    set "datetime=%year%-%month%-%day% %hour%:%min%:%sec%"

    for /f %%i in ('git diff --cached --name-only ^| find /c /v ""') do set changed_files=%%i

    set "message=Modify bookmark information at %datetime% - Modified %changed_files% files"
    echo 🤖 Using auto English message: %message%
) else (
    echo 📝 Using your message: %message%
)

:: 4. 提交
git commit -m "%message%"

:: 5. 推送（自动当前分支）
for /f %%b in ('git branch --show-current') do set current_branch=%%b
git push origin %current_branch%

echo 🎉 Push completed! Refresh GitHub to see the update～
pause