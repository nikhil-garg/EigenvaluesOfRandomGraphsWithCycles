function W = NetworkRandomWithCycles(N, D, L, S, weigt_dist)
%Creates network where every node has a degree sum(D) and all the cycles
%with length L= l_1, l_2,... so that d_k is the count of edges associated
%to cycle of length l_k
if nargin < 5
    weigt_dist = 'o';
end
    W = zeros(N, N);
    
    repetitions = 0;
    repetitions_allowed = 10000;
    
    normalization = 1/sqrt(sum(D));
    
    for cycle_idx = 1:length(L)
        cycle_length = L(cycle_idx);
        cycle_deg = D(cycle_idx); %avg number of cycles per node
        cycle_sign = S(cycle_idx);
        
        if cycle_deg ~= 0
        if cycle_length == 0
            count_rand_edges = N*cycle_deg;
            
            while count_rand_edges > 0
                candidate_edge = randsample(N, 2);
                node_origin = candidate_edge(1);
                node_dest = candidate_edge(2);
                
                if W(node_origin, node_dest) == 0
                    sign = 2*randi([0,1])-1;
                    W(node_origin, node_dest) = weight(sign, weigt_dist);
                    count_rand_edges = count_rand_edges - 1;
                    
                else
                    repetitions = repetitions + 1;
                    if repetitions > repetitions_allowed
                        txt = 'Too many trials, it seems the matrix cannot be created'
                        return
                    end
                end
            end
        else
            count_cycles = floor(cycle_deg*N/cycle_length);
            
            while count_cycles > 0
                candidate_cycle = randsample(N,cycle_length);
                valid_cycle = check_cycle(candidate_cycle, W);
                
                if valid_cycle
                    cumulated_sign = 1;
                    for cycle_idx = 1:(cycle_length - 1)

                        sign = 2*randi([0,1]) - 1;
                        cumulated_sign = cumulated_sign * sign;
                        node_origin = candidate_cycle(cycle_idx);
                        node_dest = candidate_cycle(cycle_idx + 1);
                        W(node_origin, node_dest) = weight(sign, weigt_dist);

                    end
                    
                   node_origin = candidate_cycle(cycle_length);
                   node_dest = candidate_cycle(1);
                   final_sign = cumulated_sign * cycle_sign;
                   W(node_origin, node_dest) = weight(final_sign, weigt_dist);
                   
                   count_cycles = count_cycles - 1;
                    
                else
                    repetitions = repetitions + 1;
                    if repetitions > repetitions_allowed
                        txt = 'Too many trials, it seems the matrix cannot be created'
                        return
                    end
                end
            end
        end
        end
        
    end
    
    W = W*normalization;
    
    function b =check_cycle(candidate, current_matrix)
        b = 1;
        if length(candidate) > length(unique(candidate))
            b=0;
        else
            for c_idx = 1:length(candidate)
                origin = candidate(c_idx);
                id_next = mod(c_idx,length(candidate)) + 1;
                dest = candidate(id_next);
                if current_matrix(origin,dest) ~= 0
                    b = 0;
                end
            end
        end
    end
    
    function w = weight(sign, distribution)
        if distribution == 'g'
            w = sign*abs(randn);
        else
            w = sign;
        end
    end
end