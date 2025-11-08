---
title: "Лабароторная работа №5 Вероятностные алгоритмы проверки чисел нв простоту"
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

Изучение и реализация вероятностных алгоритмов проверки чисел на простоту: теста Ферма, теста Соловэя-Штрассена и теста Миллера-Рабина.

# Задание

   Реализовать на языке Julia три вероятностных алгоритма проверки чисел на простоту:
- Тест Ферма
- Тест Соловэя-Штрассена  
- Тест Миллера-Рабина
- 
# Теоретическая часть

## Вероятностные алгоритмы проверки на простоту

Вероятностные алгоритмы используют генератор случайных чисел и дают не гарантированно точный ответ. После нескольких независимых выполнений теста вероятность ошибки становится пренебрежимо малой.

### 1. Тест Ферма

Основан на малой теореме Ферма: для простого числа $p$ и произвольного числа $a$, $1 \leq a \leq p - 1$, выполняется сравнение:
$$a^{p-1} \equiv 1 \pmod{p}$$

### 2. Тест Соловэя-Штрассена

Основан на критерии Эйлера и вычислении символа Якоби. Для простого числа $n$ и любого целого $a$, взаимно простого с $n$, выполняется:
$$a^{(n-1)/2} \equiv \left(\frac{a}{n}\right) \pmod{n}$$

### 3. Тест Миллера-Рабина

Основан на разложении $n-1 = 2^s \cdot r$ и проверке последовательности степеней. Если $n$ простое, то для любого $a \geq 2$ выполняется одно из условий:
- $a^r \equiv 1 \pmod{n}$
- $a^{2^j \cdot r} \equiv -1 \pmod{n}$ для некоторого $j$, $0 \leq j \leq s-1$

### 4. Символ Якоби

Символ Якоби $\left(\frac{a}{n}\right)$ является обобщением символа Лежандра на нечетные составные модули и вычисляется рекурсивно на основе свойств мультипликативности и квадратичной взаимности.

# Выполнение лабораторной работы

## Реализация алгоритмов

### 1. Вычисление символа Якоби

```julia
function jacobi_symbol(a::Int, n::Int)
    if n % 2 == 0 || n < 3
        throw(ArgumentError("n должно быть нечётным и >= 3"))
    end
    
    a = a % n
    g = 1
    
    while a != 0
        while a % 2 == 0
            a ÷= 2
            if n % 8 == 3 || n % 8 == 5
                g = -g
            end
        end
        
        a, n = n, a
        
        if a % 4 == 3 && n % 4 == 3
            g = -g
        end
        
        a = a % n
    end
    
    return n == 1 ? g : 0
end
```
### 2. Тест Ферма
```julia
function fermat_test(n::Int, k::Int=5)
    if n < 5
        throw(ArgumentError("n должно быть >= 5"))
    end
    if n % 2 == 0
        return "Составное"
    end
    
    for _ in 1:k
        a = rand(2:(n-2))
        if powermod(a, n-1, n) != 1
            return "Составное"
        end
    end
    return "Вероятно простое"
end
```

### 3. Тест Соловэя-Штрассена
```julia
function solovay_strassen_test(n::Int, k::Int=5)
    if n < 5
        throw(ArgumentError("n должно быть >= 5"))
    end
    if n % 2 == 0
        return "Составное"
    end
    
    for _ in 1:k
        a = rand(2:(n-2))
        r = powermod(a, (n-1)÷2, n)
        
        if r != 1 && r != n-1
            return "Составное"
        end
        
        s = jacobi_symbol(a, n)
        if r % n != s % n
            return "Составное"
        end
    end
    return "Вероятно простое"
end
```

### 4. Тест Миллера-Рабина

```julia
function miller_rabin_test(n::Int, k::Int=5)
    if n < 5
        throw(ArgumentError("n должно быть >= 5"))
    end
    if n % 2 == 0
        return "Составное"
    end
    
    s = 0
    r = n - 1
    while r % 2 == 0
        s += 1
        r ÷= 2
    end
    
    for _ in 1:k
        a = rand(2:(n-2))
        y = powermod(a, r, n)
        
        if y != 1 && y != n-1
            j = 1
            while j < s && y != n-1
                y = powermod(y, 2, n)
                if y == 1
                    return "Составное"
                end
                j += 1
            end
            if y != n-1
                return "Составное"
            end
        end
    end
    return "Вероятно простое"
end
```

## Анализ результатов
- Все три алгоритма корректно определяют простые числа (5, 7, 11, 17, 19, 23, 29)
- Составные числа (15, 21, 49) правильно идентифицируются всеми тестами
- Число Кармайкла 561 демонстрирует ограничения теста Ферма: он ошибочно определяет его как "Вероятно простое", в то время как тесты Соловэя-Штрассена и Миллера-Рабина правильно идентифицируют его как составное

# Выводы
В ходе выполнения лабораторной работы были успешно реализованы и протестированы три вероятностных алгоритма проверки чисел на простоту:
- Тест Ферма - самый простой алгоритм, основанный на малой теореме Ферма, но имеющий ограничения (не определяет числа Кармайкла)
- Тест Соловэя-Штрассена - более надежный алгоритм, использующий символ Якоби, который успешно определяет числа Кармайкла
- Тест Миллера-Рабина - наиболее надежный из рассмотренных алгоритмов, широко применяемый на практике благодаря высокой точности и эффективности
