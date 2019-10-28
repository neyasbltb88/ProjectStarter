# ProjectStarter

Набор устанавливающихся скриптов .cmd в систему Windows, Который добавляет в контекстное меню папок новый пункт, при клике на который будет запрос имени нового проекта и создастся соответствующая папка с базовой структурой web-проекта. Так же после создания структуры папок, инициализируется git-репозиторий и создается новый коммит "Init", после чего проект открывается в редакторе [VS Code](https://code.visualstudio.com/).

Установка ProjectStarter производится запуском [install.cmd](./ProjectStarter/install.cmd) от имени Администратора. Для удобства в корневой папке этого проекта создан ярлык, который сам запускает тот же скрипт с правами Администратора.

Удалить ProjectStarter возможно запуском [uninstall.cmd](./ProjectStarter/uninstall.cmd) из папки с установкой или из окна "Удалить или изменить программу".

![demo](./demo.gif)