defmodule Practice.Palindrome do
    def palindrome(str) when is_binary(str) do
        str == String.reverse(str)
    end
end
