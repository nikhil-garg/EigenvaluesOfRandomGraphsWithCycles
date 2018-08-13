function [ringRadii] = theoreticalRingRadii(degree, distribution)
    if distribution == 'g'
        scaling = 0.52984;
    else
        scaling = 1;
    end

    nR = numberOfRings(degree);
    ringRadii = zeros(1,nR);
    for k=1:nR
        if mod(degree,2) == 0
            ringRadii(k) = sqrt(2*k);
        else
            ringRadii(k) = sqrt(2*k-1);
        end
    end

function nR = numberOfRings(D)
    nR = floor((D+1)/2);
end
end