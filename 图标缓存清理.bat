@echo off
:: ����Ƿ��Թ���ԱȨ�����У�������������������ű��Թ���Ա�������
:: �ж��Ƿ���й���ԱȨ��
openfiles >nul 2>nul
if %errorlevel% neq 0 (
    echo ��ǰû�й���ԱȨ�ޣ����ڳ����Թ���Ա�������...
    :: ���������ű�Ϊ����Ա
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb runAs"
    exit /b
)

:: ����ͼ�������ͼ����
echo ��������ͼ�������ͼ����...
powershell -Command "Remove-Item '%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*' -Include 'thumbcache_*.db', 'iconcache*.db' -Force"

:: ɾ����������
echo ����������������...
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.db"

:: ������ǰ��Դ����������
echo ���ڽ�����ǰ��Դ����������...
taskkill /f /im explorer.exe

:: ����������Դ������
echo ��������������Դ������...
start explorer.exe

echo ����������ɡ�
pause
