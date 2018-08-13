rho_max = 1/3;

rhos = 0:0.005:0.18;
F_vals = zeros(size(rhos));
D_vals = zeros(size(rhos));


for idx = 1:length(rhos)
    [D,F] = findKellipseParams(rhos(idx), 3);
    F_vals(idx) = F;
    D_vals(idx) = D;
end

subplot(1,3,1)
plot(rhos, F_vals)

subplot(1,3,2)
plot(rhos, D_vals)

subplot(1,3,3)
scatter(D_vals, F_vals)