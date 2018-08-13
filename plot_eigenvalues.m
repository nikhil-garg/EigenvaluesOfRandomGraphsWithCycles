function [h] = plot_eigenvalues(W)
    eigenvals = eig(W);
    x_pts = real(eigenvals);
    y_pts = imag(eigenvals);
    
    axis_lim = max(abs(eigenvals)) + 0.1;
    
    h = plot(x_pts, y_pts, 'b.');
    %xlim([-axis_lim axis_lim])
    %ylim([-axis_lim axis_lim])
    axis([-axis_lim axis_lim -axis_lim axis_lim])
    xlabel('Real Axis')
    ylabel('Imaginary Axis')
end