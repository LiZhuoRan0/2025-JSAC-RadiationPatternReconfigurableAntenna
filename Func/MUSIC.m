function [varphi_C_rx, theta_C_rx,...
                varphi_J, theta_J] = MUSIC(Para, Y_C2U)
%% Estimate Jammer and Controler's angle
% input
%       Para
%       Y_C2U               Para.N_ant_U x Para.N_s x Para.N_h_C
% output
%       estimated angle
%% 1. Obtain Noise subspace
Y_C2U_1 = reshape(Y_C2U, Para.N_ant_U, []);
Ryy = (Y_C2U_1 * Y_C2U_1') / (Para.N_s*Para.N_h_C);
[V, D] = eig(Ryy);
lambda = diag(D);
[~, idx] = sort(lambda, 'descend');
V = V(:, idx);
M = Para.N_ant_U;

V_noise = V(:, 3:end);
%% 2. Estimate angle
Allazi = -90:90;
Allele = -90:90;

A = zeros(M, length(Allazi)*length(Allele));
count = 1;
for i_a = 1:length(Allazi)
    for i_e = 1:length(Allele)
        A(:, count) = reshape(exp(1j*2*pi*( ...
            (0:Para.N_ant_azi_U-1).' * cosd(Allele(i_e)) * sind(Allazi(i_a))/2 + ...
             (0:Para.N_ant_ele_U-1) * sind(Allele(i_e))/2)), ...
            [M, 1]);
        count = count + 1;
    end
end
tmp = sum(abs(A' * V_noise).^2, 2);
Spectrum = reshape(1./tmp, 181, 181);
local_max = imregionalmax(Spectrum);

% Extract indices of local Maximum
[row_indices, col_indices] = find(local_max > 0);

% Extract local Maximum
peak_values = local_max(local_max > 0);

% Sort local Maximum
[~, sorted_indices] = sort(peak_values, 'descend');
row_indices_sorted = row_indices(sorted_indices);
col_indices_sorted = col_indices(sorted_indices);

% Extract top targets
if length(row_indices_sorted) >=2
    num_targets = 2;
    selected_rows = row_indices_sorted(1:num_targets);
    selected_cols = col_indices_sorted(1:num_targets);
else% avoid length(row_indices_sorted) <2
    selected_rows = randi(181, [2,1]);
    selected_cols = randi(181, [2,1]);
end
% Mapping to angles
est_azimuth = selected_cols-91; % azimuth
est_elevation = selected_rows-91; % elevation

% Visualization
% figure;
% imagesc(-90:90, -90:90, Spectrum);
% colorbar;
% xlabel('Azimuth (°)');
% ylabel('Elevation (°)');
% title('Angular Spectrum');
% hold on;
% plot(est_azimuth, est_elevation, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
% hold off;


%% 3. Find Controler LoS by using Matching Filter
% 1. sum of Y_C2U over the sampling dimension
S_U = mean(Y_C2U, 2);
[a,~,c] = size(S_U);
S_U = reshape(S_U,a,c);

% 2. generate steering vectors in each receive antenna for each angle
varphi = repelem(-90:90, 181);
theta = repmat(-90:90, 1, 181);
C_bar = conj(Gen_SteeringVec(varphi.', theta.', Para.N_ant_ele_U, Para.N_ant_azi_U));

% 3. Matching
PHI = S_U.';
% 3.1 inner product
Gamma = (Para.C_norm_alg).' * PHI;
Gamma_bar = Gamma.' .* C_bar;

% 3.2 update index
gamma = squeeze(sum(Gamma_bar, 1));
[~, index] = max(abs(gamma));

varphi_C_rx_LoS = floor((index.'-1)./Para.N_a_azi)-90;
theta_C_rx_LoS = mod(index.'-1, Para.N_a_azi)-90;

[~, index] = min(abs(est_azimuth-theta_C_rx_LoS) + abs(est_elevation-varphi_C_rx_LoS));
varphi_C_rx = est_elevation(index);
theta_C_rx = est_azimuth(index);
varphi_J = est_elevation(3-index);
theta_J = est_azimuth(3-index);
end
