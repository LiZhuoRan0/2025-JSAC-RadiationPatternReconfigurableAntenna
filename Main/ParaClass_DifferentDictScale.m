classdef ParaClass_DifferentDictScale < handle
% Class of system parameters   

properties
    % 1. parameters
    N_ant_azi_U
    N_ant_ele_U
    N_ant_U             % # of UAV's antennas
    N_ant_C             % # of controler's antennas, the default orientation is horizontal
    N_p                 % # of radiation patterns
    N_p_azi         
    N_p_ele
    N_a                 % # of angle sample points for each radiation pattern
    N_a_azi     
    N_a_ele
    N_s                 % # of sample points for each hopping signal
    N_h                 % # of hopping signals
    N_h_J               % # of hopping signals for sensing jammer
    N_h_C               % # of hopping signals for sensing controler
    L_C                 % # of multi-path for controler
    L_J                 % # of multi-path for jammer
    N_I                 % # of radiation patterns for sensing jammer and controler during two hopping signals
    N_I_J               % the portion of N_I that belongs to the jammer 
    N_I_C               % the portion of N_I that belongs to the controler 

    varphi_J_ture       % true elevation angle from jammer to UAV
    theta_J_ture        % true azimuth angle from jammer to UAV
    varphi_C_tx_ture    % true elevation angle from controler to UAV
    theta_C_tx_ture     % true azimuth angle from controler to UAV
    varphi_C_rx_ture    % true elevation angle from controler to UAV
    theta_C_rx_ture     % true azimuth angle from controler to UAV
    varphi_J            % estimated elevation angle from jammer to UAV
    theta_J             % estimated azimuth angle from jammer to UAV
    varphi_C_tx         % estimated elevation angle from controler to UAV
    theta_C_tx          % estimated azimuth angle from controler to UAV
    varphi_C_rx         % estimated elevation angle from controler to UAV
    theta_C_rx          % estimated azimuth angle from controler to UAV

    P_C                 % transmit power of controler
    P_J                 % transmit power of jammer
%     G_J                 % antenna gain of jammer
    r_J_LoS             % distance from jammer to UAV
    r_J_NLoS            % distance from jammer to UAV
    r_C_LoS             % distance from jammer to UAV
    r_C_NLoS            % distance from jammer to UAV
    RCS                 % RCS of the scatterer
    sigma_C             % standard deviation of Gaussian Noise at the controler
    sigma_J             % standard deviation of Gaussian Noise transmitted by the Jammer
    sigma_U_est         % standard deviation of Gaussian Noise at the UAV in the estimation stage
    sigma_U_tx          % standard deviation of Gaussian Noise at the UAV in the transmission stage
    sigma_C_tx          % standard deviation of Gaussian Noise at the controler in the transmission stage
    gain_true           % ture amplitude, only large scale fading
    gain                % amplitude under Para.C, only large scale fading
    gain_norm           % amplitude under Para.C_norm, only large scale fading

    f_c                 % carrier frequency
    B                   % total bandwidth
    B_h                 % bandwidth for each hopping signal
    B_p                 % bandwidth for receive pilots
    T_h                 % time duration for each hopping signal
    T_I                 % time duration between adjacent hopping signal
    B_I                 % bandwidth between adjacent hopping signal
    T_unit              % time duration for maintaining one radiation pattern
    
    % 2. channel
    HPBW
    C                   % real, codebook of radiation pattern, amplitude rather than power
    C_vecnorm           % real, codebook of radiation pattern, amplitude rather than power
    C_norm              % real, normalized codebook of radiation pattern, amplitude rather than power
    C_alg               % we use in algorithm, codebook of radiation pattern, amplitude rather than power
    C_vecnorm_alg       % we use in algorithm, codebook of radiation pattern, amplitude rather than power
    C_norm_alg          % we use in algorithm, normalized codebook of radiation pattern, amplitude rather
    Ptn_J               % Pattern, gain from jammer to UAV
    Ptn_C               % Pattern, gain from controler to UAV
    Gain_J2U            % the gain array of the channel from jammer to UAV
    Gain_C2U            % the gain array in the 3 array composed H_C
    H_J                 % from jammer to UAV
    H_C                 % from controler to UAV
    
    % 3. indicator
    LoS                 %0: LoS, 1: NLoS
    Low                 %0: Low, 1: Original

end

methods
%% 
function obj = ParaClass_DifferentDictScale(P_C, P_J, HPBW, N, N_rx_ele, N_rx_azi, threshold, LoS, Low, DictScale)
    obj.LoS = LoS;
    obj.Low = Low;
    % independent 
    obj.N_ant_azi_U         = N_rx_azi;
    obj.N_ant_ele_U         = N_rx_ele;
    obj.N_ant_U             = obj.N_ant_azi_U * obj.N_ant_ele_U;
    obj.N_ant_C             = 2;
    obj.N_p_azi             = N;
    obj.N_p_ele             = N;
    obj.N_p                 = obj.N_p_azi*obj.N_p_ele;
    
    obj.N_a_azi             = 180/DictScale + 1;
    obj.N_a_ele             = 180/DictScale + 1;
    obj.N_a                 = obj.N_a_azi*obj.N_a_ele;
    
    obj.L_C                 = 2;
    obj.L_J                 = 1;        

    obj.P_C                 = P_C;% dBm
    obj.P_J                 = P_J;% dBm
%     obj.G_J                 = 10;% dBi
    obj.r_J_LoS             = 200;
    obj.r_J_NLoS            = 100;
    obj.r_C_LoS             = 200;
    obj.r_C_NLoS            = 100;
    obj.RCS                 = 10;

    obj.f_c                 = 2.44e9;
    obj.B                   = 84e6;
    obj.B_h                 = 1e6;
    obj.B_p                 = 10e6;
    obj.T_h                 = 1e-3;
    obj.T_I                 = 12e-3;
    obj.B_I                 = 20e6;
    obj.T_unit              = 0.1e-3;
    
    % dependent 
    obj.N_h                 = obj.N_p*2;
    obj.N_h_J               = obj.N_p;
    obj.N_h_C               = obj.N_p;
    obj.N_s                 = obj.T_unit * obj.B_p;
    obj.N_I                 = obj.T_I / obj.T_unit;
    obj.N_I_J               = obj.N_I*0.5;
    obj.N_I_C               = obj.N_I*0.5;
    
    obj.sigma_J             = sqrt(10^(obj.P_J/10));
    obj.sigma_C             = sqrt(10^((-174 + 10*log10(obj.B_p))/10));
    obj.sigma_U_est         = sqrt(10^((-174 + 10*log10(obj.B_p))/10));
    obj.sigma_U_tx          = sqrt(10^((-174 + 10*log10(obj.B_h))/10));
    obj.sigma_C_tx          = sqrt(10^((-174 + 10*log10(obj.B))/10));

    % others
    obj.HPBW                = HPBW;
    filename_real = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_Scale_0_5.mat', obj.HPBW, obj.N_p_azi);
    
    if Low == 1
        filename_alg = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_Scale_0_5.mat', obj.HPBW, obj.N_p_azi);
    else
        filename_alg = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_Scale_0_5_%ddB.mat', obj.HPBW, obj.N_p_azi, -threshold);
    end

    obj.C = sqrt(load(filename_real).Result);
    obj.C_vecnorm = vecnorm(obj.C);
    obj.C_norm = obj.C ./ vecnorm(obj.C);
    
    tem = sqrt(load(filename_alg).Result);
    obj.C_alg = SubSampleDict(tem, DictScale);
    obj.C_vecnorm_alg = vecnorm(obj.C_alg);
    obj.C_norm_alg = obj.C_alg ./ vecnorm(obj.C_alg);

    obj.Gen_Angle();
    obj.Gen_Pattern(DictScale);
    obj.Gen_Gain();
    obj.Gen_Channel();    
end
%% Generate true angle and estimated angle
function obj = Gen_Angle(obj)
    obj.varphi_J_ture          = -70 + (70-(-70))*rand();
    obj.theta_J_ture           = -70 + (70-(-70))*rand();
    obj.varphi_C_tx_ture       = -70 + (70-(-70))*rand(obj.L_C, 1);
    obj.theta_C_tx_ture        = -70 + (70-(-70))*rand(obj.L_C, 1);
    obj.varphi_C_rx_ture       = -70 + (70-(-70))*rand(obj.L_C, 1);
    obj.theta_C_rx_ture        = -70 + (70-(-70))*rand(obj.L_C, 1);
    obj.varphi_J               = 1000;
    obj.theta_J                = 1000;
    obj.varphi_C_tx            = 1000*ones(obj.L_C, 1);
    obj.theta_C_tx             = 1000*ones(obj.L_C, 1);
    obj.varphi_C_tx            = 1000*ones(obj.L_C, 1);
    obj.theta_C_tx             = 1000*ones(obj.L_C, 1);
end

%% Generate Para.N_h patterns for Para.N_h hopping signals
function obj = Gen_Pattern(obj, DictScale)
    % obj.N_h_J x 1
    index_J = (round((obj.varphi_J_ture+90)/0.5))*361 + round((obj.theta_J_ture+90)/0.5)+1;
    obj.Ptn_J = obj.C(:, index_J);

    % obj.N_h_C x obj.L_C
    index_C = (round((obj.varphi_C_rx_ture+90)/0.5))*361 + round((obj.theta_C_rx_ture+90)/0.5)+1;
    obj.Ptn_C = obj.C(:, index_C);
end

%% Generate channel gain, containing radiation pattern
function obj = Gen_Gain(obj)
    % obj.N_h_J x 1
    if obj.LoS == 0% LoS
        obj.Gain_J2U = exp(1j*2*pi*rand)*...
                      3e8/obj.f_c/...
                      (4*pi*obj.r_J_LoS)*...
                      obj.Ptn_J;
    else% NLoS
        obj.Gain_J2U = exp(1j*2*pi*rand)*...
                      3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_J_LoS * obj.r_J_NLoS)*...
                      obj.Ptn_J*sqrt(obj.RCS);
    end

    % obj.L_C x obj.N_h_C
    obj.Gain_C2U = zeros(obj.L_C, obj.N_h_C);
    obj.gain_true = zeros(2,1);
    % LoS or NLoS
    if obj.LoS == 0% LoS
        for j = 1:obj.N_h_C
            obj.Gain_C2U(1,j) = 3e8/obj.f_c/...
                          (4*pi*obj.r_C_LoS)*...
                          obj.Ptn_C(j,1);
        end
        obj.gain_true(1) = 3e8/obj.f_c/...
                  (4*pi*obj.r_C_LoS);
    else% NLoS
        for j = 1:obj.N_h_C
            obj.Gain_C2U(1,j) = 3e8/obj.f_c/...
                          ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)*...
                      obj.Ptn_C(j,1)*sqrt(obj.RCS);
        end
        obj.gain_true(1) = 3e8/obj.f_c/...
                          ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)*...
                          sqrt(obj.RCS);
    end

    obj.Gain_C2U(1,:) = obj.Gain_C2U(1,:) * exp(1j*2*pi*rand);
    % NLoS
    for j = 1:obj.N_h_C
        obj.Gain_C2U(2,j) = 3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)*...
                      obj.Ptn_C(j,2)*sqrt(obj.RCS);
    end
    obj.gain_true(2) = 3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)*...
                      sqrt(obj.RCS);
    obj.Gain_C2U(2,:) = obj.Gain_C2U(2,:) * exp(1j*2*pi*rand);
end

%% Generate the complete channel
function obj = Gen_Channel(obj)
    obj.H_J     = Gen_SteeringVec(obj.varphi_J_ture, obj.theta_J_ture,...
                  obj.N_ant_ele_U, obj.N_ant_azi_U)...
                  *obj.Gain_J2U.';

    Rx          = Gen_SteeringVec(obj.varphi_C_rx_ture, obj.theta_C_rx_ture,...
                  obj.N_ant_ele_U, obj.N_ant_azi_U);
    Tx          = Gen_SteeringVec(obj.varphi_C_tx_ture, obj.theta_C_tx_ture,...
                  obj.N_ant_C/2, obj.N_ant_C/2).';
    Rx_3        = repmat(Rx, [1, 1, obj.N_h_C]);
    Tx_3        = repmat(Tx, [1, 1, obj.N_h_C]);

    Gain_diag = zeros(obj.L_C, obj.L_C, obj.N_h_C);
    for i = 1:obj.L_C
        Gain_diag(i,i,:) = obj.Gain_C2U(i,:);
    end
    tmp         = pagemtimes(Gain_diag, Tx_3);
    obj.H_C     = pagemtimes(Rx_3, tmp);
end

%% Update channel gain, containing radiation pattern
function obj = Up_Gain(obj, n_RadiationPattern)
    % 1 x 1
    if obj.LoS == 0% LoS
        obj.Gain_J2U = 3e8/obj.f_c/...
                      (4*pi*obj.r_J_LoS)*...
                      obj.C(n_RadiationPattern, ...
                      round((obj.theta_J_ture + 90)*2)+1 + round((obj.varphi_J_ture + 90)*2)*(180*2+1));
    else% NLoS
        obj.Gain_J2U = 3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_J_LoS * obj.r_J_NLoS)*...
                      sqrt(obj.RCS)*...
                      obj.C(n_RadiationPattern, ...
                      round((obj.theta_J_ture + 90)*2)+1 + round((obj.varphi_J_ture + 90)*2)*(180*2+1));
    end
    % obj.L_C x 1
    obj.Gain_C2U = zeros(obj.L_C, 1);
    % LoS or NLoS
    if obj.LoS == 0% LoS
        obj.Gain_C2U(1) = 3e8/obj.f_c/...
                      (4*pi*obj.r_C_LoS)*...
                      obj.C(n_RadiationPattern,...
                      round((obj.theta_C_rx_ture(1) + 90)*2)+1 + round((obj.varphi_C_rx_ture(1) + 90)*2)*(180*2+1));
    else% NLoS
        obj.Gain_C2U(1) = 3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)*...
                      obj.C(n_RadiationPattern,...
                      round((obj.theta_C_rx_ture(1) + 90)*2)+1 + round((obj.varphi_C_rx_ture(1) + 90)*2)*(180*2+1))...
                      *sqrt(obj.RCS);
    end
    % NLoS
    obj.Gain_C2U(2) = 3e8/obj.f_c/...
                  ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)*...
                  obj.C(n_RadiationPattern,...
                  round((obj.theta_C_rx_ture(2) + 90)*2)+1 + round((obj.varphi_C_rx_ture(2) + 90)*2)*(180*2+1))...
                  *sqrt(obj.RCS);
end

%% Update the complete channel
function obj = Up_Channel(obj)
    obj.H_J     = Gen_SteeringVec(obj.varphi_J_ture, obj.theta_J_ture,...
                  obj.N_ant_ele_U, obj.N_ant_azi_U)...
                  *obj.Gain_J2U;

    Rx          = Gen_SteeringVec(obj.varphi_C_rx_ture, obj.theta_C_rx_ture,...
                  obj.N_ant_ele_U, obj.N_ant_azi_U);
    Tx          = Gen_SteeringVec(obj.varphi_C_tx_ture, obj.theta_C_tx_ture,...
                  obj.N_ant_C, 1).';
    obj.H_C     = Rx * diag(obj.Gain_C2U) * Tx;
end

%% Update channel gain, omini-directional radiation pattern
function obj = Up_Gain_omini(obj)
    % 1 x 1
    if obj.LoS == 0% LoS
        obj.Gain_J2U = exp(1j*2*pi*rand)*...
                      3e8/obj.f_c/...
                      (4*pi*obj.r_J_LoS);
    else% NLoS
        obj.Gain_J2U = exp(1j*2*pi*rand)*...
                      3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_J_LoS * obj.r_J_NLoS)*...
                      sqrt(obj.RCS);
    end
    
    % obj.L_C x 1
    obj.Gain_C2U = zeros(obj.L_C, 1);
    % LoS
    if obj.LoS == 0% LoS
        obj.Gain_C2U(1) = 3e8/obj.f_c/...
                      (4*pi*obj.r_C_LoS)...
                      * exp(1j*2*pi*rand);
    else% NLoS
        obj.Gain_C2U(1) = 3e8/obj.f_c/...
                      ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)...
                      *sqrt(obj.RCS)...
                      * exp(1j*2*pi*rand);
    end
    % NLoS
    obj.Gain_C2U(2) = 3e8/obj.f_c/...
                  ((4*pi)^1.5 * obj.r_C_LoS * obj.r_C_NLoS)...
                  *sqrt(obj.RCS)...
                  * exp(1j*2*pi*rand);
end

end
end