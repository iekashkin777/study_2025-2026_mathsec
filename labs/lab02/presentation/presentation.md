---
title: "Шифры перестановки"
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

Целью данной работы является изучение алгоритмов шифрования перестановки, принцип его работы, реализация на Julia.

## Задание

1. Реализовать Маршрутное шифрование
2. Реализовать Шифрование с помощью решеток
3. Реализовать Таблица Вижинера

## Выполнение лабораторной работы

### Реализация Маршрутное шифрование

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
## Реализация Шифрование с помощью решеток

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
## Реализация Таблица Вижинера

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
## Выводы

В данной лабораторной работе были изучены три шифра перестановки, все алгоритмы были реализованы на языке Julia и работают корректно.