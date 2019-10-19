% Playground for testing out routing in a single scenario. This can be
% extended to have multiple different scenarios.

clear;

numNodes = 5;

start = zeros(50, 50, 3);
start(:, :, 2) = inf;

  
nodes = nodeCreator(numNodes, 0.5, 0.01);
connMatrix = conCalculator(nodes, 2, 5);
[results(1).batmanU, batmanTable] = batmanUpdater(ones(numNodes) * 127, connMatrix, nodes, 1, 0);
[results(1).dsdvU, dsdvTable] = dsdvUpdater(start, connMatrix);

for t = 1:100
    traffic = trafficGen(numNodes, 10);
    
    results(t).oneHop = oneHopRouting(connMatrix, traffic);
    results(t).broadcast = broadcastRouting(connMatrix, traffic);
    results(t).ideal = idealRouting(connMatrix, traffic);
    results(t).batmanR = batmanRouting(batmanTable, connMatrix, traffic);
    results(t).dsdvR = dsdvRouting(dsdvTable, connMatrix, traffic);
    
    nodes = nodeMover(nodes);
    connMatrix = conUpdater(connMatrix, nodes, 2, 5);
    [results(t+1).batmanU, batmanTable] = batmanUpdater(batmanTable, connMatrix, nodes, 1, 0);
    [results(t+1).dsdvU, dsdvTable] = dsdvUpdater(dsdvTable, connMatrix);
end

disp("oneHop, Ideal, Flooding, batman, DSDV")
final = metricSquasher(results)