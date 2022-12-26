function fib(n::Int)::Int
    if n == 1 || n == 2
        return 1
    end
    a = 1
    b = 1
    for i in 3:n
        x = a + b
        a = b
        b = x
    end
    return b
end


function fib_r(n::Int)::Int
    if n == 1 || n == 2
        return 1
    end
    return fib_r(n-1) + fib_r(n - 2)
end

fib(5)