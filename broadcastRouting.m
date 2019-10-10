function metric = broadcastRouting(connMatrix, traffic)
    
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
                if x == traffic(n, 2)
                    secondstage = [secondstage x];
                end
                if ~ismember(x, secondstage)
                    secondstage = [secondstage x];
                    metric.numData = metric.numData + 1;
                    recipients = neighbors(G, x);
                    for y = recipients
                        if ~ismember(y, firststage) 
                            firststage = [firststage; y];
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

