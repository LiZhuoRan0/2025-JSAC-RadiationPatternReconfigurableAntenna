function [SE_up, SE_dn] = Eval_SE(Para, Best_RadiationPattern, Sele_RadiationPattern, Best_Cmber, Sele_Cmber)
%%
% input
%       Para
%       Best_RadiationPattern       index of the mode
%       Sele_RadiationPattern       index of the mode
%       Best_Cmber                  
%       Sele_Cmber
% output
%       SE(1)   Best
%       SE(2)   ours
%       SE(3)   omini
%% 
    SE_up = zeros(3,1);
    SE_dn = zeros(3,1);
%% 1. Best
    Para.Up_Gain(Best_RadiationPattern);
    Para.Up_Channel();
    [~, S_Best_up, ~] = svd(Best_Cmber'*Para.H_C);
    [~, S_Best_dn, ~] = svd(Para.H_C.');
    S_Best_dn = S_Best_dn(1:min(size(S_Best_dn)), 1:min(size(S_Best_dn)));
    
    sigma2_Best_up = abs(Best_Cmber'*Para.H_J*10^(Para.P_J/20))^2 + Para.sigma_U_tx^2;
    sigma2_Best_dn = Para.sigma_C_tx^2;
    power_allocation_Best_up = Water_Filling(Best_Cmber'*Para.H_C, 10^(Para.P_C/10), sigma2_Best_up);
    power_allocation_Best_dn = Water_Filling(Para.H_C.', 10^(Para.P_C/10), sigma2_Best_dn);

    SE_up(1) = log2(1 + S_Best_up(1)*power_allocation_Best_up*S_Best_up(1)/sigma2_Best_up);
    % SE_dn(1) = log2(det(eye(Para.N_ant_C) + diag(S_Best_dn)*diag(power_allocation_Best_dn)*diag(S_Best_dn)/sigma2_Best_dn));
    SE_dn(1) = log2(det(eye(min(Para.N_ant_C, Para.N_ant_U)) + S_Best_dn*diag(power_allocation_Best_dn)*S_Best_dn/sigma2_Best_dn));

%% 2. reconfigurable antenna
    Para.Up_Gain(Sele_RadiationPattern);
    Para.Up_Channel();
    [~, S_RPA_up, ~] = svd(Sele_Cmber'*Para.H_C);
    [~, S_RPA_dn, ~] = svd(Para.H_C.');    
    S_RPA_dn = S_RPA_dn(1:min(size(S_RPA_dn)), 1:min(size(S_RPA_dn)));
    
    sigma2_RPA_up = abs(Sele_Cmber'*Para.H_J*10^(Para.P_J/20))^2 + Para.sigma_U_tx^2;
    sigma2_RPA_dn = Para.sigma_C_tx^2;
    power_allocation_RPA_up = Water_Filling(Sele_Cmber'*Para.H_C, 10^(Para.P_C/10), sigma2_RPA_up);
    power_allocation_RPA_dn = Water_Filling(Para.H_C.', 10^(Para.P_C/10), sigma2_RPA_dn);

    SE_up(2) = log2(1 + S_RPA_up(1)*power_allocation_RPA_up*S_RPA_up(1)/sigma2_RPA_up);
    % SE_dn(2) = log2(det(eye(Para.N_ant_C) + diag(S_RPA_dn)*diag(power_allocation_RPA_dn)*diag(S_RPA_dn)/sigma2_RPA_dn));
    SE_dn(2) = log2(det(eye(min(Para.N_ant_C, Para.N_ant_U)) + S_RPA_dn*diag(power_allocation_RPA_dn)*S_RPA_dn/sigma2_RPA_dn));
    
%% 3. Omini-directional 
    Para.Up_Gain_omini();
    Para.Up_Channel();
    [~, S_Omini_up, ~] = svd(Para.H_C);
    [~, S_dn, ~] = svd(Para.H_C.');    
    S_Omini_up = S_Omini_up(1:min(size(S_Omini_up)), 1:min(size(S_Omini_up)));
    S_dn = S_dn(1:min(size(S_dn)), 1:min(size(S_dn)));

    sigma2_omini_up = abs(Para.Gain_J2U*10^(Para.P_J/20))^2 + Para.sigma_U_tx^2;
    sigma2_omini_dn = Para.sigma_C_tx^2;
    power_allocation_omini_up = Water_Filling(Para.H_C, 10^(Para.P_C/10), sigma2_omini_up);
    power_allocation_omini_dn = Water_Filling(Para.H_C.', 10^(Para.P_C/10), sigma2_omini_dn);

    % SE_up(3) = log2(det(eye(min(Para.N_ant_U, Para.N_ant_C)) + S_Omini_up(1)*diag(power_allocation_omini_up)*S_Omini_up(1)/sigma2_omini_up));
    SE_up(3) = log2(det(eye(min(Para.N_ant_U, Para.N_ant_C)) + S_Omini_up*diag(power_allocation_omini_up)*S_Omini_up/sigma2_omini_up));
    % SE_dn(3) = log2(det(eye(Para.N_ant_C) + diag(S_dn)*diag(power_allocation_omini_dn)*diag(S_dn)/sigma2_omini_dn));
    SE_dn(3) = log2(det(eye(min(Para.N_ant_C, Para.N_ant_U)) + S_dn*diag(power_allocation_omini_dn)*S_dn/sigma2_omini_dn));

    % SE_up
    % SE_dn
end