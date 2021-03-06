@echo off

mkdir build
cd build

if "%BUILD_PLAY%" == "ON" (
	cmake .. -G"%BUILD_TYPE%" -T v141_xp -DUSE_QT=on -DCMAKE_PREFIX_PATH="C:\Qt\5.12\%QT_FLAVOR%"
	cmake --build . --config %CONFIG_TYPE%
	c:\Qt\5.12\%QT_FLAVOR%\bin\windeployqt.exe ./Source/ui_qt/Release --no-system-d3d-compiler --no-quick-import --no-opengl-sw --no-compiler-runtime --no-translations	
	
	cd ..
	"C:\Program Files (x86)\NSIS\makensis.exe" ./installer_win32/%INSTALLER_SCRIPT%
	
	cd ..
	cd ..
	mkdir %REPO_COMMIT_SHORT%
	move Play-Build\Play\installer_win32\*.exe %REPO_COMMIT_SHORT%
)

if "%BUILD_PSFPLAYER%" == "ON" (
	cmake .. -G"%BUILD_TYPE%" -T v141_xp -DBUILD_PLAY=off -DBUILD_PSFPLAYER=on
	cmake --build . --config %CONFIG_TYPE%
	
	cd ..
	"C:\Program Files (x86)\NSIS\makensis.exe" ./tools/PsfPlayer/installer_win32/%INSTALLER_SCRIPT%

	cd ..
	cd ..
	mkdir %REPO_COMMIT_SHORT%
	move Play-Build\Play\tools\PsfPlayer\installer_win32\*.exe %REPO_COMMIT_SHORT%
)
