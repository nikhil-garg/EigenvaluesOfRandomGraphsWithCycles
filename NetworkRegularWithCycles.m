function W = NetworkRegularWithCycles(N, D, L, S)
%Creates network where every node has a degree sum(D) and all the cycles
%with length L= l_1, l_2,... so that d_k is the count of edges associated
%to cycle of length l_k
    W = zeros(N, N);
    
    repetitions = 0;
    repetitions_allowed = 10000;
    
    normalization = 1/sqrt(sum(D));
    
    for cycle_idx = 1:length(L)
        cycle_length = L(cycle_idx);
        cycle_deg = D(cycle_idx);
        cycle_sign = S(cycle_idx);
        
        if cycle_deg ~= 0
        if cycle_length == 0
            count_rand_edges = N*cycle_deg;
            empty_slots_out = ones(1,N)*cycle_deg;
            empty_slots_in = ones(1,N)*cycle_deg;
            
            while count_rand_edges > 0
                node_origin = randsample(N, 1, true, empty_slots_out);
                node_dest = randsample(N, 1, true, empty_slots_in);
                
                if W(node_origin, node_dest) == 0
                    W(node_origin, node_dest) = 2*randi([0,1]) - 1;
                    count_rand_edges = count_rand_edges - 1;
                  
                    empty_slots_in(node_dest) = empty_slots_in(node_dest) - 1;
                    empty_slots_out(node_origin) = empty_slots_out(node_origin) - 1;
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
            empty_slots = ones(1, N)*cycle_deg;
            
            while count_cycles > 0
                candidate_cycle = randsample(N,cycle_length, true, empty_slots);
                valid_cycle = check_cycle(candidate_cycle, W);
                
                if valid_cycle
                    cumulated_sign = 1;
                    for cycle_idx = 1:(cycle_length - 1)

                        sign = 2*randi([0,1]) - 1;
                        cumulated_sign = cumulated_sign * sign;
                        node_origin = candidate_cycle(cycle_idx);
                        node_dest = candidate_cycle(cycle_idx + 1);
                        W(node_origin, node_dest) = sign;

                        empty_slots(node_origin) = empty_slots(node_origin) - 1;
                    end
                    
                   node_origin = candidate_cycle(cycle_length);
                   node_dest = candidate_cycle(1);
                   W(node_origin, node_dest) = cumulated_sign * cycle_sign;
                   
                   empty_slots(node_origin) = empty_slots(node_origin) - 1;
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

end