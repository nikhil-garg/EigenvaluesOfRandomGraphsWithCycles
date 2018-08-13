%MAIN SCRIPT
N = 5000;
distribution = 'o';

figure
subplot(1,2,1)
plotKellipse(0.7, 2, 2)

subplot(1,2,2)
plotKellipse(0.6, 2.3, 3)

figure
D = [10, 10; 12, 8; 15, 5; 20, 0];
for k = 1:4
    L = k + 1;
    W_P = NetworkRandomWithCycles(N, D(k,:), [L, 0], [1, 1], distribution);
    W_N = NetworkRandomWithCycles(N, D(k,:), [L, 0], [-1, 1], distribution);
    subplot(2,4,k)
    plotEigenWithKellipse(W_P, L);

    subplot(2,4,k + 4)
    plotEigenWithKellipse(W_N, L);
    
end

figure
for k = 1:8
    deg = k ;
    W = NetworkCirculant(N, deg, distribution);
    subplot(2,4,k)
    plotCirculantEigen(W, deg, distribution, 0);
end


figure
rings_exp = [];
rings_the = [];
degrees = [];

for k = 1:20
    deg = k ;
    W = NetworkCirculant(N, deg, distribution);
    eigsCirculant = eig(W);
    ringrad = findRadiiRings(eigsCirculant, deg, distribution);
    ringrad_theory = theoreticalRingRadii(deg, distribution);
    
    for r_idx = 1:length(ringrad)
        rings_exp = [rings_exp ringrad(r_idx)];
        rings_the = [rings_the, ringrad_theory(r_idx)];
        degrees = [degrees, deg];
    end
end

h(1) = plot(degrees, rings_exp, 'ob','MarkerFaceColor','blue');
hold on
h(2) = plot(degrees, rings_the, '^', 'Color',[1, 0, 0, 0.6], 'MarkerFaceColor',[1, 0.3, 0.3]);
hold off
xlabel('Degrees')
ylabel('Radii')
legend(h, 'Empirical Radii', 'Predicted Radii')
axis([0 20.5 0 4.5])

figure
subplot(2,2,1)
plot_eigenvalues(NetworkRandomWithCycles(N, [20, 0], [3, 0], [1, 1],'Color',[1, 0, 0, 0.6] ));
title('a')%title('Motifs with Gaussian Weights')
subplot(2,2,2)
plot_eigenvalues(NetworkCirculant(N, 3, 'g'));
title('b')%title('Circulant with Gaussian Weights')
subplot(2,2,3)
plot_eigenvalues(NetworkRandomWithCycles(N, [20, 6, 0], [3, 2, 0], [1, 1, 1], 'o'));
title('c')%title('Combining Motifs')
subplot(2,2,4)
plot_eigenvalues(NetworkCirculant(N, 3, 'o', 0.1));
title('d')%title('Circulant with Skewed Signs')
