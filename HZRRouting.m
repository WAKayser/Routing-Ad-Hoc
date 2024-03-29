function [metric, path] = HZRRouting(HZRTable, traffic)

    metric.numData = 0;
    metric.success = 0;
    metric.numRoute = 0;
    
    for i = 1:size(traffic, 2)
        start = traffic(1, i);
        destination = traffic(2, i);
        shortestPath = inf;
        
        if HZRTable(start, destination, 2) == 1
            metric.numData = metric.numData + 1;
            metric.success = metric.success + 1;
            path = [start destination];
        elseif HZRTable(start, destination, 2) == 2
            metric.numData = metric.numData + 2;
            metric.success = metric.success + 1;
            path = [start HZRTable(start, destination, 1) destination];
        else
            visited = find(HZRTable(start, :, 2) < 3);
            edgesA = find(HZRTable(start, :, 2) == 2);
            for a = 1:length(edgesA)
                aHop = edgesA(a);
                metric.numRoute = metric.numRoute + 1;
                if (HZRTable(aHop, destination, 2) < 3)
                    if (2 + HZRTable(aHop, destination, 2)) < shortestPath
                        shortestPath = 2 + HZRTable(aHop, destination, 2);
                        if HZRTable(aHop, destination, 2) == 1
                            path = [start HZRTable(start, aHop, 1) aHop destination];
                        else
                            path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, destination, 1) destination];
                        end
                    end
                else
                    edgesB = find(HZRTable(aHop, :, 2) == 2);
                    edgesB = setdiff(edgesB, visited);
                    visited = unique([visited find(HZRTable(aHop, :, 2) < 3)]);
                    for b = 1:length(edgesB)
                        bHop = edgesB(b);
                        metric.numRoute = metric.numRoute + 1;
                        if (HZRTable(bHop, destination, 2) < 3)
                            if (4 + HZRTable(bHop, destination, 2)) < shortestPath
                                shortestPath = 4 + HZRTable(bHop, destination, 2);
                                
                                if HZRTable(bHop, destination, 2) == 1
                                    path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, bHop, 1) bHop destination];
                                else
                                    path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, bHop, 1) bHop HZRTable(bHop, destination, 1) destination];
                                end
                                
                            end
                        else
                            edgesC = find(HZRTable(bHop, :, 2) == 2);
                            edgesC = setdiff(edgesC, visited);
                            visited = unique([visited find(HZRTable(bHop, :, 2) < 3)]);
                            for c = 1:length(edgesC)
                                cHop = edgesC(c);
                                metric.numRoute = metric.numRoute + 1;
                                if (HZRTable(cHop, destination, 2) < 3)
                                    if (6 + HZRTable(cHop, destination, 2)) < shortestPath
                                        shortestPath = 6 + HZRTable(cHop, destination, 2);
                                        
                                        if HZRTable(cHop, destination, 2) == 1
                                            path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, bHop, 1) bHop HZRTable(bHop, cHop, 1) cHop destination];
                                        else
                                            path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, bHop, 1) bHop HZRTable(bHop, cHop, 1) cHop HZRTable(cHop, destination, 1) destination];
                                        end
                                        
                                    end
                                else
                                    edgesD = find(HZRTable(cHop, :, 2) == 2);
                                    edgesD = setdiff(edgesD, visited);
                                    visited = unique([visited find(HZRTable(cHop, :, 2) < 3)]);
                                    for d = 1:length(edgesD)
                                        dHop = edgesD(d);
                                        metric.numRoute = metric.numRoute + 1;
                                        if (HZRTable(dHop, destination, 2) < 3)
                                            if (8 + HZRTable(dHop, destination, 2)) < shortestPath
                                                shortestPath = 8 + HZRTable(dHop, destination, 2);
                                                
                                                if HZRTable(cHop, destination, 2) == 1
                                                    path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, bHop, 1) bHop HZRTable(bHop, cHop, 1) cHop HZRTable(cHop, dHop, 1) dHop destination];
                                                else
                                                    path = [start HZRTable(start, aHop, 1) aHop HZRTable(aHop, bHop, 1) bHop HZRTable(bHop, cHop, 1) cHop HZRTable(cHop, dHop, 1) dHop HZRTable(dHop, destination, 1) destination];
                                                end
                                                
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if shortestPath < inf
                metric.numData = metric.numData + shortestPath;
                metric.success = metric.success + 1;
            end
        end
    end
    metric.failure = size(traffic, 2) - metric.success;
end

