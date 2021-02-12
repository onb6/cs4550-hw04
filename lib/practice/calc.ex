defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens()
    |> postfix([], [])
    |> evaluate([])
    
    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def tag_tokens(expr) do
    Enum.map(expr, fn(ee) ->
      if Enum.member?(["+", "-", "*", "/"], ee) do 
        {:op, ee}
      else 
        {:num, String.to_integer(ee)}
      end
    end)
  end

  def postfix(expr, output, stack) do 
    if expr === [] do 
      output ++ stack
    else 
      case (hd expr) do 
        {:num, _} -> postfix((tl expr), output ++ [(hd expr)], stack)
        {:op, _} -> handle_op(expr, output, stack)
      end
    end
  end 

  def handle_op(expr, output, stack) do 
    if (stack === []) do 
      postfix((tl expr), output, [hd expr])
    else
      if order_operations(hd expr) > order_operations(hd stack) do 
        postfix((tl expr), output, [hd expr] ++ stack)
      else 
        if order_operations(hd expr) === order_operations(hd stack) do 
          postfix((tl expr), output ++ [hd stack], [hd expr] ++ tl stack)
        else
          if order_operations(hd expr) < order_operations(hd stack) do 
            postfix((tl expr), output ++ [(hd stack)], [hd expr] ++ tl stack)
          end
        end
      end
    end
  end

  def order_operations(o) do 
    case o do 
      {_, "+"} -> 1
      {_, "-"} -> 1
      {_, "*"} -> 2
      {_, "/"} -> 2
      {_, _} -> 0
    end
  end

  def evaluate(expr, stack) do 
    if expr === [] do 
      {:num, a} = (hd stack)
      a
    else 
      case (hd expr) do 
        {:num, _} -> evaluate((tl expr), [(hd expr)] ++ stack)
        {:op, _} -> eval_op(expr, stack)
      end
    end
  end

  def eval_op(expr, stack) do 
    temp1 = (hd stack)
    temp2 = (hd (tl stack))
    num = solve(temp2, (hd expr), temp1)
    evaluate((tl expr), [{:num, num}] ++ (tl (tl stack)))
  end

  def solve(n1, op, n2) do 
    {:num, a} = n1
    {:num, b} = n2
  
    case op do 
      {_, "+"} -> a + b
      {_, "-"} -> a - b
      {_, "*"} -> a * b
      {_, "/"} -> div(a, b)
    end
  end

end
