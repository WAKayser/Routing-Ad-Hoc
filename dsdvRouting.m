function metric = dsdvRouting(dsdvTable, connMatrix, traffic)

    metric.numData = 0;
    metric.failure = 0;
    
    for i = 1:length(traffic)
       pathLength = dsdvTable(traffic(i, 1), traffic(i, 2), 2);
       next = traffic(i, 1);
       if pathLength < inf
           for n = 1:pathLength
               previous = next;
               next = dsdvTable(previous, traffic(i, 2), 1);               
               metric.numData = metric.numData + 1;
               if (next == 0) || (connMatrix(previous, next) == 0)
                   metric.failure = metric.failure + 1;
                   break
               end
           end
       else
           metric.failure = metric.failure + 1;
       end
    end
    metric.success = length(traffic) - metric.failure;
end

