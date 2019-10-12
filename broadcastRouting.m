function metric = broadcastRouting(connMatrix, traffic)
    
    % This broadcasts packages naively over the entire network. The
    % destination node does not broadcast further. This is basically worst
    % case scenario for amount of data packets broadcasted. However
    % complexity is low, uses no routing packets and has maximal success
    % probability. 

    metric.numData = 0;
    metric.numRoute = 0;
    metric.success = 0;
    metric.failure = 0;
    
    for n = 1:length(traffic)
        firststage = traffic(n, 1);
        secondstage = traffic(n, 2);
        
        difference = setdiff(firststage, secondstage);
        
        while difference
            
            secondstage = [secondstage difference];
            metric.numData = metric.numData + length(difference);
            
            [neighbors, ~] = find(connMatrix(:, difference));
            firststage = unique([neighbors' firststage]);
            difference = setdiff(firststage, secondstage);
        end
        if ismember(traffic(n, 2), secondstage)
            metric.success = metric.success + 1;
        else
            metric.failure = metric.failure + 1;
        end
    end
end

