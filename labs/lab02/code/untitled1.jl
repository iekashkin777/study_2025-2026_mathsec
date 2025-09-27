function rotate90(mat)
    n = size(mat, 1)
    res = Array{Bool}(undef, n, n)
    for i in 1:n
        for j in 1:n
            res[j, n - i + 1] = mat[i, j]
        end
    end
    return res
end

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

message = "HELLOWORLD"
mask = Bool[
    true false false false;
    false false true false;
    false true false false;
    false false false true
]

println("Grille cipher encrypted: ", grille_encrypt(message, mask))