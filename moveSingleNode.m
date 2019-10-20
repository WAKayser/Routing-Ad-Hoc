function [nodes, connMatrix] = moveSingleNode(nodes, connMatrix, node, loc)

    nodes(node).location = loc;
    for b = 1:length(nodes)
        dist = distScale * abs(nodes(node).location - nodes(b).location);

        probability = 1/2 * (1 - erf(v * log(dist) / J));
        connection = rand < probability;
        connMatrix(node, b) = connection;
        connMatrix(b, node) = connection;
    end
end

