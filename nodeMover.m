function nodes = nodeMover(nodes)
    
    % Nodes that move move in a straight line, up until they rech a border
    % in which case they take a turn of 180 degrees and move further. 

    numNodes = length(nodes);
    for a = 1:numNodes
        l = nodes(a).location + nodes(a).speed * exp(1j*nodes(a).direction);
        if l < 0 || l > 1 || imag(l) < 0 || imag(l) > 1
            nodes(a).direction = nodes(a).direction + pi;
            l = nodes(a).location + nodes(a).speed * exp(1j*nodes(a).direction);
        end
        nodes(a).location = l;
    end
end

