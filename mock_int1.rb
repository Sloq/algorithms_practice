class LinkedList
  def reverse
    @head, @tail = @tail, @head
    self.each do |link|
      link.next, link.prev = link.prev, link.next
    end
  end
end
