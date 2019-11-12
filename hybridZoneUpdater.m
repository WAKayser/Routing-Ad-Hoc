function [metric, routing] = hybridZoneUpdater(connMatrix)

    numNodes = length(connMatrix);
    routing(numNodes, numNodes, 2) = 0;
    metric.numRoute = 0;
    routing(:, :, 2) = inf;
    % Closest zone
    for n = 1:numNodes
        routing(n, n, 1) = n;
        routing(n, n, 2) = 0;
        % ask neighbors to respond
        metric.numRoute = metric.numRoute + 1;
        neighbors = find(connMatrix(:, n));
        % All neighbors respond
        routing(n, neighbors, 1) = neighbors;
        routing(n, neighbors, 2) = 1; 
    end
    
    %Second step zone, node broadcast all their neighbores
    for n = 1:numNodes
        metric.numRoute = metric.numRoute + 1;
        neighbors = find(routing(n, :, 2)==1);
        numN = length(neighbors);
        for x = 1:numN
            for y = 1:numN
                n1 = neighbors(x);
                n2 = neighbors(y);
                if routing(n1, n2, 2) > 2
                    routing(n1, n2, 1) = n;
                    routing(n1, n2, 2) = 2;
                end
            end
        end
    end
end