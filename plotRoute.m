function plotRoute(nodes, connMatrix, path)
   for x = 1:(length(path))
       for y = 1:length(path)
           if connMatrix(path(x), path(y))
               begin = nodes(path(x)).location;
               next = nodes(path(y)).location;
               plot([real(begin) real(next)], [imag(begin) imag(next)], 'color', 'red')
           end
       end
   end
end

