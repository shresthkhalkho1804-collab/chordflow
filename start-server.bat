@echo off
title ChordFlow AI Server
echo Starting ChordFlow AI on http://localhost:3000...
set "PATH=%LOCALAPPDATA%\Programs\node;%LOCALAPPDATA%\Programs\git\cmd;%PATH%"
set PORT=3000
npm start
pause
