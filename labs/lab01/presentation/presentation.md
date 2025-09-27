---
title: "Шифры простой замены"
author: 
  - "Кашкин И.Е."
institute: 
  - "Российский университет дружбы народов, Москва, Россия"
date: "27 сентября 2024"
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

Целью данной работы является изучение алгоритмов шифрования Цезарь и Атбаш, принцип его работы, реализация на Julia.

## Задание

1. Реализовать шифр Цезаря с произвольным ключем k.
2. Реализовать шифр Атбаш.

## Выполнение лабораторной работы

### Шифр Цезаря

Суть шифра Цезаря заключается в том, что происходит смещение всех букв по алфавиту в сообщении на некоторый коеффициент k. Декодирование происходим путем смещения в обратную сторону.

## Реализация шифра Цезаря
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
## Реализация шифра
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

## Выводы

В данной лабораторной работе были изучены два алгоритма шифрования: Цезарь и Атбаш, оба алгоритма были реализованы на языке Julia и работают корректно.