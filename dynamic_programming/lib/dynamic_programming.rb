class DynamicProgramming

  def initialize
    @blair_num_cache = {
      1=>1, 2=>2
    }
    @frog_hop_top_cache = {
      1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    @frog_hop_super_cache = {0=>[[]], 1=>[[1]]}
    # @napsack_cache = {}
    @maze_cache = {}
  end

  def blair_nums(n)
    # Base case(s): which inputs n should return early?
    return @blair_num_cache[n] if @blair_num_cache[n]
    # Recursive case: what's the recursive relationship?
    ans = blair_nums(n - 1) + blair_nums(n - 2) + (((n - 1) * 2) - 1)
    @blair_num_cache[n] = ans
    ans
    # *NB*: you'll need to figure out how to express the nth odd number in terms of n.
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    cache = { 1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    (4..n).each do |steps|
      cache[steps] =
        (cache[steps-3].map { |route| route + [3] } +
        cache[steps-2].map { |route| route + [2] } +
        cache[steps-1].map { |route| route + [1] })
    end
    # p (cache[4-3].map { |route| route << 3 } +
    #     cache[4-2].map { |route| route << 2 } +
    #     cache[4-1].map { |route| route << 1 })
      # ans = cache[steps - 1] + cache[steps - 2] + cache[steps - 3]
      # cache[steps] = ans
    cache
  end

  def frog_hops_top_down(n)
    return @frog_hop_top_cache[n] if @frog_hop_top_cache[n]
    answer = frog_hops_top_down_helper(n)
    @frog_hop_top_cache[n] = answer
    answer
  end

  def frog_hops_top_down_helper(n)
    return @frog_hop_top_cache[n] if @frog_hop_top_cache[n]
    frog_hops_top_down_helper(n-3).map {|route| route + [3]} +
    frog_hops_top_down_helper(n-2).map {|route| route + [2]} +
    frog_hops_top_down_helper(n-1).map {|route| route + [1]}
  end

  def super_frog_hops(n, k)
    super_frog_base(k)
    return @frog_hop_super_cache[n] if @frog_hop_super_cache[n]
    super_frog_cache_builder(n, k)
    @frog_hop_super_cache[n]
  end

  def super_frog_base(k)
    (2..k).each do |distance|
      @frog_hop_super_cache[distance] = []
      (1...distance).each do |remainder|
        @frog_hop_super_cache[distance - remainder].each do |route|
          @frog_hop_super_cache[distance] << route + [remainder]
        end
      end
      @frog_hop_super_cache[distance] << [distance]
    end
  end

  def super_frog_cache_builder(n, k)
    return @frog_hop_super_cache[n] if @frog_hop_super_cache[n]
    jump_potential = 1
    jumps = []
    while jump_potential <= k && jump_potential <= n
      jumps << super_frog_cache_builder(n-jump_potential, k).map { |route| route + [jump_potential] }
      jump_potential += 1
    end
    @frog_hop_super_cache[n] = jumps.inject(&:+)

    @frog_hop_super_cache[n]
  end


  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
