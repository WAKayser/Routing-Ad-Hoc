function [metric, routing] = dsdvUpdater(routing, connMatrix)

    metric.numRoute = 0;
    oldNumData = 1;
    numNodes = length(connMatrix);
    busy = 1;
    
    for n = 1:numNodes
        routing(n, n, 1) = n;
        routing(n, n, 2) = 0;
        neighbors = find(connMatrix(:, n));

        knownNeighbors = routing(n, :, 1);
        log = ~builtin('_ismemberhelper', knownNeighbors, sort([neighbors; 0]));
        oldNeighbors = sort(knownNeighbors(log));
        if ~isempty(oldNeighbors)
            oldNeighbors = oldNeighbors([true diff(oldNeighbors)~=0]);
        else
            oldNeighbors = [];
        end

        routing(n, oldNeighbors, 1) = 0;
        routing(n, oldNeighbors, 2) = inf;
        routing(n, oldNeighbors, 3) = floor(routing(n, oldNeighbors, 3)/2)*2 + 1;

        routing(oldNeighbors, n ,1) = 0;
        routing(oldNeighbors, n ,2) = inf;
        routing(oldNeighbors, n, 3) = floor(routing(oldNeighbors, n, 3)/2)*2 + 1;
%         metric.numRoute = metric.numRoute + 2*length(oldNeighbors);
    end
    
    while(busy)
        busy = 0;
        for n = 1:length(connMatrix)
            metric.numRoute = metric.numRoute + 1;
            for entry = 1:length(connMatrix)
                step = routing(n, entry, 1);
                if step && mod(routing(step, entry, 3), 2)
                    routing(n, entry, 1) = 0;
                    routing(n, entry, 2) = inf;
                    routing(n, entry, 3) = routing(step, entry, 3) + 2;
                    busy = 1; 
                end
            end
        end
    end
    
    metric.numRoute = metric.numRoute + 1;
    
    while(metric.numRoute ~= oldNumData)
        oldNumData = metric.numRoute;
        for n = 1:length(connMatrix)
            neighbors = find(connMatrix(:, n));
            for x = 1:length(neighbors)
                neighbor = neighbors(x);
                if routing(n, neighbor, 2) > 1
                    routing(n, neighbor, 1) = neighbor;
                    routing(n, neighbor, 2) = 1;
                    routing(n, neighbor, 3) = 2 * floor(routing(n, neighbor, 3)/ 2) + 2;
                    metric.numRoute = metric.numRoute + 1;
                end
                for entry = 1:length(connMatrix)
                    if (routing(neighbor, entry, 3) + 1) >= routing(n, entry, 3)
                        routing(n, entry, 3) = 2 * floor(routing(neighbor, entry, 3)/2);
                        distance = routing(neighbor, entry, 2) + routing(n, neighbor, 2);
                        if distance < routing(n, entry, 2)
                            routing(n, entry, 1) = neighbor;
                            metric.numRoute = metric.numRoute + 1;
                            routing(n, entry, 2) = distance;
                            routing(n, entry, 3) = routing(n, entry, 3);
                        end
                    end
                end
            end          
        end
    end
end

