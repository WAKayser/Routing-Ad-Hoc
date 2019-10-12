function metric = idealRouting(connMatrix, traffic)

    % Assuming the connection matrix is known this always uses the
    % shortestpath and the least amount of sending time. This is not in the
    % real world, but it can be used for comparison. 

    metric.failure = 0;
    metric.success = 0;
    metric.numData = 0;
    metric.numRoute = 0;
    
    G = graph(connMatrix);
    d = G.distances;
    for n = 1:length(traffic)
        path = d(traffic(n, 1), traffic(n, 2));
        if path
            metric.success = metric.success + 1;
            metric.numData = metric.numData + path;
        end
    end
    metric.failure = length(traffic) - metric.success;
end

