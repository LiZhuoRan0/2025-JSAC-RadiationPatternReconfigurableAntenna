function [varphi_C, theta_C, gain_norm, gain] = Est_CtrlerAngle(Para, Y_C2U)
%% Initial sensing of controler's angle
% input
%       Para
%       Y_C2U           received signal from controler to UAV, 
%                       Para.N_ant_U × Para.N_s × Para.N_h
% output
%       varphi_C        estimated elevation angle, Para.L_C × 1
%       theta_C         estimated azimuth angle, Para.L_C × 1
%       gain_norm       values of sparse vector, under Para.C_norm, Para.L_C(est.) x Para.N_ant_U
%       gain            values of sparse vector, under Para.C, Para.L_C(est.) x Para.N_ant_U
%%
% tic
% 1. sum of Y_C2U over the sampling dimension
S_U = mean(Y_C2U, 2);
[a,~,c] = size(S_U);
S_U = reshape(S_U,a,c);

% 2. generate steering vectors in each receive antenna for each angle
varphi = repelem(-90:90, 181);
theta = repmat(-90:90, 1, 181);
C_bar = conj(Gen_SteeringVec(varphi.', theta.', Para.N_ant_ele_U, Para.N_ant_azi_U));

% 3. OMP_MMV
PHI = S_U.';
index = [];

while 1
    % 3.1 inner product
    Gamma = (Para.C_norm_alg).' * PHI;
    Gamma_bar = Gamma.' .* C_bar;
%     Gamma_bar = abs(Gamma.');
    
    % 3.2 update index
    gamma = squeeze(sum(Gamma_bar, 1));
    [V, I] = max(abs(gamma));
    index = [index I];
    if isscalar(index)
        Max = V/10;
    else
        if V < Max
            break
        end
    end
    
    % 3.3 update residual
    PHI = S_U.' - Para.C_norm_alg(:,index)*(Para.C_norm_alg(:,index)\S_U.');
end
% fprintf('%f seconds elapsed for estimating Controler''s angles\n', toc);
% 4. convert to the estimated angle
varphi_C = floor((index.'-1)./Para.N_a_azi)-90;
theta_C = mod(index.'-1, Para.N_a_azi)-90;
gain_norm = Para.C_norm_alg(:,index)\S_U.';
gain = gain_norm./repmat(Para.C_vecnorm_alg(index).', 1, Para.N_ant_U);

% fprintf('True Controler Elevation: %d\n', round(Para.varphi_C_rx_ture(1)))
% fprintf('True Controler Azimuth  : %d\n', round(Para.theta_C_rx_ture(1)))
% fprintf('\n')
% fprintf('Est. Controler Elevation: %d\n', varphi_C(1))
% fprintf('Est. Controler Azimuth  : %d\n', theta_C(1))
end

