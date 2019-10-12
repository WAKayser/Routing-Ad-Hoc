function nodes = nodeCreator(N, probMoving, maxSpeed)

    % Generates n amound of nodes, some of which move at a speed that is
    % uniformly distributed between 0 and maxSpeed.
    % Also, a random direction is chosen. 

    for i = 1:N
        nodes(i).location = rand + rand*1j;
        nodes(i).speed = (rand < probMoving) * rand * maxSpeed;
        nodes(i).direction = 2 * pi * rand;
    end
end

