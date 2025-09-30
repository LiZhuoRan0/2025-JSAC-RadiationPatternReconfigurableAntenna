function Y_C2U = Reconstruct_Y(Para, Y_C2U)
%% remove controler's signal in Y_C2U
% input
%       Para
%       Y_C2U           previous
% output
%       Y_C2U           now
%% 1. Reconstruct channel
Rx           = Gen_SteeringVec(Para.varphi_C_rx, Para.theta_C_rx,...
              Para.N_ant_ele_U, Para.N_ant_azi_U);
Rx_3 = repmat(Rx, 1, 1, Para.N_h_J);% Nr x Lc x Nh
gain_3 = repmat(Para.gain_norm.', 1, 1, Para.N_h_J);% Nr x Lc x Nh

index = Para.theta_C_rx+91 + (Para.varphi_C_rx+90) *181;
gain_RPA = Para.C_norm(:, index).';% Lc x Nh

gain_RPA_3 = permute(repmat(gain_RPA, 1, 1, Para.N_ant_U), [3,1,2]);% Nr x Lc x Nh 

H_C = squeeze(sum(Rx_3 .* gain_3 .* gain_RPA_3, 2));% Nr x Lc x Nh -> Nr x Nh

%% 2. remove
Y_C2U = Y_C2U - permute(repmat(H_C, 1, 1, Para.N_s), [1,3,2]);
end