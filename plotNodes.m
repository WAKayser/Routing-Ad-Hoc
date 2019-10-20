function plotNodes(nodes, connMatrix)
    clf;
    hold on;
    for n = 1:length(nodes)
        l(n) = nodes(n).location;
    end
    scatter(real(l), imag(l), 50);
    dx = 0.01; dy = 0.01;
    
    names = num2str([1:length(nodes)]');
    
    text(real(l) + dx, imag(l) + dy, names)
    
    for x = 1:length(nodes)
        for y = x:length(nodes)
            if connMatrix(x, y) 
                plot([real(l(x)) real(l(y))], [imag(l(x)) imag(l(y))], 'color', 'cyan')
            end
        end
    end
    title('Geometric representation of Ad-Hoc Network')
end

