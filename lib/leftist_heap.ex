defmodule LeftistHeap do
  @moduledoc """
  Leftist heap
  """

  defstruct right: :empty,
            left: :empty,
            element: nil,
            rank: 1,
            size: 1

  @type t(a) :: %LeftistHeap{
    left: t(a),
    right: t(a),
    element: any(),
    rank: non_neg_integer(),
    size: non_neg_integer(),
  } | :empty

  def size(:empty), do: 0
  def size(%LeftistHeap{size: size}), do: size

  def rank(:empty), do: 0
  def rank(%LeftistHeap{rank: rank}), do: rank

  def makeT(x, a, b) do
    {rankA, rankB} = {rank(a), rank(b)}
    {sizeA, sizeB} = {size(a), size(b)}
    if rankA >= rankA do
      %LeftistHeap{element: x, rank: rankB + 1, size: sizeA + sizeB + 1, left: a, right: b}
    else
      %LeftistHeap{element: x, rank: rankA + 1, size: sizeA + sizeB + 1, left: b, right: a}
    end
  end

  def merge(h, :empty), do: h
  def merge(:empty, h), do: h
  def merge(%LeftistHeap{element: x, left: a1, right: b1} = h1, %LeftistHeap{element: y, left: a2, right: b2} = h2) do
    if x <= y do
      makeT(x, a1, merge(b1, h2))
    else
      makeT(y, a2, merge(h1, b2))
    end
  end


  @spec insert(any(), t(any())) :: t(any())
  def insert(x, :empty), do: %LeftistHeap{element: x}
  def insert(x, h) do
    x
    |> insert(:empty)
    |> merge(h)
  end

  def new([]), do: :empty
  def new(list) do
    list
    |> Enum.map(&(insert(&1, :empty)))
    |> Enum.reduce(:empty, &(merge(&1, &2)))
  end

  def empty(), do: :empty
  def is_empty(:empty), do: true
  def is_empty(%LeftistHeap{}), do: false

  def find_min(:empty), do: nil
  def find_min(%LeftistHeap{element: x}), do: x

  def delete_min(%LeftistHeap{left: a, right: b}), do: merge(a, b)

  def kth_max(list, k) do
      list
      |> Enum.reduce(:empty, fn x, h ->
        h = LeftistHeap.insert(x, h)
        if LeftistHeap.size(h) > k do
          LeftistHeap.delete_min(h)
        else
          h
        end
      end)
  end


end
