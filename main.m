% Playground for testing out routing in a single scenario. This can be
% extended to have multiple different scenarios.

clear;

numNodes = 50;

nodes = nodeCreator(numNodes, 0.5, 0.01);
connectivity = conCalculator(nodes, 2, 5);
[metric(1).batman, batmanTable] = batmanUpdater(zeros(50), connectivity, nodes, 1, 0);

for t = 1:100
    traffic = trafficGen(numNodes, 10);
    
    results(t).oneHop = oneHopRouting(connectivity, traffic);
    results(t).broadcast = broadcastRouting(connectivity, traffic);
    results(t).ideal = idealRouting(connectivity, traffic);
    
    nodes = nodeMover(nodes);
    connectivity = conUpdater(connectivity, nodes, 2, 5);
    [metric(t+1).batman, batmanTable] = batmanUpdater(zeros(50), connectivity, nodes, 0.1, 0.1);
end
