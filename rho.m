function [r] = rho(W, L)
    r = 1/length(W)*sum(diag(W^L));
end