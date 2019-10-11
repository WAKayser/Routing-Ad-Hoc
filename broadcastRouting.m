function metric = broadcastRouting(connMatrix, traffic)
    
    % This broadcasts packages naively over the entire network. The
    % destination node does not broadcast further. This is basically worst
    % case scenario for amount of data packets broadcasted. However
    % complexity is low, uses no routing packets and has maximal success
    % probability. 

    G = graph(connMatrix);

    metric.numData = 0;
    metric.numRoute = 0;
    metric.success = 0;
    metric.failure = 0;
    
    for n = 1:length(traffic)
        firststage = traffic(n, 1);
        secondstage = [];
        while (length(firststage) ~= length(secondstage))
            for i = 1:length(firststage)
                x = firststage(i);
                if (x == traffic(n, 2)) && (~ismember(x, secondstage))
                    secondstage = [secondstage x];
                end
                if ~ismember(x, secondstage)
                    secondstage = [secondstage x];
                    metric.numData = metric.numData + 1;
                    recipients = neighbors(G, x);
                    for y = 1:length(recipients)
                        recipient = recipients(y);
                        if ~ismember(recipient, firststage) 
                            firststage = [firststage recipient]
                        end
                    end
                end 
            end
        end
        if ismember(traffic(n, 2), secondstage)
            metric.success = metric.success + 1;
        else
            metric.failure = metric.failure + 1;
        end
    end
end

