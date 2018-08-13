function [dist_to_foci, foci_to_center] = findKellipseParams(rho, L)

    angle_1 = 0;
    angle_2 = pi/L;

   sign_rho = sign(rho);
   abs_rho = abs(rho);

    x0 = [L,0.5];
    [DF] = fsolve(@myEquations,x0);
    dist_to_foci = DF(1);
    foci_to_center = DF(2)*sign_rho;
    
    function err = myEquations(vec_DF)
        D = vec_DF(1);
        F = vec_DF(2);
        err = [0, 0];
        err(1) = sum_dist_to_foci(1+abs_rho, angle_1, F, L) - D;
        err(2) = sum_dist_to_foci(1-abs_rho, angle_2, F, L) - D;
    end
end