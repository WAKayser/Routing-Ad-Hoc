function connMatrix = conCalculator(nodes, J, distScale)
%CONCALCULATOR Summary of this function goes here
%   Detailed explanation goes here
    
    state = rng;
    rng(0);
    numNodes = length(nodes);
    
    
    v = 10 / (sqrt(2) * log(10));
    connMatrix(numNodes, numNodes) = 0;
    
    for a = 2:numNodes
        for b = 1:(a-1)
            dist = distScale * sqrt((nodes(a).x - nodes(b).x)^2 + (nodes(a).x - nodes(b).x)^2);
            
            probability = 1/2 * (1 - erf(v * log(dist) / J));
            connection = rand < probability;
            connMatrix(a, b) = connection;
            connMatrix(b, a) = connection;
            
        end
    end
    rng(state);
end

