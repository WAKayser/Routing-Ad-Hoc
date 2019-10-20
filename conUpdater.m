function connMatrix = conUpdater(connMatrix, nodes, J, distScale)

    % Uses the log normal probability to model fading and path loss. J can
    % be used to set the variance / path loss. Dist scale can be used to
    % further separate the nodes. Run can be used to maek sure the nodes
    % that do not move, do not change link state. 

    numNodes = length(nodes);
    
    v = 10 / (sqrt(2) * log(10));
    connMatrix(numNodes, numNodes) = 0;
    
    for a = 2:numNodes
        for b = 1:(a-1)
            if (nodes(a).speed + nodes(b).speed) > 0
                dist = distScale * abs(nodes(a).location - nodes(b).location);
            
                probability = 1/2 * (erfc(v * log(dist) / J));
                connection = rand < probability;
                connMatrix(a, b) = connection;
                connMatrix(b, a) = connection; 
            end
        end
    end
end
