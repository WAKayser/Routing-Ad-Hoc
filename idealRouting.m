function metric = idealRouting(connMatrix, traffic)

    % Assuming the connection matrix is known this always uses the
    % shortestpath and the least amount of sending time. This is not in the
    % real world, but it can be used for comparison. 

    metric.failure = 0;
    metric.success = 0;
    metric.numData = 0;
    metric.numRoute = 0;
  
    for n = 1:length(traffic)
        state = zeros(1, 50);
        state(traffic(n, 1)) = 1;
        steps = 0;
        while ~state(traffic(n, 2)) && steps < 12
            state = state * connMatrix;
            steps = steps + 1;
        end
        
        if steps < 12
            metric.success = metric.success + 1;
            metric.numData = metric.numData + steps;
        end
    end
    metric.failure = length(traffic) - metric.success;
end

