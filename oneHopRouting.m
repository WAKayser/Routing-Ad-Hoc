function metric = oneHopRouting(connMatrix, traffic)

    % uses just a single broadcast to try and reach the destination node.
    % Will fail often, but uses the least amount of packets. 

    metric.success = 0;
    for a = 1:size(traffic, 2)
        metric.success = metric.success + connMatrix(traffic(1,a), traffic(2, a));
    end
    metric.failure = size(traffic, 2) - metric.success;
    
    metric.numData = size(traffic, 2);
    metric.numRoute = 0;
end
