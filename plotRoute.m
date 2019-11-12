function plotRoute(nodes, path)
   for y = 1:(length(path)-1)
       begin = nodes(path(y)).location;
       next = nodes(path(y+1)).location;
       plot([real(begin) real(next)], [imag(begin) imag(next)], 'color', 'red')
   end
end

