function r = ellipse_radius_per_theta(distance_to_foci, foci_to_center, L, theta)

    myEq = @(x) sum_dist_to_foci(x, theta, foci_to_center, L) - distance_to_foci;  % parameterized function
    r = fzero(myEq,1);
end