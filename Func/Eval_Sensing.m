function Error_sensing = Eval_Sensing(Para)
    
    Error = abs(Para.theta_C_rx_ture(1) - Para.theta_C_rx)...
                     + abs(Para.varphi_C_rx_ture(1) - Para.varphi_C_rx);
    [~, index] = min(Error);

    Error_sensing = [max(abs(Para.theta_J_ture - Para.theta_J)...
                     , abs(Para.varphi_J_ture - Para.varphi_J)),...
                     ...
                     max(abs(Para.theta_C_rx_ture(1) - Para.theta_C_rx(index))...
                     , abs(Para.varphi_C_rx_ture(1) - Para.varphi_C_rx(index)))].';
fprintf('True Controler Elevation: %d\n', Para.varphi_C_rx_ture(1))
fprintf('True Controler Azimuth  : %d\n', Para.theta_C_rx_ture(1))
fprintf('\n')
fprintf('Est. Controler Elevation: %d\n', Para.varphi_C_rx(index))
fprintf('Est. Controler Azimuth  : %d\n', Para.theta_C_rx(index))
end