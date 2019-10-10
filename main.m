clear;

numNodes = 50;

nodes = nodeCreator(numNodes, 0.5, 0.01);
connectivity = conCalculator(nodes, 3, 5);

for t = 1:100
    traffic = trafficGen(numNodes, 10);
    
    results(t).oneHop = oneHopRouting(connectivity, traffic);
    results(t).broadcast = broadcastRouting(connectivity, traffic);    
    
    nodes = nodeMover(nodes);
    connectivity = conCalculator(nodes, 2, 5);
end
