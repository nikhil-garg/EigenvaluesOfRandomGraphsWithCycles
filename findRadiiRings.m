function [radii] = findRadiiRings(eigsCirculant, D, distribution)
    if nargin < 3
        distribution = 'o';
    end
    if distribution == 'g'
        scaling = 0.52984;
    else
        scaling = 1;
    end
    
    
    nR = numberOfRings(D);
    radii = zeros(1,nR);

    x_vals = real(eigsCirculant);
    y_vals = imag(eigsCirculant);

    %first, get rid of the points on the real line
    th = 0.5*scaling;
    x_vals = x_vals(y_vals > th | y_vals < -th);
    y_vals = y_vals(y_vals > th | y_vals < -th);

    moduli2 = x_vals.^2 + y_vals.^2;
    
    prevRad = 0;
    for k = 1:nR
        [maxR, minR] = ringBounds(k, D);
        %minR = max(prevRad, minR);
        eig_mod = moduli2(moduli2 > minR & moduli2 < maxR);
        %edges = minR:precision:maxR;
        [counts,edges] = histcounts(eig_mod);
        [~, idx] = max(counts);
        radii(k) = sqrt((edges(idx) + edges(idx + 1))/2);
        %radii(k) = sqrt((edges(idx + 1)));
        prevRad = radii(k);
    end
%We can verify this     
%histogram(sqrt(moduli2), 100)

function nR = numberOfRings(D)
    nR = floor((D+1)/2);
end
function [maxR, minR] = ringBounds(k, D)
    coeff = (scaling-1);
    if mod(D,2) == 0
        maxR = (2*k+1)+coeff;
        minR = (2*k-1)+coeff;
    else
        maxR = (2*k)+coeff;
        minR = (2*k - 2)+coeff;
    end
end
end