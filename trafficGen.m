function traffic = trafficGen(numNodes, lambda)
    set = randperm(numNodes);
    numTraffic = poissrnd(lambda);
    traffic = reshape(set(1:numTraffic*2), numTraffic, 2);
end

