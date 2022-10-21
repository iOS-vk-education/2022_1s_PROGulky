# 2022_1s_PROГулки
Проект команды PROгулки по курсу "Мобильный разработчик на iOS" VK Group (осень 2022, 1 семестр)

# Полезные ссылки 
[Борда Jira](https://progulky.atlassian.net/jira/software/projects/PROG/boards/1)
***
[Дизигн](https://www.figma.com/file/0Cg1PRxXFbMif5q3kSDK4z/PRO%D0%B3%D1%83%D0%BB%D0%BA%D0%B8?node-id=0%3A1)

____

## Сборка
- `bundle install`
- `bundle exec pod install`

## Создание нового модуля
- Установаить [Generamba](https://github.com/strongself/Generamba.git)
    - `gem install generamba`
- Открыть в консоли проект 
- `generamba template install`
- `generamba gen MODULE_NAME TEMPLATE_NAME`

MODULE_NAME - название модуля, который вы хотите создать.

TEMPLATE_NAME - название шаблона, который будет использован.

В проект интегрирован шаблон VIPER модуля - `puzzzik_viper`
