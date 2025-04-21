@echo off
chcp 65001 >nul
mode con: cols=150 lines=40>nul
color 0A
setlocal enabledelayedexpansion
title 🧰 Yazılımcı El Çantası - Uygulama Yükleyici

set choices[1]=Visual Studio Code,Microsoft.VisualStudioCode
set choices[2]=Notepad++,Notepad++.Notepad++
set choices[3]=Microsoft Visual Studio 2022 Community,Microsoft.VisualStudio.2022.Community
set choices[4]=Android Studio,Google.AndroidStudio
set choices[5]=IntelliJ IDEA (Community),JetBrains.IntelliJIDEA.Community
set choices[6]=PyCharm (Community),JetBrains.PyCharm.Community
set choices[7]=WebStorm,JetBrains.WebStorm
set choices[8]=PhpStorm,JetBrains.PhpStorm
set choices[9]=Eclipse IDE,EclipseAdoptium.Eclipse
set choices[10]=Swift,Swift.Toolchain
set choices[11]=Node.js,OpenJS.NodeJS
set choices[12]=Python,Python.Python.3
set choices[13]=Git,Git.Git
set choices[14]=Fork,Fork.Fork
set choices[15]=Postman,Postman.Postman
set choices[16]=7-Zip,7zip.7zip
set choices[17]=Windows Terminal,Microsoft.WindowsTerminal
set choices[18]=Microsoft SQL Server,Microsoft.SqlServer
set choices[19]=SQL Server Management Studio (SSMS),Microsoft.SQLServerManagementStudio
set choices[20]=pgAdmin,PostgreSQL.pgAdmin
set choices[21]=Oracle SQL Developer,Oracle.SQLDeveloper
set choices[22]=MySQL,MySQL.MySQL
set choices[23]=MySQL Workbench,MySQL.MySQLWorkbench
set choices[24]=Oracle Database,Oracle.Database

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                   █ 🧰 YAZILIMCI EL ÇANTASI █                ║
echo ╚══════════════════════════════════════════════════════════════╝
echo   			  erdincdegirmenci
echo ----------------------------------------------------------------

echo.
echo Lütfen yüklemek veya kaldırmak istediğiniz uygulamayı seçin:
echo.

echo 0. ✋ Çıkış
echo 1. Visual Studio Code
echo 2. Notepad++
echo 3. Microsoft Visual Studio 2022 Community
echo 4. Android Studio
echo 5. IntelliJ IDEA (Community)
echo 6. PyCharm (Community)
echo 7. WebStorm
echo 8. PhpStorm
echo 9. Eclipse IDE
echo 10. Swift
echo 11. Node.js
echo 12. Python
echo 13. Git
echo 14. Fork
echo 15. Postman
echo 16. 7-Zip
echo 17. Windows Terminal
echo 18. Microsoft SQL Server
echo 19. SQL Server Management Studio (SSMS)
echo 20. pgAdmin (PostgreSQL)
echo 21. Oracle SQL Developer
echo 22. MySQL
echo 23. MySQL Workbench
echo 24. Oracle Database

:main_menu
echo.
set /p choice=Uygulama seçiniz: (1-24):
if "%choice%"=="0" goto exit_program
:: Seçimi kontrol et ve uygun uygulamayı ayarla
if defined choices[%choice%] (
    for /f "tokens=1,2 delims=," %%a in ("!choices[%choice%]!") do (
        set app=%%a
        set app_id=%%b
    )
) else (
    echo ❌ Geçersiz seçim, lütfen geçerli bir seçenek girin.
    goto main_menu
)

:: Yükleme veya Kaldırma seçeneğini sunma
echo.
echo Seçilen uygulama: %app%
echo.
:choice_menu
echo Ne yapmak istiyorsunuz? Yükle/Kaldır
set /p action_choice=Seçiminiz (Y/K):

if /i "%action_choice%"=="Y" goto INSTALL
if /i "%action_choice%"=="K" goto UNINSTALL
echo ❌ Geçersiz seçim, lütfen Y veya K girin.
goto choice_menu

:INSTALL
:: Son versiyon bilgisini al
for /f "tokens=*" %%a in ('winget show %app_id% ^| findstr "Version"') do set version=%%a

echo.
echo %app% için son versiyon: %version%
echo.
echo Yazılımın en son sürümünü mü yüklemek istersiniz? (Evet/Hayır)

:version_choice_loop
set /p version_choice=Seçiminiz (E/H): 

if /i "%version_choice%"=="E" goto INSTALL_LATEST
if /i "%version_choice%"=="H" goto INSTALL_SPECIFIC

echo Geçersiz seçim, lütfen Evet (E) veya Hayır (H) olarak yanıt verin.
goto version_choice_loop

:INSTALL_LATEST
echo %app% %version% yükleniyor...
winget install --id %app_id% -e
goto installation_done

:INSTALL_SPECIFIC
echo Lütfen yüklemek istediğiniz sürüm numarasını yazın:
set /p user_version=Versiyon: 
echo %app% %user_version% yükleniyor...
winget install --id %app_id% --version %user_version% -e
goto installation_done

:UNINSTALL
echo %app% kaldırılıyor...
winget uninstall --id %app_id% -e
goto installation_done

:installation_done
echo.
echo ✅ %app% kurulumu veya kaldırılması tamamlandı.
echo.
echo Çıkmak için "Q" tuşuna basın veya yeni bir işlem yapmak için herhangi bir tuşa basın.
set /p next_action= 
if /i "%next_action%"=="Q" goto exit_program
goto main_menu

:exit_program
echo.
echo 🔚 Program sonlandırılıyor...
timeout /t 2 >nul
exit
