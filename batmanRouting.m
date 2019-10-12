function [metric, routingTable] = batmanRouting(routingTable, connMatrix, nodes, update, updateMoving)

    numNodes = length(connMatrix);
    order = randperm(numNodes);
    
    G = graph(connMatrix);
    
    updateList = [];
    
    for i = 1:numNodes 
        node = order(i);
        if rand < (update + nodes(node).speed * updateMoving)
            updateList = [updateList node];
        end
    end
    
    for i = 1:length(updateList)
        start = updateList(i);
        firststage = [start];
        hopcount = 1;
        secondstage = [];
        while(length(firststage) ~= length(secondstage))
            disp(firststage)
            disp(secondstage)
            for i = 1:length(firststage)
                x = firststage(i);
                if ~ismember(x, secondstage)
                    secondstage = [secondstage x];
                    metric.numData = metric.numData + 1;
                    recipients = G.neighbors(x);
                    for y = 1:length(recipients)
                        recipient = recipients(y);
                        if ~ismember(recipient, firststage)
                            firststage = [firststage recipient];
                            routingTable(start, recipient) = hopcount;
                        end
                    end
                end
            end
            hopcount = hopcount + 1;
        end
    end
end

