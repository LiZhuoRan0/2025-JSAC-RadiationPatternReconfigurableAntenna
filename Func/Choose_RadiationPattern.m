function [Success_Choose, ...
          n_RadiationPattern, ...
          m_RadiationPattern] = Choose_RadiationPattern(Para, gain)
% input
%       gain                    values of sparse vector, N x 1
% output
%       Success_Choose          1: success, 0: failure
%       n_RadiationPattern      ours
%       m_RadiationPattern      best
%%
    gain = mean(abs(gain), 2);
    i_C = Para.theta_C_rx + 91 + (Para.varphi_C_rx + 91 - 1)*181;
    i_J = Para.theta_J + 91 + (Para.varphi_J + 91 - 1)*181;
    All_RadiationPtn = (Para.C_norm(:,i_C).^2*abs(gain).^2)./Para.C(:,i_J).^2;
    [~,n_RadiationPattern] = max(All_RadiationPtn);

    i_C = round(Para.theta_C_rx_ture) + 91 + (floor(Para.varphi_C_rx_ture) + 91 - 1)*181;
    i_J = round(Para.theta_J_ture) + 91 + (floor(Para.varphi_J_ture) + 91 - 1)*181;
    gain_C = [ 3e8/Para.f_c/...
                      (4*pi*Para.r_C_LoS) ;
                        3e8/Para.f_c/...
                      ((4*pi)^1.5 * Para.r_C_LoS * Para.r_C_NLoS)*...
                      sqrt(Para.RCS)];
    All_RadiationPtn = (Para.C(:,i_C).^2*gain_C.^2)./(Para.C(:,i_J).^2);
    [~,m_RadiationPattern] = max(All_RadiationPtn);  
    
    Success_Choose = n_RadiationPattern==m_RadiationPattern;
end