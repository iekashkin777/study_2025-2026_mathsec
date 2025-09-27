---
title: "Лабароторная работа№1 'Шифры простой замены'"
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

Целью данной работы является изучение алгоритмов шифрования Цезарь и Атбаш, принцип его работы, реализация на Julia.

# Задание

1. Реализовать шифр Цезаря с произвольным ключем k.
2. Реализовать шифр Атбаш.

# Выполнение лабораторной работы

## Шифр Цезаря

Суть шифра Цезаря заключается в том, что происходит смещение всех букв по алфавиту в сообщении на некоторый коеффициент k. Декодирование происходим путем смещения в обратную сторону.

Далее приведена реализация как для русского так и для английского алфавита одновременно

```julia
result = ""
    for c in msg
        if Int(c) > 1041 && Int(c) < 1104
            base = (uppercase(c) == c) ? Int('А') : Int('а')
            t = base + (Int(c) - base + key) % 32
        elseif isletter(c)
            base = (uppercase(c) == c) ? Int('A') : Int('a')
            t = base + (Int(c) - base + key) % 26
        else
            result *= c  # не шифруем символы вне алфавита
            continue
        end
        result *= Char(t)
    end
    return result
end
```

В качестве параметров скрипт принимает:

- <enc> --- (Тип: Char) Расшивровать или шифровать сообщение (Возможные значения: d, e).

- <msg> --- (Тип: String) Сообщение, с которым нужно прозвести действие.

- <key> --- (Тип: Int) Значение сдвига в шифре Цезаря. (Для русского алфавита в промежутке [0, 31], для английского алфавита в промежутке [0, 26])

## Шифр Атбаш

Шифр Атбаш, отчасти, похож на шифр Цезаря, но в данном алгоритме разворачивается весь алфавит, а не происходит сдвиг.

```julia
function atbash(msg::String, from_alp::String, to_alp::String)
    result = ""
    for i in msg
        idx = findfirst(==(i), from_alp)
        if idx !== nothing
            result *= to_alp[idx]
        else
            result *= i  # символ не в алфавите, оставляем без изменений
        end
    end
    return result
end
```
В качестве параметров скрипт принимает:

- <enc> --- (Тип: Char) Расшивровать или шифровать сообщение (Возможные значения: d, e).

- <msg> --- (Тип: String) Сообщение, с которым нужно прозвести действие.

- <alp> --- (Тип: String) Словарь из которого, можно составить данное сообщение.

# Выводы

В данной лабораторной работе были изучены два алгоритма шифрования: Цезарь и Атбаш, оба алгоритма были реализованы на языке Julia и работают корректно.