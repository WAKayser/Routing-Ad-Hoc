function [metric, routingTable] = batmanUpdater(routingTable, connMatrix, nodes, update, updateMoving)

    numNodes = length(connMatrix);
    order = randperm(numNodes);
    
    metric.numRoute = 0;
    
    updateList = [];
    
    for i = 1:numNodes 
        node = order(i);
        if rand < (update + nodes(node).speed * updateMoving)
            updateList = [updateList node];
        end
    end
    
    for i = 1:length(updateList)
        start = updateList(i);
        firststage = start;
        secondstage = [];
        difference = firststage;
        hopcount = 0;
        
        while difference
            secondstage = [secondstage difference];
            routingTable(start, difference) = hopcount;
            
            metric.numRoute = metric.numRoute + length(difference);
            
            [neighbors, ~] = find(connMatrix(:, difference));
            firststage = [neighbors' firststage];
            log = ~builtin('_ismemberhelper', firststage, sort(secondstage));
            difference = sort(firststage(log));
            if ~isempty(difference)
                difference = difference([true diff(difference)~=0]);
            else
                difference = [];
            end
            hopcount = hopcount + 1;
        end
        
    end
end

