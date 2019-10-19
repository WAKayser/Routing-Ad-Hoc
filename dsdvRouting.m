function metric = dsdvRouting(dsdvTable, connMatrix, traffic)

    metric.numData = 0;
    metric.failure = 0;
    
    for i = 1:length(traffic)
       pathLength = dsdvTable(traffic(i, 1), traffic(i, 2), 2);
       if pathLength < inf
           metric.numData = metric.numData + pathLength;
       else
           metric.failure = metric.failure + 1;
       end
    end
    metric.success = length(traffic) - metric.failure;
end

