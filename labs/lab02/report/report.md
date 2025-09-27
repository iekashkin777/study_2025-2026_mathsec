---
title: "Лабароторная работа №2 'Шифры перестановки'"
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

Целью данной работы является изучение алгоритмов шифрования перестановки, принцип его работы, реализация на Julia.

# Задание

1. Реализовать шифр Цезаря с произвольным ключем k.
2. Реализовать шифр Атбаш.

# Выполнение лабораторной работы

## Маршрутное шифрование

Реализация:

```julia
function route_encrypt(message::String, key::String, rows::Int, cols::Int)
    message = filter(!isspace, message)

    matrix = fill('_', rows, cols)
    for (idx, ch) in enumerate(message)
        if idx > rows * cols
            break
        end
        i = div(idx-1, cols) + 1
        j = mod(idx-1, cols) + 1
        matrix[i, j] = ch
    end
    new_message = ""
    sorted_key = sort(collect(key))
    for ch in sorted_key
        col = findfirst(==(ch), collect(key))
        for i in 1:rows
            new_message *= matrix[i, col]
        end
    end
    return new_message
end
```

## Шифрование с помощью решеток

Реализация: 

```julia
function grille_encrypt(message::String, mask::Array{Bool,2})
    n = size(mask, 1)
    grid = fill('_', n, n)
    msg_iter = Iterators.flatten([message[i] for i in 1:length(message)])
    msg_idx = 1

    for _ in 1:4
        for i in 1:n
            for j in  1:n
                 if mask[i,j] && msg_idx <= length(message)
                    grid[i,j] = message[msg_idx]
                    msg_idx += 1
                end
            end
        end
        mask = rotate90(mask)
    end

    ciphertext = ""
    for i in 1:n
        for j in  1:n
            ciphertext *= string(grid[i,j])
        end
    end
    return ciphertext
end
```
## Таблица Вижинера

Реализация: 

```julia
function vigenere_encrypt(plaintext::String, key::String)
    result = ""
    key = uppercase(key)
    plaintext = uppercase(plaintext)
    key_len = length(key)
    key_pos = 1

    for c in plaintext
        if 'A' <= c <= 'Z'
            shift = Int(key[key_pos]) - Int('A')
            encrypted_char = Char(((Int(c) - Int('A') + shift) % 26) + Int('A'))
            result *= encrypted_char
            key_pos = key_pos == key_len ? 1 : key_pos + 1
        else
            result *= c  # Неалфавитные символы не меняем
        end
    end
    return result
end
```
# Выводы

В данной лабораторной работе были изучены три шифра перестановки, все алгоритмы были реализованы на языке Julia и работают корректно.