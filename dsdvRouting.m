function metric = dsdvRouting(dsdvTable, connMatrix, traffic)

    metric.numData = 0;
    metric.failure = 0;
    
    for i = 1:size(traffic, 2)
       pathLength = dsdvTable(traffic(1, i), traffic(2, i), 2);
       next = traffic(1, i);
       if pathLength < inf
           for n = 1:pathLength
               previous = next;
               next = dsdvTable(previous, traffic(2, i), 1);               
               metric.numData = metric.numData + 1;
               if (next == 0) || (connMatrix(previous, next) == 0)
                   metric.failure = metric.failure + 1;
                   break
               elseif (next == traffic(2, i))
                   break
               end
           end
       else
           metric.failure = metric.failure + 1;
       end
    end
    metric.success = length(traffic) - metric.failure;
end

