% meathod 1 is equivalent to meathod 2
% meathod 1 more compact that meathod 2
clear
clc
close all
% if isempty(gcp('nocreate'))   
%     numWorkers = 10;      
%     parpool('local', numWorkers);
% end
%% User-defined parameters
N = 3; % Number of axis samples for both phi and theta axes
% Axis angles for phi and theta, from -60° to 60°
phi_axis = linspace(-90,90,N);
theta_axis = linspace(-90,90,N);

% Sampling grid for the pattern: phi and theta from -90° to 90° with 1° step
phi_samples_90 = -90:1:90;
theta_samples_90 = -90:1:90;
deg2rad_factor = pi/180;

% Preallocate result matrix
num_combinations = N*N;
num_samples = length(phi_samples_90)*length(theta_samples_90); % 181*181 = 32761
Result = zeros(num_combinations, num_samples);

%% Generate the direction patterns for each axis combination
tic
for i = 1:N
    current_phi_line = phi_axis(i);
    tmp = zeros(N, 181*181);
    for j = 1:N
        current_theta_line = theta_axis(j);
        
        % Generate gain pattern (linear scale)
        Gain = generate_gain_pattern(current_phi_line, current_theta_line);
        
        % Flatten and store in Result
        tmp(j,:) = reshape(Gain, 1, []);
    end
    Result(((i-1)*N+1) : i*N, :) = tmp;
end
toc
% filename = sprintf('../../Data/RadiationPattern/HPBW_65_Axis_90_New/RadiationPattern_%d.mat', N);
% save(filename, 'Result')
%% Visualization to verify correctness
% 1. Visualize a single pattern from Result
pattern_idx = floor(N/2)*N + ceil(N/2);
pattern_2D = reshape(Result(pattern_idx,:), length(theta_samples_90), length(phi_samples_90));

% Convert pattern to dB for coloring
pattern_dB = 10*log10(pattern_2D);

[PHI_deg, THETA_deg] = meshgrid(phi_samples_90, theta_samples_90);
PHI_rad = PHI_deg * deg2rad_factor;
THETA_rad = THETA_deg * deg2rad_factor;

% Convert to Cartesian coordinates (assuming phi: elevation, theta: horizontal)
x = pattern_2D .* cos(PHI_rad) .* cos(THETA_rad);
y = pattern_2D .* cos(PHI_rad) .* sin(THETA_rad);
z = pattern_2D .* sin(PHI_rad);


set(0,'defaultfigurecolor','w') 
figure; hold on; box on; grid on;
surf(x,y,z,pattern_dB,'EdgeColor','none','FaceColor','interp');
colormap jet;
h = colorbar;              
h.Label.String = 'dBi';
caxis([min(pattern_dB(:)), max(pattern_dB(:))]);
title('Single Pattern Visualization');
set(gca,'FontName','Times New Roman', 'FontSize', 16)
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal; grid on; box on;
view(-220,20);
material shiny;
% axis padded; % leave some margin around the figure

% Determine axis range for arrow axes
x_range = max(abs(x(:)));
y_range = max(abs(y(:)));
z_range = max(abs(z(:)));
axis_scale = max([x_range,y_range,z_range]) * 1.4;

hold on;
% Draw coordinate axes with arrows
arrow_size = 0.5; % Adjust arrow head size
% X-axis: green
quiver3(0,0,0, axis_scale,0,0, 'Color','g','LineWidth',2,'MaxHeadSize',arrow_size);
text(axis_scale*1.05,0,0,'X','FontSize',20,'FontWeight','Bold','Color','g');
% Y-axis: blue
quiver3(0,0,0,0,axis_scale*0.3,0, 'Color','b','LineWidth',2,'MaxHeadSize',arrow_size*3);
text(0,axis_scale*0.3,0,'Y','FontSize',20,'FontWeight','Bold','Color','b');
% Z-axis: red
quiver3(0,0,0,0,0,axis_scale*0.3, 'Color','r','LineWidth',2,'MaxHeadSize',arrow_size*3);
text(0,0,axis_scale*0.3,'Z','FontSize',20,'FontWeight','Bold','Color','r');


% 2. Visualize all patterns on one figure to verify correctness
figure; hold on; grid on; box on;
set(gca,'FontName','Times New Roman', 'FontSize', 16)
all_x = []; all_y = []; all_z = [];
for k = 1:num_combinations
    temp_2D = reshape(Result(k,:), length(theta_samples_90), length(phi_samples_90));
    
    xk = temp_2D .* cos(PHI_rad) .* cos(THETA_rad);
    yk = temp_2D .* cos(PHI_rad) .* sin(THETA_rad);
    zk = temp_2D .* sin(PHI_rad);
    
    all_x = [all_x; xk(:)];
    all_y = [all_y; yk(:)];
    all_z = [all_z; zk(:)];
    
    % Plot each pattern with some transparency
    surf(xk, yk, zk, temp_2D, 'EdgeColor', 'none', 'FaceColor', 'interp', 'FaceAlpha', 0.4);
end

colormap jet;
h = colorbar;              
h.Label.String = 'dBi';
title('All Patterns');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal; view(-220,20);
material shiny;
% axis padded; % leave some margin around the figure

% Recompute axis scale for combined figure
x_range_comb = max(abs(all_x(:)));
y_range_comb = max(abs(all_y(:)));
z_range_comb = max(abs(all_z(:)));
axis_scale_comb = max([x_range_comb,y_range_comb,z_range_comb]) * 1.4;

% Draw coordinate axes with arrows on the combined figure
arrow_size = 0.5;
quiver3(0,0,0, axis_scale_comb,0,0, 'Color','g','LineWidth',2,'MaxHeadSize',arrow_size);
text(axis_scale_comb*1.05,0,0,'X','FontSize',20,'FontWeight','Bold','Color','g');
quiver3(0,0,0,0,axis_scale_comb,0, 'Color','b','LineWidth',2,'MaxHeadSize',arrow_size);
text(0,axis_scale_comb*1.05,0,'Y','FontSize',20,'FontWeight','Bold','Color','b');
quiver3(0,0,0,0,0,axis_scale_comb, 'Color','r','LineWidth',2,'MaxHeadSize',arrow_size);
text(0,0,axis_scale_comb*1.05,'Z','FontSize',20,'FontWeight','Bold','Color','r');

% 3. Codebook
figure;
imagesc(10*log10(Result));
colormap(jet);
colorbar;
title('Codebook');
xlabel('Row');
ylabel('Column');
%% Function: generate_gain_pattern
function Gain = generate_gain_pattern(phi_line, theta_line)
    deg2rad_factor = pi/180;
    
    % 3GPP TR 38.901 pattern parameters
    theta_3dB = 65.0;           % Vertical HPBW [deg]
    phi_3dB = 65.0;             % Horizontal HPBW [deg]
    G_max = 8.0;                % Maximum directional gain [dBi]
    SLA_V = 30.0;       % Vertical side-lobe attenuation [dB]
    A_m = 30.0;         % Maximum attenuation [dB], 
    
    phi_samples_180 = -180:1:180;
    theta_samples_180 = -180:1:180;
    [PHI_deg, THETA_deg] = meshgrid(phi_samples_180, theta_samples_180);
    
    % Shift angles relative to (phi_line, theta_line)
%     PHI_rel_deg = PHI_deg - phi_line;
%     THETA_rel_deg = THETA_deg - theta_line;
    PHI_rel_deg = PHI_deg;
    THETA_rel_deg = THETA_deg;
    
    PHI_rel = PHI_rel_deg * deg2rad_factor;
    THETA_rel = THETA_rel_deg * deg2rad_factor;
    
    A_EV0 = -min(12*((PHI_rel/(phi_3dB*deg2rad_factor)).^2), SLA_V);
    A_EH0 = -min(12*((THETA_rel/(theta_3dB*deg2rad_factor)).^2), A_m);
    
    A0 = -min(-(A_EV0 + A_EH0), A_m);
    A0_linear = 10.^((A0)/10);
    
    P = (10.^((G_max)/10))*A0_linear / max(A0_linear,[],'all');
    Gain = P; % linear scale gain

    % Select angles that is to be plotted
    Gain = Gain(91-theta_line:271-theta_line, 91-phi_line:271-phi_line);
end
