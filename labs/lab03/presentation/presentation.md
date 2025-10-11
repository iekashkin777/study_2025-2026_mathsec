---
title: "Шифрование гаммированием"
author: 
  - "Кашкин И.Е."
institute: 
  - "Российский университет дружбы народов, Москва, Россия"
date: "11 октября 2025"
lang: ru

format: 
  revealjs:
    theme: default
    transition: slide
    slide-number: true
    controls: true
    progress: true
    center: true
    hash: true
  beamer:
    pdf-engine: lualatex
    theme: metropolis
    aspectratio: 169
    slide-level: 2
    section-titles: true
    toc: false
    mainfont: "Times New Roman"
    sansfont: "Arial"
    monofont: "Courier New"
    include-in-header:
      text: |
        \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
        \usepackage{fontspec}
        \setmainfont{Times New Roman}
        \setsansfont{Arial}
        \setmonofont{Courier New}
---

## Цель работы

Реализация алгоритма шифрования гаммированием с использованием конечной гаммы.

## Задание

1. Реализовать шифр гаммирования на языку Julia.

## Выполнение лабораторной работы

### Алгоритм работы

1. Преобразование текста и гаммы в числовые последовательности
2. Циклическое расширение гаммы до длины текста
3. Поэлементное сложение/вычитание по модулю N
4. Преобразование результата обратно в текст

## Реализация Шифрования

```julia
const RUSSIAN_ALPHABET = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")

function text_to_numbers(text, alphabet)
function numbers_to_text(numbers, alphabet)

function extend_gamma(gamma_numbers, target_len)

function encrypt(plain_text, gamma, alphabet)
function decrypt(cipher_text, gamma, alphabet)
```

## Результаты тестирования

Пример работы программы: 

```julia
=== Шифрование гаммированием ===
Исходный текст: 'шифрование'
Гамма: 'гаммированием'
Алфавит: абвгдеёжзийклмнопрстуфхцчшщъыьэюя
Длина алфавита: 33

Числовое представление текста: [26, 10, 22, 18, 1, 15, 3, 1, 14, 10, 6]
Числовое представление гаммы: [4, 1, 14, 14, 10, 18, 16, 1, 15, 3, 1, 14, 10, 6]

Зашифрованный текст: 'хюъхёасиън'
Числовое представление шифротекста: [23, 32, 29, 32, 11, 31, 19, 2, 29, 13]
Дешифрованный текст: 'шифрование'
✓ Шифрование и дешифрование прошли успешно!
```
## Выводы

В данной лабораторной работе было изучено шифрование гаммированием, все алгоритмы были реализованы на языке Julia и работают корректно.
1. Реализован алгоритм шифрования гаммированием с конечной гаммой
2. Алгоритм корректно выполняет как шифрование, так и дешифрование
3. Преобразование работает корректно - исходный текст полностью восстанавливается после дешифрования
4. Использование циклического повторения гаммы позволяет шифровать тексты любой длины с помощью короткого ключа