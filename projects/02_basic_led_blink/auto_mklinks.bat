::将当前 CMD 窗口的编码设置为 UTF-8，以便正确显示脚本中的中文
chcp 65001 >nul
@echo off

:: 使用 PowerShell 自动请求管理员权限
fltmc >nul 2>&1 || (powershell start -verb runas '%0' & exit /b)

:: 切换到脚本所在目录
cd /d "%~dp0"

:: 如果存在同名目录或链接，先删除
if exist rt-thread (
    echo 删除已存在的 rt-thread
    rmdir rt-thread 2>nul
)
if exist libraries (
    echo 删除已存在的 libraries
    rmdir libraries 2>nul
)

:: 创建符号链接
echo 正在创建符号链接...
mklink /D rt-thread ..\..\rt-thread
if %errorlevel% neq 0 echo 创建 rt-thread 链接失败

mklink /D libraries ..\..\libraries
if %errorlevel% neq 0 echo 创建 libraries 链接失败

echo 操作完成，按任意键退出...
pause >nul