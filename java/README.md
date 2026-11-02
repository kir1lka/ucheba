# Java

[Мой репозиторий cad-2025](https://github.com/kir1lka/cad-2025) – форк [репозитория преподавателя](https://github.com/Nikita-Puzyrev/cad-2025).

| Папка | Содержание |
| --- | --- |
| [мой репозиторий/cad-2025](<мой репозиторий/cad-2025>) | Репозиторий с заданиями, кодом и отчётами в Google Colab, подключён как Git-подмодуль |
| [gradle-projects](gradle-projects) | Отдельные проекты Demo для запуска каждой лабораторной |

## Второй семестр

| Работа | Проект | Отчёт |
| --- | --- | --- |
| Лабораторная 1 | [lab1](gradle-projects/lab1) | [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab1/rep.ipynb) |
| Лабораторная 2 | [lab2](gradle-projects/lab2) | [Google Colab](https://colab.research.google.com/github/kir1lka/cad-2025/blob/main/sem2/lab2/rep.ipynb) |

Для запуска откройте PowerShell в папке нужной лабораторной и выполните:

```powershell
.\gradlew.bat bootRun
```

Требуется JDK 17. Первая лабораторная открывается по адресу <http://localhost:8080>, вторая – <http://localhost:8081>.

## Скачать репозиторий с лабораторными

После скачивания общего репозитория выполните в его корне:

```powershell
git submodule update --init --recursive
```

Изменения кода и отчётов сначала отправляются в `cad-2025`, затем обновлённая версия подмодуля сохраняется коммитом в `ucheba`.
