@echo off
chcp 65001 > nul

echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo     ^<head^>
echo         ^<meta charset="UTF-8" /^>
echo         ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^>
echo         ^<meta http-equiv="X-UA-Compatible" content="ie=edge" /^>
echo         ^<title^>%PROJECT_NAME%^</title^>
echo     ^</head^>
echo     ^<body^>
echo         ^<h1^>Welcome to %PROJECT_NAME% project!^</h1^>
echo     ^</body^>
echo ^</html^>
