defmodule Practice.Factor do
    def factor(n) do 
        factors = []
        #num = String.to_integer(n)
        get_factors(factors, n, n) |> Enum.sort()
    end

    def get_factors(factors, _, 1) do 
        factors
    end

    def get_factors(factors, divisor, _) when divisor === 1 do
        factors
    end

    def get_factors(factors, divisor, n) when rem(n, divisor) === 0 do
        if is_prime(divisor) do
            if is_square(n) do 
                get_factors([divisor, divisor] ++ factors, divisor - 1, div(n, divisor))
            else
                get_factors([divisor] ++ factors, divisor - 1, div(n, divisor))
            end
        else
            get_factors(get_factors([], divisor - 1, divisor) ++ factors, divisor - 1, div(n, divisor))
        end
    end 
        
    def get_factors(factors, divisor, n) when rem(n, divisor) > 0 do
        get_factors(factors, divisor - 1, n)
    end 

    def is_prime(x) do
        numbers = 2..x
        (Enum.to_list(numbers)
        |> Enum.filter(fn a -> 
           rem(x, a) == 0 
        end) 
        |> length()) == 1
    end

    def is_square(x) do 
        root = :math.sqrt(x) 
        root == :math.floor(root)
    end

end