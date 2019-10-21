function [metric] = metricSquasher(results)

    % oneHop, ideal, flooding, batman
    % success, failure, numData, numRoute
    
    metric(4, 6) = 0;
    
    for i = 1:length(results)-1
        metric(1, 1) = metric(1, 1) + results(i).oneHop.success;
        metric(2, 1) = metric(2, 1) + results(i).oneHop.failure;
        metric(3, 1) = metric(3, 1) + results(i).oneHop.numData;
        metric(4, 1) = metric(4, 1) + results(i).oneHop.numRoute;
        
        metric(1, 2) = metric(1, 2) + results(i).ideal.success;
        metric(2, 2) = metric(2, 2) + results(i).ideal.failure;
        metric(3, 2) = metric(3, 2) + results(i).ideal.numData;
        metric(4, 2) = metric(4, 2) + results(i).ideal.numRoute;
        
        metric(1, 3) = metric(1, 3) + results(i).broadcast.success;
        metric(2, 3) = metric(2, 3) + results(i).broadcast.failure;
        metric(3, 3) = metric(3, 3) + results(i).broadcast.numData;
        metric(4, 3) = metric(4, 3) + results(i).broadcast.numRoute;
        
        metric(1, 4) = metric(1, 4) + results(i).batmanR.success;
        metric(2, 4) = metric(2, 4) + results(i).batmanR.failure;
        metric(3, 4) = metric(3, 4) + results(i).batmanR.numData;
        metric(4, 4) = metric(4, 4) + results(i).batmanU.numRoute;
        
        metric(1, 5) = metric(1, 5) + results(i).dsdvR.success;
        metric(2, 5) = metric(2, 5) + results(i).dsdvR.failure;
        metric(3, 5) = metric(3, 5) + results(i).dsdvR.numData;
        metric(4, 5) = metric(4, 5) + results(i).dsdvU.numRoute;
        
        metric(1, 6) = metric(1, 6) + results(i).HZRR.success;
        metric(2, 6) = metric(2, 6) + results(i).HZRR.failure;
        metric(3, 6) = metric(3, 6) + results(i).HZRR.numData;
        metric(4, 6) = metric(4, 6) + results(i).HZRR.numRoute;
        metric(4, 6) = metric(4, 6) + results(i).HZRU.numRoute;
        
    end
end

