function metric = broadcastRouting(connMatrix, traffic)
    
    % This broadcasts packages naively over the entire network. The
    % destination node does not broadcast further. This is basically worst
    % case scenario for amount of data packets broadcasted. However
    % complexity is low, uses no routing packets and has maximal success
    % probability. 

    metric.numData = 0;
    metric.numRoute = 0;
    metric.success = 0;
    
    for n = 1:size(traffic, 2)
        firststage = traffic(1, n);
        secondstage = traffic(2, n);
        difference = firststage;
        
        while difference
            secondstage = [secondstage difference];
            metric.numData = metric.numData + length(difference);
            
            [neighbors, ~] = find(connMatrix(:, difference));
            firststage = [neighbors' firststage];
            log = ~builtin('_ismemberhelper', firststage, sort(secondstage));
            difference = sort(firststage(log));
            if ~isempty(difference)
                difference = difference([true diff(difference)~=0]);
            else
                difference = [];
            end
            
        end
        metric.success = metric.success + ismember(traffic(2, n), firststage);
    end
    metric.failure = length(traffic) - metric.success;
end
