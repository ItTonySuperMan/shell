@echo off
:: 检查是否以管理员权限运行，如果不是则重新启动脚本以管理员身份运行
:: 判断是否具有管理员权限
openfiles >nul 2>nul
if %errorlevel% neq 0 (
    echo 当前没有管理员权限，正在尝试以管理员身份运行...
    :: 重新启动脚本为管理员
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb runAs"
    exit /b
)

:: 清理图标和缩略图缓存
echo 正在清理图标和缩略图缓存...
powershell -Command "Remove-Item '%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*' -Include 'thumbcache_*.db', 'iconcache*.db' -Force"

:: 删除其他缓存
echo 正在清理其他缓存...
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.db"

:: 结束当前资源管理器进程
echo 正在结束当前资源管理器进程...
taskkill /f /im explorer.exe

:: 重新启动资源管理器
echo 正在重新启动资源管理器...
start explorer.exe

echo 缓存清理完成。
pause
