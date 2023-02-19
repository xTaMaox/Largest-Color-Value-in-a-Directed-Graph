def largest_path_value(color, edges)
  color = color.split("").map { |c| c.ord - "a".ord }
  n = color.size
  graph = 0.upto(n - 1).map { [] }
  in_degree = [0] * n

  edges.each do |u, v|
    graph[u] << v
    in_degree[v] += 1
  end

  qu = []
  cnt = 0.upto(n - 1).map { [0] * 26 }
  0.upto(n - 1) do |u|
    next if in_degree[u] != 0

    qu.push(u)
    cnt[u][color[u]] = 1
  end

  ret, seen = 0, 0
  until qu.empty?
    u = qu.shift
    ret = [ret, cnt[u][color[u]]].max
    seen += 1

    graph[u].each do |v|
      0.upto 25 do |i|
        add = i == color[v] ? 1 : 0
        cnt[v][i] = [cnt[v][i], cnt[u][i] + add].max
      end
      qu << v if (in_degree[v] -= 1).zero?
    end
  end

  seen < n ? -1 : ret
end