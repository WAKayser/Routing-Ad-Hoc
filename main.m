% Playground for testing out routing in a single scenario. This can be
% extended to have multiple different scenarios.

clear;

numNodes = 50;

start = zeros(numNodes, numNodes, 3);
start(:, :, 2) = inf;
  
nodes = nodeCreator(numNodes, 0.5, 0.01);
connMatrix = conCalculator(nodes, 2, 6);
batteriesA = rand(50, 1);
batteriesB = batteriesA;

[results(1).batmanU, batmanTable] = batmanUpdater(ones(numNodes) * 127, connMatrix, nodes, 1, 0);
[results(1).dsdvU, dsdvTable] = dsdvUpdater(start, connMatrix);
[results(1).HZRU, HZRTable] = hybridZoneUpdater(connMatrix);
[results(1).dsdvUA, dsdvTableA, batteriesA] = dsdvUpdaterBatteryUsage(start, connMatrix, batteriesA, 0.0001);
[results(1).dsdvUB, dsdvTableB, batteriesB] = dsdvUpdaterBatteryRouting(start, connMatrix, batteriesB, 0.0001);


for t = 1:100
    traffic = trafficGen(numNodes, 10);
    
    results(t).oneHop = oneHopRouting(connMatrix, traffic);
    results(t).broadcast = broadcastRouting(connMatrix, traffic);
    results(t).ideal = idealRouting(connMatrix, traffic);
    results(t).batmanR = batmanRouting(batmanTable, connMatrix, traffic);
    results(t).dsdvR = dsdvRouting(dsdvTable, connMatrix, traffic);
    results(t).HZRR = HZRRouting(HZRTable, traffic);
    [results(t).dsdvRA, batteriesA] = dsdvRoutingBatteryUsage(dsdvTableA, connMatrix, traffic, batteriesA, 0.001);
    [results(t).dsdvRB, batteriesB] = dsdvRoutingBatteryUsage(dsdvTableB, connMatrix, traffic, batteriesB, 0.001);
    
    nodes = nodeMover(nodes);
    connMatrix = conUpdater(connMatrix, nodes, 2, 5);
    [results(t+1).batmanU, batmanTable] = batmanUpdater(batmanTable, connMatrix, nodes, 1, 0);
    [results(t+1).dsdvU, dsdvTable] = dsdvUpdater(dsdvTable, connMatrix);
    [results(t+1).HZRU, HZRTable] = hybridZoneUpdater(connMatrix);
    [results(t+1).dsdvUA, dsdvTableA, batteriesA] = dsdvUpdaterBatteryUsage(dsdvTableA, connMatrix, batteriesA, 0.0001);
    [results(t+1).dsdvUB, dsdvTableB, batteriesB] = dsdvUpdaterBatteryRouting(dsdvTableB, connMatrix, batteriesB, 0.0001);
end

disp("oneHop, Ideal, Flooding, batman, DSDV, HZR, DSDV with battery, DSDV battery aware")
final = metricSquasher(results)