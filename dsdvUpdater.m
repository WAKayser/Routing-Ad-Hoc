function [metric, routing] = dsdvUpdater(routing, connMatrix)

    metric.numRoute = 0;
    oldNumData = inf;
    
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
            oldNeighbors = setdiff(find(routing(n, :, 2) == 1), neighbors);
            for x = 1:length(oldNeighbors)
                oldNeighbor = oldNeighbors(x);
                routing(n, oldNeighbor, 1) = 0;
                routing(n, oldNeighbor, 2) = inf;
                routing(n, oldNeighbor, 3) = routing(n, oldNeighbor, 3) + 1;
                metric.numRoute = metric.numRoute + 1;
            end
            for x = 1:length(neighbors)
                neighbor = neighbors(x);
                for entry = 1:length(connMatrix)
%                     if true
                    if routing(neighbor, entry, 3) >= routing(n, entry, 3)
                        if mod(routing(neighbor, entry, 3), 2)
                            if routing(n, neighbor, 1) == neighbor
                                
                                metric.numRoute = metric.numRoute + ~(routing(n, entry, 3) == routing(neighbor, entry, 3));
                                routing(n, entry, 1) = 0;
                                routing(n, entry, 2) = inf;
                                routing(n, entry, 3) = routing(neighbor, entry, 3);
                            end                            
                        else
                            if (routing(neighbor, entry, 2) + 1) < routing(n, entry, 2)
                                routing(n, entry, 1) = neighbor;
                                routing(n, entry, 2) = routing(neighbor, entry, 2) + 1;
                                routing(n, entry, 3) = 2 * floor(routing(neighbor, entry, 3)/2) + 2;
                                metric.numRoute = metric.numRoute + 1;
                            end
                        end
                    end
                end
            end          
        end
    end
end

