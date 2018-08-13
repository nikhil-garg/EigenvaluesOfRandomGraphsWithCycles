function plotKellipse(F, D, L)

    pts_kellipse = pointsKEllipse(D,F,L);

    x_boundary = [pts_kellipse(1,:), pts_kellipse(1,1)];
    y_boundary = [pts_kellipse(2,:), pts_kellipse(2,1)];
    M = max(max(abs(x_boundary)), max(abs(y_boundary)))*1.1;
    
    for l = 1:L
        angle = l/L*2*pi;
        h(2) = plot(F*cos(angle), F*sin(angle), 'ob','MarkerFaceColor','blue', 'MarkerSize',7);
        hold on
    end
    
    for l = 1:L
        angle = l/L*pi;
        h(3) = plot([M*cos(angle), -M*cos(angle)], [M*sin(angle), - M*sin(angle)], '--k');
    end
    
    h(1) = plot(x_boundary, y_boundary,'r', 'LineWidth',2);
    hold off
    legend(h, '\tau-ellipse', 'Foci', 'Axes')
    uistack(h,'top')
    set(gca,'XColor','none')
    set(gca,'YColor','none')
    axis([-M M -M M])
end