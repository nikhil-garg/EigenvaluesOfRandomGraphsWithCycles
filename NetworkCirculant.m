function W = NetworkCirculant(N, D, weigt_dist, sign_prob)
if nargin < 3
    weigt_dist = 'o';
end
if nargin < 4
    sign_prob = 0.5;
end

    W = zeros(N, N);
    
    for n=1:N
        node_origin = n;
        
        for d=0:D-1
            node_dest = mod(n+d,N) + 1;
            sign = signWeight();
            
            W(node_origin, node_dest) = weight(sign, weigt_dist);
        end
    end

   function w = weight(sign, distribution)
        if distribution == 'g'
            w = sign*abs(randn);
        else
            w = sign;
        end
   end
    
    function s = signWeight()
        r = rand;
        if sign_prob> r
            s = 1;
        else
            s = -1;
        end
    end
end