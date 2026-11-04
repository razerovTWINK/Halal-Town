<!-- autopilot:start -->
# HalalTown (Rogue Town Fork)

SS13-based codebase for HalalTown running at 60 FPS.

## Команды

| Команда | Что делает |
|---------|------------|
| `BUILD.bat` | Быстрая сборка (`-DFASTBUILD`); пропускает компиляцию, если исходники не менялись |
| `BUILD.bat run` | Быстрая сборка + запуск сервера |
| `BUILD.bat force` | Быстрая сборка с принудительной пересборкой |
| `BUILD.bat full` | Полный релизный билд: `DEBUG`, полная карта, `PRELOAD_RSC 2` |
| `RUN.bat` | Запуск сервера без пересборки (`-map-threads` по числу ядер только в fast-режиме) |
| `RUN.bat -MapThreads 4` | Явно задать потоки загрузки карты (`0` — по умолчанию BYOND) |
| `RUN.bat -NoInit` | Мгновенный старт без инициализации подсистем |
| `dm.exe -DUNIT_TESTS roguetown.dme` | Сборка с юнит-тестами |
| `BUILD.bat help` | Справка по режимам |

`FASTBUILD` задаётся дефайном `-DFASTBUILD` (`roguetown.dme`, `code/_compile_options.dm`, `code/testing.dm`): без `DEBUG mode`, `PRELOAD_RSC 1` вместо 2, `LOWMEMORYMODE` и лёгкая карта `_maps/roguetest.json`. Полный билд без дефайна остаётся прежним. Логика сборки и запуска — `tools/fastbuild.ps1`.

## Архитектура частоты кадров и движения (60 FPS)

- Сервер и мир работают на 60 FPS (`code/world.dm` и конфигурация `config_entry/number/fps` по умолчанию равны 60, `world.tick_lag ≈ 0.1667`).
- Источник истины для тикрейта — `FPS 60` в `config/config.txt`; `TICKLAG` должен быть закомментирован (`0.5` = 20 FPS). `Master.Initialize()` применяет конфиг через `world.change_fps()`, поэтому рассинхрон меняет частоту на ходу и ломает ввод, задержки ходьбы, `glide_size`, таймеры и `SS_TICKER`-подсистемы. Проверка соответствия есть в юнит-тесте `movement_incone_sanity`. BYOND квантует `tick_lag` до 0,01, поэтому `FPS 60` реально даёт `tick_lag 0.16` (~62,5 FPS, в логе `63 FPS`) — это норма; сравнение в коде идёт по `tick_lag` с допуском 0,02.
- Клиенты (`client.fps`): по умолчанию `clientfps = 0` (автоматическая синхронизация с тикрейтом сервера). Запрещено `client.fps < world.fps`, чтобы предотвратить пропуск кадров и исчезновение мобов. При вызове `world.change_fps()` обновляются все клиенты из `GLOB.clients`.
- Движение (`glide_size`): макрос `DELAY_TO_GLIDE_SIZE(delay)` в `code/__DEFINES/movement.dm` масштабирует скорость скольжения под `world.tick_lag` в диапазоне от `MIN_GLIDE_SIZE 1` до `MAX_GLIDE_SIZE world.icon_size` (32).
- Задержки движения в `/client/Move()` выравниваются до целого числа тиков макросом `TICK_ALIGN_DELAY` (`code/__DEFINES/movement.dm`). При `tick_lag 0.16` шаг в 3 дс = 18,75 тика, и без выравнивания ходьба идёт рывками 18/19 тиков. Выравнивание применяется и после `+2` (fixedeye) и `×2` (диагональ).
- `GLOB.glide_size_multiplier` зафиксирован в `1.0`: `SStime_track` больше не меняет его из `tick ratio` каждые 10 с (скачки `0.75…1.25` заставляли скольжение то ускоряться, то тормозить). `Master` при перегруженном тике не делает `continue`, а только урезает бюджет тяжёлых подсистем — иначе `SSinput` пропускает тики и зажатые клавиши «заикаются».
- Поле зрения (`vision_cone`): все мобы находятся на плоскости `GAME_PLANE_FOV_HIDDEN`, а собственный оверлей моба выносится на `GAME_PLANE_UPPER`. Подсистема `SSincone` работает с флагом `SS_TICKER` (каждый тик), а при входе в игру (`/mob/living/Login()`) гарантированно вызывается `update_vision_cone()` и `update_cone()`.

## Как здесь работает Autopilot

Сборка ведётся навыком `/autopilot`. Требования, спецификация и таски — в `.autopilot/`.
Прогресс — `.autopilot/dashboard.html`. Правило: требование из `manifest.md`
может снять только пользователь.

Если работа продолжается — скажи «продолжи автопилот»: состояние поднимется
из `.autopilot/state.js`, переспрашивать ничего не нужно.
<!-- autopilot:end -->
