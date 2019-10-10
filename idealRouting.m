function metric = idealRouting(connMatrix, traffic)
    metric.failure = 0;
    metric.success = 0;
    metric.numData = 0;
    metric.numRoute = 0;
    
    G = graph(connMatrix);
    
    for n = 1:length(traffic)
        path = G.shortestpath(traffic(n, 1), traffic(n, 2));
        if isempty(path)
            metric.failure = metric.failure + 1;
        else
            metric.success = metric.success + 1;
            metric.numData = metric.numData + length(path);
        end
    end   
end

