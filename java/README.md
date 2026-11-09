# Java

[Мой репозиторий cad-2025](https://github.com/kir1lka/cad-2025) – форк [репозитория преподавателя](https://github.com/Nikita-Puzyrev/cad-2025).

| Папка | Содержание |
| --- | --- |
| [мой репозиторий/cad-2025](<мой репозиторий/cad-2025>) | Репозиторий с заданиями, кодом и отчётами в Google Colab, подключён как Git-подмодуль |
| [gradle-projects](gradle-projects) | Полные проекты лабораторных №1–4 на основе приложения расписания |
| [kir1lka/raspisa-hki](https://github.com/kir1lka/raspisa-hki) | Исходный репозиторий курсового приложения расписания |

## Второй семестр

| Работа | Проект | Отчёт |
| --- | --- | --- |
| Лабораторная 1 | [raspisa-hki](gradle-projects/lab1) | [Отчёт](gradle-projects/lab1/rep.ipynb); [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab1/rep.ipynb) |
| Лабораторная 2 | [raspisa-hki](gradle-projects/lab2) | [Отчёт](gradle-projects/lab2/rep.ipynb); [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab2/rep.ipynb) |
| Лабораторная 3 | [Spring Security](gradle-projects/lab3) | [Отчёт](gradle-projects/lab3/rep.ipynb); [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab3/rep.ipynb) |
| Лабораторная 4 | [Spring и PostgreSQL](gradle-projects/lab4) | [Отчёт](gradle-projects/lab4/rep.ipynb); [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab4/rep.ipynb) |

Для запуска откройте PowerShell в папке нужной лабораторной и выполните:

```powershell
.\gradlew.bat bootRun
```

Требуются JDK 17 и Node.js: Gradle собирает интерфейс React. Лабораторные №1–2 по умолчанию используют порт 8080; для одновременного запуска одной из них задайте другой `SERVER_PORT`.

Первая лабораторная переделана по готовому курсовому приложению расписания: полный проект и `rep.ipynb` находятся в `gradle-projects/lab1` и `мой репозиторий/cad-2025/sem2/lab1`. Отчёт содержит пояснения, простые примеры Java-кода и семь скриншотов запросов в Insomnia. Все ячейки текстовые, без выполнения кода в Colab.

Вторая лабораторная также оформлена по курсовому приложению: модель `Lesson`, репозиторий, сервис, контроллер и представление React. Полный проект и `rep.ipynb` находятся в `gradle-projects/lab2` и `мой репозиторий/cad-2025/sem2/lab2`. В отчёте только текстовые ячейки, примеры Java-кода и четыре ранее предоставленных скриншота запросов к этому же приложению.

Третья лабораторная находится в `gradle-projects/lab3` и `мой репозиторий/cad-2025/sem2/lab3`. Для запуска на ПК откройте `start-lab3.bat`, затем <http://localhost:8083/login>. Готовый JAR находится в `build/libs/raspisa-lab3.jar`; учётные записи и инструкция приведены в [ЗАПУСК.txt](gradle-projects/lab3/ЗАПУСК.txt). Администратор видит всю панель, преподаватель – журнал, студент – мероприятия, методист – управление мероприятиями. Данные хранятся в отдельной локальной H2. Комментариев в исходниках нет, пояснения находятся в отчёте. Проект и отчёт опубликованы в `cad-2025`.

Четвёртая лабораторная находится в `gradle-projects/lab4` и `мой репозиторий/cad-2025/sem2/lab4`. Откройте Docker Desktop, затем `start-lab4.bat` и <http://localhost:8084/login>. PostgreSQL доступен на порту 5544; инструкция находится в [ЗАПУСК.txt](gradle-projects/lab4/ЗАПУСК.txt). В приложении добавлены задачи подготовки мероприятий, подзадачи, история изменений и история успешных входов. Отчёт содержит Java-код и пять скриншотов. Проект и отчёт опубликованы в `cad-2025`.

[Объяснение лабораторных 3 и 4 в Word](<Объяснение лабораторных 3 и 4 Java.docx>) – разбор кода, Spring Security, PostgreSQL и Docker с нуля, команды запуска и ответы для защиты.

## Скачать репозиторий с лабораторными

После скачивания общего репозитория выполните в его корне:

```powershell
git submodule update --init --recursive
```

Изменения кода и отчётов сначала отправляются в `cad-2025`, затем обновлённая версия подмодуля сохраняется коммитом в `ucheba`.
