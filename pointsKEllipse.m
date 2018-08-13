function pts = pointsKEllipse(dist_to_foci, foci_to_center, L, num_pts)
if nargin < 4
    num_pts = 200;
end
    pts = zeros(2,num_pts);
    w = 2*pi/num_pts;
    for n=1:num_pts
        angle = w*n;
        r = ellipse_radius_per_theta(dist_to_foci, foci_to_center, L, angle);
        if mod(L,2)==0 && foci_to_center < 0
            pts(1,n) = r*cos(angle + pi/L);
            pts(2,n) = r*sin(angle + pi/L);
        else
            pts(1,n) = r*cos(angle);
            pts(2,n) = r*sin(angle);
        end
    end


end