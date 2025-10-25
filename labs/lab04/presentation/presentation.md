---
title: "Вычисление общего делителя"
author: 
  - "Кашкин И.Е."
institute: 
  - "Российский университет дружбы народов, Москва, Россия"
date: "25 октября 2025"
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

Изучение и реализация различных алгоритмов Евклида для вычисления наибольшего общего делителя (НОД) двух чисел.

## Задание

Реализовать на языке Julia четыре алгоритма вычисления НОД:
   - Обычный алгоритм Евклида
   - Бинарный алгоритм Евклида
   - Расширенный алгоритм Евклида
   - Расширенный бинарный алгоритм Евклида

## 1. Обычный алгоритм Евклида

Основан на следующем свойстве: НОД(a, b) = НОД(b, a mod b). Процесс повторяется до тех пор, пока остаток не станет равным нулю.

## 1. Обычный алгоритм Евклида

```julia
function euclid_gcd(a, b)
    a, b = abs(a), abs(b)
    while b != 0
        a, b = b, a % b
    end
    return a
end
```

## 2. Бинарный алгоритм Евклида

Использует следующие свойства:
- НОД(2a, 2b) = 2·НОД(a, b)
- НОД(2a, b) = НОД(a, b) для нечётного b
- НОД(a, b) = НОД(|a-b|, min(a,b))

## 2. Бинарный алгоритм Евклида

```julia
function binary_gcd(a, b)
    a, b = abs(a), abs(b)
    g = 1
    while iseven(a) && iseven(b)
        a ÷= 2
        b ÷= 2
        g *= 2
    end
    u, v = a, b
    while u != 0
        while iseven(u)
            u ÷= 2
        end
        while iseven(v)
            v ÷= 2
        end
        if u >= v
            u -= v
        else
            v -= u
        end
    end
    return g * v
end
```

## 3. Расширенный алгоритм Евклида

Находит не только НОД(a, b), но и коэффициенты Безу x и y, такие что:
ax + by = НОД(a, b)

## 3. Расширенный алгоритм Евклида

```julia
function extended_euclid(a, b)
    a, b = abs(a), abs(b)
    r_prev, r = a, b
    x_prev, x = 1, 0
    y_prev, y = 0, 1
    while r != 0
        q = r_prev ÷ r
        r_prev, r = r, r_prev - q * r
        x_prev, x = x, x_prev - q * x
        y_prev, y = y, y_prev - q * y
    end
    return (r_prev, x_prev, y_prev)
end
```

## 4. Расширенный бинарный алгоритм

Комбинирует преимущества бинарного алгоритма с возможностью нахождения коэффициентов Безу.

## 4. Расширенный бинарный алгоритм Евклида

```julia
function extended_binary_gcd(a, b)
    a, b = abs(a), abs(b)
    g = 1
    while iseven(a) && iseven(b)
        a ÷= 2
        b ÷= 2
        g *= 2
    end
    u, v = a, b
    A, B, C, D = 1, 0, 0, 1
    while u != 0
        while iseven(u)
            u ÷= 2
            if iseven(A) && iseven(B)
                A ÷= 2
                B ÷= 2
            else
                A = (A + b) ÷ 2
                B = (B - a) ÷ 2
            end
        end
        while iseven(v)
            v ÷= 2
            if iseven(C) && iseven(D)
                C ÷= 2
                D ÷= 2
            else
                C = (C + b) ÷ 2
                D = (D - a) ÷ 2
            end
        end
        if u >= v
            u -= v
            A -= C
            B -= D
        else
            v -= u
            C -= A
            D -= B
        end
    end
    d = g * v
    x, y = C, D
    return (d, x, y)
end
```

## Выводы
- В ходе выполнения лабораторной работы были успешно реализованы и протестированы четыре алгоритма вычисления наибольшего общего делителя:
- Обычный алгоритм Евклида - классический подход, основанный на последовательном делении с остатком
- Бинарный алгоритм Евклида - оптимизированная версия, использующая битовые операции для ускорения вычислений
- Расширенный алгоритм Евклида - находит НОД и коэффициенты Безу, что особенно полезно в криптографических приложениях
- Расширенный бинарный алгоритм - сочетает преимущества бинарного алгоритма с возможностью нахождения коэффициентов Безу