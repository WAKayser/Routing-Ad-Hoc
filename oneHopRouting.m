function metric = oneHopRouting(connMatrix, traffic)

    % uses just a single broadcast to try and reach the destination node.
    % Will fail often, but uses the least amount of packets. 

    metric.success = 0;
    for a = 1:length(traffic)
        metric.success = metric.success + connMatrix(traffic(a, 1), traffic(a, 2));
    end
    metric.failure = length(traffic) - metric.success;
    
    metric.numData = length(traffic);
    metric.numRoute = 0;
end

