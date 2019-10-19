function [metric, routing] = dsdvUpdater(routing, connMatrix)

    metric.numRoute = 0;
    oldNumData = inf;
    
    while(metric.numRoute ~= oldNumData)
        oldNumData = metric.numRoute;
        for n = 1:length(connMatrix)
            routing(n, n, 1) = n;
            routing(n, n, 2) = 0;
            neighbors = find(connMatrix(:, n));
            oldNeighbors = setdiff(find(routing(n, :, 2) == 1), neighbors);
            for x = 1:length(oldNeighbors)
                oldNeighbor = oldNeighbors(x);
                routing(n, oldNeighbor, 1) = 0;
                routing(n, oldNeighbor, 2) = inf;
                routing(n, oldNeighbor, 3) = routing(n, oldNeighbor, 3) + 1;
                
                routing(oldNeighbor, n ,1) = 0;
                routing(oldNeighbor, n ,2) = inf;
                routing(oldNeighbor, n, 3) = routing(oldNeighbor, n, 3) + 1;
                metric.numRoute = metric.numRoute + 2;
            end
            for entry = 1:length(connMatrix)
                step = routing(n, entry, 1);
                if step
                    if mod(routing(step, entry, 3), 2)
                        metric.numRoute = metric.numRoute + 1;
                        routing(n, entry, 1) = 0;
                        routing(n, entry, 2) = inf;
                        routing(n, entry, 3) = routing(step, entry, 3) + 2;
                    end
                end
            end
        end
    end
    
    metric.numRoute = metric.numRoute + 1;
    
    while(metric.numRoute ~= oldNumData)
        oldNumData = metric.numRoute;
        for n = 1:length(connMatrix)
            routing(n, n, 1) = n;
            routing(n, n, 2) = 0;
            neighbors = find(connMatrix(:, n));
            for x = 1:length(neighbors)
                neighbor = neighbors(x);
                if routing(n, neighbor, 2) > 1
                    routing(n, neighbor, 1) = neighbor;
                    routing(n, neighbor, 2) = 1;
                    routing(n, neighbor, 3) = 2 * floor(routing(n, neighbor, 3)/ 2) + 2;
                    metric.numRoute = metric.numRoute + 1;
                end
            end
            for x = 1:length(neighbors)
                neighbor = neighbors(x);
                for entry = 1:length(connMatrix)
                    if routing(neighbor, entry, 3) >= routing(n, entry, 3)
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

