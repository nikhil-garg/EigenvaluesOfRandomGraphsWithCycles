function mu = kellipseMoments(D, F,L, n, area_samples)
if nargin < 5
   area_samples = 200; 
end
    pts_kellipse = pointsKEllipse(D,F,L, area_samples);
    real_part = [pts_kellipse(1,:), pts_kellipse(1,1)];
    imag_part = [pts_kellipse(2,:), pts_kellipse(2,1)];
    
    boundary_complex = real_part + 1i*imag_part;
    %integral r^n = R^(n+1)/(n+1)
    moduli_integral = abs(boundary_complex).^(n+1)/(n+1);
    phase_integral = (boundary_complex./abs(boundary_complex)).^n;
    contrib_per_angle = moduli_integral.*phase_integral;
    mu = sum(contrib_per_angle*2*pi/area_samples);
end