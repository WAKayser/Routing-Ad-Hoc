function [metric, path] = batmanRouting(batmanTable, connMatrix, traffic)

    metric.numData = 0;
    metric.success = 0;
    
    for i = 1:size(traffic, 2)
        start = traffic(1, i);
        destination = traffic(2, i);
        visited = 127 * ones(length(connMatrix), 1);
        hopcount = batmanTable(destination, start);
        visited(start) = hopcount;
       
        while hopcount > -1
            current = find(visited == hopcount);
            [neighbors, ~] = find(connMatrix(:, current));
            metric.numData = metric.numData + length(current);
            for j = 1:length(neighbors)
                if batmanTable(destination, neighbors(j)) < hopcount
                    visited(neighbors(j)) = batmanTable(destination, neighbors(j));
                end
            end
            hopcount = hopcount - 1;
        end
        if visited(destination) < 127
            metric.success = metric.success + 1;
        end
    end
    metric.failure = length(traffic) - metric.success;
    path = find(visited < 127);
end
