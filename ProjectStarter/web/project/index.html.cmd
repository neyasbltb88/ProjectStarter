@echo off
chcp 65001 > nul

echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo     ^<head^>
echo         ^<meta charset="UTF-8" /^>
echo         ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^>
echo         ^<meta http-equiv="X-UA-Compatible" content="ie=edge" /^>
echo         ^<title^>%PROJECT_NAME%^</title^>
echo         ^<link rel="stylesheet" href="./css/style.css" /^>
echo     ^</head^>
echo     ^<body^>
echo         ^<script src="./js/index.js"^>^</script^>
echo     ^</body^>
echo ^</html^>
