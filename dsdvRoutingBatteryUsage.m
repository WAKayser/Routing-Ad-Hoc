function [metric, batteries, path] = dsdvRoutingBatteryUsage(dsdvTable, connMatrix, traffic, batteries, dataUse)

    metric.numData = 0;
    metric.failure = 0;
    
    empty = find(batteries < 0);
    connMatrix(empty, :) = 0;
    connMatrix(:, empty) = 0;
    
    for i = 1:size(traffic, 2)
       pathLength = dsdvTable(traffic(1, i), traffic(2, i), 2);
       next = traffic(1, i);
       path = next;
       if pathLength < inf
           for n = 1:pathLength
               previous = next;
               if batteries(previous) > 0
                   batteries(previous) = batteries(previous) - dataUse;
               end
               next = dsdvTable(previous, traffic(2, i), 1);
               path = [path next];
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
    metric.success = size(traffic, 2) - metric.failure;
end
