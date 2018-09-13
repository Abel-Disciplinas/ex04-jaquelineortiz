function bisseccao(f::Function, a::Real, b::Real, estrategia::Symbol; atol=1e-6, rtol=1e-6, maxiter=10_000, fdertol=1e-12)
    function escolha(f::Function, a::Real, b::Real, estrategia::Symbol)
        if estrategia == :bisseccao
            x = 0.5 * a + 0.5 * b
        elseif estrategia == :esquerda
            x = 0.1 * a + 0.9 * b
        elseif estrategia == :direita
            x = 0.9 * a + 0.1 * b
        elseif estrategia == :aleatorio
            r = rand()
            x = a * r + b * (1 - r)
        elseif estrategia == :falsa_posicao
            x = (a * f(b) - b * f(a)) / (f(b) - f(a))
        end
        return x
    end

    f(a), f(b) = fa, fb
    ϵ = atol + rtol * (abs(fa) + abs(fb)) / 2
    if abs(fa) < ϵ
        return a, fa, 0
    elseif abs(fb) < ϵ
        return b, fb, 0
    elseif fa * fb > 0
        error("Hipóteses não satisfeitas")
    end
    i = 0
    x = escolha(f, a, b, estrategia)
    fx = f(x)
    while !(abs(fx) <= ϵ || iter > maxiter)
        if fx * fa < 0
            b = x
        else
            a = x
        end
        x = escolha(f, a, b, estrategia)
        i +=1
    end
    return x, fx, i
end
