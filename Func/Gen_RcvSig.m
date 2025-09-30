function Y = Gen_RcvSig(Para, indicator)
%%
% Generate received signal
% input
%       Para
%       indicator       'Jammer2UAV' or 'Ctrler2UAV'
% output
%       Y               Y_J2U or Y_C2U

%%
switch indicator
    case 'Jammer2UAV'
        H_J = reshape(Para.H_J, [Para.N_ant_U, 1, Para.N_h_J]);
        X_J_tmp = Para.sigma_J*(1/sqrt(2)*randn(Para.N_s, Para.N_h_J)...
              + 1j/sqrt(2)*randn(Para.N_s, Para.N_h_J));
        X_J = reshape(X_J_tmp, [1, Para.N_s, Para.N_h_J]);
        W_U = Para.sigma_C*(1/sqrt(2)*randn(Para.N_ant_U, Para.N_s, Para.N_h_J)...
              + 1j/sqrt(2)*randn(Para.N_ant_U, Para.N_s, Para.N_h_J));
        Y   = H_J.*X_J + W_U;
    case 'Ctrler2UAV_sensing'
        H_J = reshape(Para.H_J, [Para.N_ant_U, 1, Para.N_h_C]);
        X_J_tmp = Para.sigma_J*(1/sqrt(2)*randn(Para.N_s, Para.N_h_C)...
              + 1j/sqrt(2)*randn(Para.N_s, Para.N_h_C));
        X_J = reshape(X_J_tmp, [1, Para.N_s, Para.N_h_C]);

        X_C = sqrt(10^(Para.P_C/10))*ones(1, Para.N_s, Para.N_h_C);
        H_C = repmat(Para.H_C(:,1,:), 1, Para.T_unit*Para.B_p, 1);
        
        W_U = Para.sigma_C*(1/sqrt(2)*randn(Para.N_ant_U, Para.N_s, Para.N_h_C)...
              + 1j/sqrt(2)*randn(Para.N_ant_U, Para.N_s, Para.N_h_C));
        Y   = H_C.*X_C + H_J.*X_J + W_U;
    case 'Ctrler2UAV_NoJammer'
        X_C = sqrt(10^(Para.P_C/10))*ones(1, Para.N_s, Para.N_h_C);
        H_C = repmat(Para.H_C(:,1,:), 1, Para.T_unit*Para.B_p, 1);
        
        W_U = Para.sigma_C*(1/sqrt(2)*randn(Para.N_ant_U, Para.N_s, Para.N_h_C)...
              + 1j/sqrt(2)*randn(Para.N_ant_U, Para.N_s, Para.N_h_C));
        Y   = H_C.*X_C + W_U;        
    otherwise
        error('indicator of GenRcvSig is wrong!')
end

end

