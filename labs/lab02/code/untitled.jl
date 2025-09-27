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

msg = "Как ваше настроение!"
rows, cols = 4, 8
key = "натыкать"
println("Route cipher encrypted: ", route_encrypt(msg, key, rows, cols))