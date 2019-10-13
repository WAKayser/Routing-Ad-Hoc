% Playground for testing out routing in a single scenario. This can be
% extended to have multiple different scenarios.

clear;

numNodes = 50;

nodes = nodeCreator(numNodes, 0.5, 0.01);
connMatrix = conCalculator(nodes, 2, 5);
[metric(1).batman, batmanTable] = batmanUpdater(ones(50) * 127, connMatrix, nodes, 1, 0);

for t = 1:100
    traffic = trafficGen(numNodes, 10);
    
    results(t).oneHop = oneHopRouting(connMatrix, traffic);
    results(t).broadcast = broadcastRouting(connMatrix, traffic);
    results(t).ideal = idealRouting(connMatrix, traffic);
    results(t).batmanR = batmanRouting(batmanTable, connMatrix, traffic);
    
    nodes = nodeMover(nodes);
    connMatrix = conUpdater(connMatrix, nodes, 2, 5);
    [metric(t+1).batmanU, batmanTable] = batmanUpdater(batmanTable, connMatrix, nodes, 0.1, 0.1);
end
