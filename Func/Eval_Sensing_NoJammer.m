function Error_sensing = Eval_Sensing_NoJammer(Para)
    
    Error = abs(round(Para.theta_C_rx_ture(1)) - Para.theta_C_rx)...
                     + abs(round(Para.varphi_C_rx_ture(1)) - Para.varphi_C_rx);
    [~, index] = min(Error);

    Error_sensing = [0,...
                     ...
                     max(abs(round(Para.theta_C_rx_ture(1)) - Para.theta_C_rx(index))...
                     , abs(round(Para.varphi_C_rx_ture(1)) - Para.varphi_C_rx(index)))].';
% fprintf('True Controler Elevation: %d\n', round(Para.varphi_C_rx_ture(1)))
% fprintf('True Controler Azimuth  : %d\n', round(Para.theta_C_rx_ture(1)))
% fprintf('\n')
% fprintf('Est. Controler Elevation: %d\n', Para.varphi_C_rx(index))
% fprintf('Est. Controler Azimuth  : %d\n', Para.theta_C_rx(index))
end