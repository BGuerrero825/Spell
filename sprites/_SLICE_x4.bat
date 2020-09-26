@echo off
set /p FILE="Name of file to convert (no extension): "
@set ASEPRITE= "D:\Program Files (x86)\Steam\steamapps\common\Aseprite\Aseprite.exe"
%ASEPRITE% -b "%FILE%.ase" --scale 4 --split-slices --save-as "%FILE% {slice}.png"
