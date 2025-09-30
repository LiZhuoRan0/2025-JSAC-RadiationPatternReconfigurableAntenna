function [Best_RadiationPattern,...
          Sele_RadiationPattern,...
          Best_Cmber,...
          Sele_Cmber] = Gen_RadiationMode_Cmber_MUSIC_NoJammer(Para)
%% Select the best radiation mode and design the combiner
% input
%       Para:
%           gain
%           jammer's angle
%           controler's angle
%           radiation pattern
%           antenna number
% output
%       Best_RadiationPattern       obtain radiation pattern by using true angle
%       Sele_RadiationPattern       obtain radiation pattern by using estimated angle
%       Cmber                       
%% 1. Initialization
epsilon = 1e-8;% threshold for stopping the iteration
% small = 0;
SIR_1 = 0;
SIR_2 = -inf;
Best_Cmber = ones(Para.N_ant_U, 1);
index_C = round(round(Para.varphi_C_rx_ture+90)*181 + Para.theta_C_rx_ture+91);
% index_J = round(round(Para.varphi_J_ture+90)*181 + Para.theta_J_ture+91);
%% 2. Alternative Optimization
while SIR_1 - SIR_2 > epsilon
%% -    2.1 Select Radiation Pattern

    P_B_C = abs(Best_Cmber' * Gen_SteeringVec(Para.varphi_C_rx_ture(1),...
             Para.theta_C_rx_ture(1), ...
             Para.N_ant_ele_U, Para.N_ant_azi_U))^2;
    % P_B_J = abs(Best_Cmber' * Gen_SteeringVec(Para.varphi_J_ture,...
    %              Para.theta_J_ture, ...
    %              Para.N_ant_ele_U, Para.N_ant_azi_U))^2;
    
    Numerator = sum(repmat(P_B_C, 1, Para.N_h_C) .* (Para.C_alg(:,index_C).^2).', 1);
    % Denumerator = sum(P_B_J .* (Para.C_alg(:,index_J).^2).', 1);
    % ration = Numerator./(Denumerator + small);
    ration = Numerator;
    [~, Best_RadiationPattern] = max(ration);

%% -    2.2 Design Combiner

    A = Para.C_alg(Best_RadiationPattern,index_C(1)).^2 *...
        Gen_SteeringVec(Para.varphi_C_rx_ture(1),...
             Para.theta_C_rx_ture(1), ...
             Para.N_ant_ele_U, Para.N_ant_azi_U) * ...
        Gen_SteeringVec(Para.varphi_C_rx_ture(1),...
             Para.theta_C_rx_ture(1), ...
             Para.N_ant_ele_U, Para.N_ant_azi_U)';   
    % B = Para.C_alg(Best_RadiationPattern,index_J).^2 *...
    %         Gen_SteeringVec(Para.varphi_J_ture,...
    %              Para.theta_J_ture, ...
    %              Para.N_ant_ele_U, Para.N_ant_azi_U) * ...
    %         Gen_SteeringVec(Para.varphi_J_ture,...
    %              Para.theta_J_ture, ...
    %              Para.N_ant_ele_U, Para.N_ant_azi_U)';
    % Best_Cmber = GEVD(A,B);
    [V, D] = eig(A);
    d = diag(D);
    [~, index] = max(d);
    v = V(:, index);
    Best_Cmber = v / norm(v);
%% 3. Determine whether the stopping condition is met
    % ratio = Best_Cmber'*A*Best_Cmber/(Best_Cmber'*B*Best_Cmber + small);
    ratio = Best_Cmber'*A*Best_Cmber;
    [SIR_1, SIR_2] = deal(ratio, SIR_1);
end
%% 1. Initialization
epsilon = 1e-8;% threshold for stopping the iteration
SIR_1 = 0;
SIR_2 = -inf;
Sele_Cmber = ones(Para.N_ant_U, 1);
index_C = (Para.varphi_C_rx+90)*181 + Para.theta_C_rx+91;
% index_J = (Para.varphi_J+90)*181 + Para.theta_J+91;
%% 2. Alternative Optimization
while SIR_1 - SIR_2 > epsilon
%% -    2.1 Select Radiation Pattern

    P_B_C = abs(Sele_Cmber' * Gen_SteeringVec(Para.varphi_C_rx,...
             Para.theta_C_rx, ...
             Para.N_ant_ele_U, Para.N_ant_azi_U))^2;
    % P_B_J = abs(Sele_Cmber' * Gen_SteeringVec(Para.varphi_J,...
    %              Para.theta_J, ...
    %              Para.N_ant_ele_U, Para.N_ant_azi_U))^2;
    
    Numerator = sum(repmat(P_B_C, 1, Para.N_h_C) .* (Para.C_alg(:,index_C).^2).', 1);
    % Denumerator = sum(P_B_J .* (Para.C_alg(:,index_J).^2).', 1);
    % ration = Numerator./(Denumerator + small);
    ration = Numerator;
    [~, Sele_RadiationPattern] = max(ration);

%% -    2.2 Design Combiner
    A = Para.C_alg(Sele_RadiationPattern,index_C).^2 *...
            Gen_SteeringVec(Para.varphi_C_rx,...
                 Para.theta_C_rx, ...
                 Para.N_ant_ele_U, Para.N_ant_azi_U) * ...
            Gen_SteeringVec(Para.varphi_C_rx,...
                 Para.theta_C_rx, ...
                 Para.N_ant_ele_U, Para.N_ant_azi_U)';
    % B = Para.C_alg(Sele_RadiationPattern,index_J).^2 *...
    %         Gen_SteeringVec(Para.varphi_J,...
    %              Para.theta_J, ...
    %              Para.N_ant_ele_U, Para.N_ant_azi_U) * ...
    %         Gen_SteeringVec(Para.varphi_J,...
    %              Para.theta_J, ...
    %              Para.N_ant_ele_U, Para.N_ant_azi_U)';
    % Sele_Cmber = GEVD(A,B);
    [V, D] = eig(A);
    d = diag(D);
    [~, index] = max(d);
    v = V(:, index);
    Sele_Cmber = v / norm(v);
%% 3. Determine whether the stopping condition is met
    % ratio = Sele_Cmber'*A*Sele_Cmber/(Sele_Cmber'*B*Sele_Cmber + small);
    ratio = Sele_Cmber'*A*Sele_Cmber;
    [SIR_1, SIR_2] = deal(ratio, SIR_1);
end
end

% function v = GEVD(A, B)
% epsilon = 1e-8; 
% B_regularized = B + epsilon * eye(size(B));
% [V, D] = eig(A, B_regularized);
% d = diag(D);
% [~, index] = max(d);
% v = V(:, index);
% v = v / norm(v);
% end