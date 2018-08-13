function [] = plotCirculantEigen(W, deg, distribution, display_rings)
if nargin < 3
    distribution = 'o';
end
if nargin < 4
    display_rings = 0;
end

    eigsCirculant = plot_eigenvalues(W);
    if display_rings
        hold on
        ringrad = findRadiiRings(eigsCirculant, deg, distribution);
        
        for rr = ringrad
            plot_circle(rr)
        end
        hold off
    end
    
    xlabel('Real Axis')
    ylabel('Imaginary Axis')
    title(['Degree = ',num2str(deg)])
    
    
    function plot_circle(radius)
        angles = (0:0.01:1)*2*pi;
        x_pts = radius*cos(angles);
        y_pts = radius*sin(angles);
        plot(x_pts, y_pts,'r', 'LineWidth',2);
    end
end