defmodule LeftistHeapTest do
  use ExUnit.Case
  doctest LeftistHeap

  test "create heap with insert" do
    lh = LeftistHeap.insert(5, :empty)
    lh = LeftistHeap.insert(7, lh)
    lh = LeftistHeap.insert(3, lh)
    lh = LeftistHeap.insert(8, lh)
    assert lh.element == 3
  end

  test "create heap with new" do
    lh = LeftistHeap.new([5, 7, 3, 212, 1, 8])
    assert lh.element == 1
  end

  test "empty and not empty" do
    lh = LeftistHeap.new([5, 7, 3, 212, 1, 8])
    assert LeftistHeap.is_empty(lh) == false
    assert LeftistHeap.is_empty(LeftistHeap.empty()) == true
  end

  test "find and delete min" do
    lh = LeftistHeap.new([5, 7, 3, 212, 1, 8])
    assert LeftistHeap.find_min(lh) == 1
    lh =  LeftistHeap.delete_min(lh)
    assert LeftistHeap.find_min(lh) == 3
    lh =  LeftistHeap.delete_min(lh)
    assert LeftistHeap.find_min(lh) == 5
  end

  test "size" do
    lh = LeftistHeap.new([5, 7, 3, 212, 1, 8])
    assert LeftistHeap.size(lh) == 6
    lh =  LeftistHeap.delete_min(lh)
    assert LeftistHeap.size(lh) == 5
    lh =  LeftistHeap.delete_min(lh)
    assert LeftistHeap.size(lh) == 4
    lh = LeftistHeap.new([3, 212])
    assert LeftistHeap.size(lh) == 2
  end
end
