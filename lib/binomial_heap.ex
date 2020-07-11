defmodule BinomialHeap do
  @moduledoc """
  """


  defstruct rank: 0,
            root: :nil,
            children: []

  @type t(a) :: %BinomialHeap{
    rank: non_neg_integer(),
    root: a,
    children: list(t(a))
  } | :empty

  def empty(), do: []

  def rank(:empty), do: 0
  def rank(%BinomialHeap{rank: r}), do: r

  def root(:empty), do: nil
  def root(%BinomialHeap{root: x}), do: x

  def link(%BinomialHeap{rank: r1, root: x1, children: c1} = t1, %BinomialHeap{rank: _, root: x2, children: c2} = t2) do
    if x1 <= x2 do
      %BinomialHeap{rank: r1+1, root: x1, children: [t2 | c1]}
    else
      %BinomialHeap{rank: r1+1, root: x2, children: [t1 | c2]}
    end
  end

  def ins_tree(t, []), do: [t]
  def ins_tree(t, [t2 | tl2] = ts) do
    {rankT, rankT2} = {rank(t), rank(t2)}
    if rankT < rankT2 do
      [t | ts]
    else
      ins_tree(link(t, t2), tl2)
    end
  end

  def insert(x, ts) do
    ins_tree(%BinomialHeap{root: x}, ts)
  end

  def merge(ts, []), do: ts
  def merge([], ts), do: ts
  def merge([t1 | tl1] = ts1, [t2 | tl2] = ts2) do
    {rankT1, rankT2} = { rank(t1), rank(t2) }
    cond do
      rankT1 < rankT2 ->
        [t1 | merge(tl1, ts2)]
      rankT1 > rankT2 ->
        [t2 | merge(tl2, ts1)]
      rankT1 == rankT2 ->
        ins_tree(link(t1, t2), merge(tl1, tl2))
    end
  end

  def remove_min_tree([t]), do: {t, []}
  def remove_min_tree([t | tl]) do
    {t2, tl2} = remove_min_tree(tl)
    if t.root <= t2.root do
      {t, tl}
    else
      {t2, [t|tl2]}
    end
  end

  def find_min(ts) do
    {t, _} = remove_min_tree(ts)
    t.root
  end

  def delete_min(ts) do
    {t, tl} = remove_min_tree(ts)
    merge(Enum.reverse(t.children), tl)
  end

  def new([]), do: []
  def new(list) do
    list
    |> Enum.map(&(insert(&1, [])))
    |> Enum.reduce([], &(merge(&1, &2)))
  end

end
