function sqrt(x::Complex{DoubleFloat{T}}) where {T<:IEEEFloat}
    rea, ima = real(x), imag(x)
    fourthroot = sqrt(hypot(rea, ima))
    halfatan = atan(rea, ima) * 0.5
    rea = fourthroot * cos(halfatan)
    ima = fourthroot * sin(halfatan)
    return Complex{DoubleFloat{T}}(rea, ima)
end

tan(x::Complex{DoubleFloat{T}}) where {T<:IEEEFloat} = sin(x) / cos(x)
tanh(x::Complex{DoubleFloat{T}}) where {T<:IEEEFloat} = sinh(x) / cosh(x)

function atan(x::Complex{DoubleFloat{T}}) where {T<:IEEEFloat}
    rea, ima = real(x), imag(x)
    return Complex{DoubleFloat{T}}(atan_real(rea, ima), atan_imag(rea, ima))
end

# http://functions.wolfram.com/ElementaryFunctions/ArcTan/19/01/
#  (1/2)*(atan((2* x)/(1 - x^2 - y^2)) + (1/2)*(sign(x^2 + y^2 - 1) + 1)*pi*sign(x))
function atan_real(x::DoubleFloat{T}, y::DoubleFloat{T}) where {T<:IEEEFloat}
    x2 = square(x)
    y2 = square(y)
    a = 2*x / (1 - (x2 + y2))
    b = pio2(DoubleFloat{T}) * (sign(x2 + y2 - 1) + 1) * sign(x)
    result = (atan(a) + b) * 0.5
    return result
end

# http://functions.wolfram.com/ElementaryFunctions/ArcTan/19/02/
# (1/4)*log((x^2 + (y + 1)^2)/(x^2 + (1 - y)^2))
function atan_imag(x::DoubleFloat{T}, y::DoubleFloat{T}) where {T<:IEEEFloat}
    x2 = square(x)
    num = x2 + square(1 + y)
    den = x2 + square(1 - y)
    result = num / den
    result = log(result) * 0.25
    return result
end