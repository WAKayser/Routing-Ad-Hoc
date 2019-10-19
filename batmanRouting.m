function metric = batmanRouting(batmanTable, connMatrix, traffic)

    metric.numData = 0;
    metric.success = 0;
    
    for i = 1:length(traffic)
        start = traffic(i, 1);
        destination = traffic(i, 2);
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
end

