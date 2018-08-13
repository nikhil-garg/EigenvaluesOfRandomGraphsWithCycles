function d = sum_dist_to_foci(r, theta, F, L)

    d = 0;
    w = 2*pi/L;
    proj_x = r*cos(theta);
    proj_y = r*sin(theta);

    
    for l = 1:L
        angle = w*l;
        f_x = F*cos(angle);
        f_y = F*sin(angle);
        dist_to_focus = sqrt((proj_x - f_x)^2 + (proj_y - f_y)^2);
        d = d + dist_to_focus;
    end
        
end