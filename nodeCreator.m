function nodes = nodeCreator(N, probMoving, maxSpeed)
%NODECREATOR Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:N
        nodes(i).x = rand;
        nodes(i).y = rand;
        nodes(i).speed = (rand < probMoving) * rand * maxSpeed;
        nodes(i).direction = 2 * pi * rand;
    end
end

