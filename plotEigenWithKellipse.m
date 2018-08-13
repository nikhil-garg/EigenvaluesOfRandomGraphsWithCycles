function plotEigenWithKellipse(W, L)
    r = rho(W,L);
    [D,F]=findKellipseParams(r, L);
    pts_kellipse = pointsKEllipse(D,F,L);

    x_boundary = [pts_kellipse(1,:), pts_kellipse(1,1)];
    y_boundary = [pts_kellipse(2,:), pts_kellipse(2,1)];

    h(1) = plot_eigenvalues(W);
    hold on
    plot(x_boundary, y_boundary,'w', 'LineWidth',2);
    h(2) = plot(x_boundary, y_boundary,'Color',[1, 0, 0, 0.6], 'LineWidth',2);
    hold off
    
    xlabel('Real Axis')
    ylabel('Imaginary Axis')
    title(['\tau = ',num2str(L), ', \rho_\tau =' num2str(r,3)])
    legend(h, 'Eigenvalues', '\tau-ellipse')
end