defmodule BinomialHeapTest do
  use ExUnit.Case
  doctest BinomialHeap

  test "create heap with insert" do
    lh = BinomialHeap.insert(5, [])
    lh = BinomialHeap.insert(7, lh)
    lh = BinomialHeap.insert(3, lh)
    lh = BinomialHeap.insert(8, lh)
    assert hd(lh).root == 3
  end

  test "create heap with new" do
    lh = BinomialHeap.new([5, 7, 3, 212, 1, 8])
    assert hd(lh).root == 1
  end

  test "find and delete min" do
    lh = BinomialHeap.new([5, 7, 3, 212, 1, 8])
    assert BinomialHeap.find_min(lh) == 1
    lh =  BinomialHeap.delete_min(lh)
    assert BinomialHeap.find_min(lh) == 3
    lh =  BinomialHeap.delete_min(lh)
    assert BinomialHeap.find_min(lh) == 5
  end

end
