defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0 
  def count([_h | t]), do: 1 + count(t)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([], _postfix), do: [] 
  def reverse([x], postfix), do: [x | postfix]
  def reverse([h | t], postfix), do: reverse(t, [h | postfix])

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([x], f), do: [f.(x)]
  def map([h | t], f), do: [f.(h) | map(t, f)]  

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []
  def filter([x], f), do: f.(x) && [x] || []
  def filter([h | t], f), do: f.(h) && [h | filter(t, f)] || filter(t, f)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc 
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f) 

  @spec append(list, list) :: list
  def append([], b), do: b 
  def append(a, []), do: a
  def append([h | t], b), do: [h | append(t, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([[x] | remains]), do: [x | concat(remains)] 
  def concat([h | t]), do: reduce(t, h, &append(&2, &1)) 
end
