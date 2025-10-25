---
title: "Лабароторная работа №4 Вычисление общего делителя"
author: "Кашкин Иван Евгеньевич"
lang: ru
toc: true
toc-title: "Содержание"
toc-depth: 2

format:
  pdf:
    documentclass: scrreprt
    fontsize: 12pt
    linestretch: 1.5
    papersize: a4
    number-sections: true
    lof: false
    lot: false
    mainfont: "IBM Plex Serif"
    romanfont: "IBM Plex Serif"
    sansfont: "IBM Plex Sans"
    monofont: "IBM Plex Mono"
    mathfont: "STIX Two Math"
    mainfontoptions: "Ligatures=Common,Ligatures=TeX,Scale=0.94"
    romanfontoptions: "Ligatures=Common,Ligatures=TeX,Scale=0.94"
    sansfontoptions: "Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94"
    monofontoptions: "Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9"
    include-in-header:
      text: |
        \usepackage{indentfirst}
        \usepackage{float}
        \floatplacement{figure}{H}

bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

crossref:
  fig-title: "Рис."
  tbl-title: "Таблица"
  lst-title: "Листинг"
  lof-title: "Список иллюстраций"
  lot-title: "Список таблиц"
  lol-title: "Листинги"

pdf-engine: lualatex
biblatex: true
biblio-style: "gost-numeric"
cite-method: biblatex
---

# Цель работы

Изучение и реализация различных алгоритмов Евклида для вычисления наибольшего общего делителя (НОД) двух чисел.

# Задание

   Реализовать на языке Julia четыре алгоритма вычисления НОД:
   - Обычный алгоритм Евклида
   - Бинарный алгоритм Евклида
   - Расширенный алгоритм Евклида
   - Расширенный бинарный алгоритм Евклида

# Теоретическая часть

## Наибольший общий делитель (НОД)

Наибольший общий делитель (НОД) двух целых чисел a и b — это наибольшее целое число d, которое делит одновременно a и b без остатка.

## Алгоритмы Евклида

### 1. Обычный алгоритм Евклида

Основан на следующем свойстве: НОД(a, b) = НОД(b, a mod b). Процесс повторяется до тех пор, пока остаток не станет равным нулю.

### 2. Бинарный алгоритм Евклида

Использует следующие свойства:
- НОД(2a, 2b) = 2·НОД(a, b)
- НОД(2a, b) = НОД(a, b) для нечётного b
- НОД(a, b) = НОД(|a-b|, min(a,b))

### 3. Расширенный алгоритм Евклида

Находит не только НОД(a, b), но и коэффициенты Безу x и y, такие что:
ax + by = НОД(a, b)

### 4. Расширенный бинарный алгоритм

Комбинирует преимущества бинарного алгоритма с возможностью нахождения коэффициентов Безу.

# Выполнение лабораторной работы

## Реализация алгоритмов

### 1. Обычный алгоритм Евклида

```julia
function euclid_gcd(a, b)
    a, b = abs(a), abs(b)
    while b != 0
        a, b = b, a % b
    end
    return a
end
```
### 2. Бинарный алгоритм Евклида

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

### 3. Расширенный алгоритм Евклида

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
### 4. Расширенный бинарный алгоритм Евклида

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

## Сравнение алгоритмов
Все четыре алгоритма корректно вычислили НОД чисел 12345 и 54321, который равен 3. Расширенные алгоритмы также успешно нашли коэффициенты Безу, удовлетворяющие уравнению ax + by = НОД(a, b).

# Выводы
- В ходе выполнения лабораторной работы были успешно реализованы и протестированы четыре алгоритма вычисления наибольшего общего делителя:
- Обычный алгоритм Евклида - классический подход, основанный на последовательном делении с остатком
- Бинарный алгоритм Евклида - оптимизированная версия, использующая битовые операции для ускорения вычислений
- Расширенный алгоритм Евклида - находит НОД и коэффициенты Безу, что особенно полезно в криптографических приложениях
- Расширенный бинарный алгоритм - сочетает преимущества бинарного алгоритма с возможностью нахождения коэффициентов Безу

Все алгоритмы продемонстрировали корректную работу на тестовых данных. Расширенные версии успешно вычислили коэффициенты Безу, что подтверждается проверкой выполнения уравнения ax + by = НОД(a, b).