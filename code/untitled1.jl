# Проверяем количество аргументов
if length(ARGS) < 2
    println("Usage: julia script.jl <msg> <alphabet>")
    exit(1)
end

msg = ARGS[1]
alp = ARGS[2]
rev = reverse(alp)

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

enc = atbash(msg, alp, rev)
println("Encrypted:")
println(enc)

dec = atbash(enc, rev, alp)
println("Decrypted:")
println(dec)
