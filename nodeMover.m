function nodes = nodeMover(nodes)
    numNodes = length(nodes);
    for a = 1:numNodes
        newX = nodes(a).x + nodes(a).speed * cos(nodes(a).direction);
        newY = nodes(a).y + nodes(a).speed * sin(nodes(a).direction);
        if (newX < 0) || (newX > 1) || (newX < 0) || (newY > 1)
            nodes(a).direction = nodes(a).direction + pi;
            newX = nodes(a).x + nodes(a).speed * cos(nodes(a).direction);
            newY = nodes(a).y + nodes(a).speed * sin(nodes(a).direction);
        end
        nodes(a).x = newX;
        nodes(a).y = newY;
    end
end

