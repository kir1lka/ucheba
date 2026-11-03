# Java

[Мой репозиторий cad-2025](https://github.com/kir1lka/cad-2025) – форк [репозитория преподавателя](https://github.com/Nikita-Puzyrev/cad-2025).

| Папка | Содержание |
| --- | --- |
| [мой репозиторий/cad-2025](<мой репозиторий/cad-2025>) | Репозиторий с заданиями, кодом и отчётами в Google Colab, подключён как Git-подмодуль |
| [gradle-projects](gradle-projects) | Проекты лабораторных: курсовое приложение для №1 и отдельный учебный проект для №2 |
| [kir1lka/raspisa-hki](https://github.com/kir1lka/raspisa-hki) | Исходный репозиторий курсового приложения расписания |

## Второй семестр

| Работа | Проект | Отчёт |
| --- | --- | --- |
| Лабораторная 1 | [raspisa-hki](gradle-projects/lab1) | [Отчёт](gradle-projects/lab1/rep.ipynb); [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab1/rep.ipynb) |
| Лабораторная 2 | [lab2](gradle-projects/lab2) | [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab2/rep.ipynb) |

Для запуска откройте PowerShell в папке нужной лабораторной и выполните:

```powershell
.\gradlew.bat bootRun
```

Требуется JDK 17. Для сборки первой лабораторной также нужен Node.js: Gradle собирает интерфейс React. По умолчанию первая лабораторная использует порт 8080, вторая – 8081.

Первая лабораторная переделана по готовому курсовому приложению расписания: полный проект и `rep.ipynb` находятся в `gradle-projects/lab1` и `мой репозиторий/cad-2025/sem2/lab1`. Отчёт содержит пояснения, простые примеры Java-кода и семь скриншотов запросов в Insomnia. Все ячейки текстовые, без выполнения кода в Colab.

## Скачать репозиторий с лабораторными

После скачивания общего репозитория выполните в его корне:

```powershell
git submodule update --init --recursive
```

Изменения кода и отчётов сначала отправляются в `cad-2025`, затем обновлённая версия подмодуля сохраняется коммитом в `ucheba`.
