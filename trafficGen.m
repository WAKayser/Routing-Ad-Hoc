function traffic = trafficGen(numNodes, lambda)

    % Uses a poissonprocess to generate traffic for a certain period
    % between random nodes. 
    
    set = randperm(numNodes);
    numTraffic = min(floor(numNodes/2), max(2, poissrnd(lambda)));
    traffic = reshape(set(1:numTraffic*2), numTraffic, 2)';
end

