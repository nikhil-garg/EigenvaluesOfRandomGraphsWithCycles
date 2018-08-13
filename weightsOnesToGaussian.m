function W2 = weightsOnesToGaussian(W) 
    N = length(W);
    W2 = zeros(N,N);
    for n=1:N
        for m=1:N
            if W(n,m)~=0
                s = sign(W(n,m));
                norm_fact = abs(W(n,m));
                new_weight = abs(normrnd(0,norm_fact);
                W2(n,m) = new_weight*s;
            end
        end
    end
end