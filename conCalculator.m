function connMatrix = conCalculator(nodes, J, distScale, run)

    % Uses the log normal probability to model fading and path loss. J can
    % be used to set the variance / path loss. Dist scale can be used to
    % further separate the nodes. Run can be used to maek sure the nodes
    % that do not move, do not change link state. 

    state = rng;
    rng(run);
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

