clear
clc
close all

% PatternType - 38.901
SLA_V = 30.0;     % Side-Lobe Attenuation in the vertical direction (dB)
theta_3dB = 65.0; % Vertical Half-Power Beam-Width (degrees)
A_m = 30.0;       % Maximum attenuation (dB)
phi_3dB = 65.0;   % Horizontal Half-Power Beam-Width (degrees)
G_max = 8.0;      % Maximum directional gain of an element (dBi)

dy = pi/180;  
dx = pi/180;

% New angle definitions
% theta: horizontal angle from -pi/2 to pi/2
% phi: elevation angle from -pi/2 to pi/2
% phi=0 means horizontal plane (x-y plane), phi=pi/2 means pointing toward the positive z-axis
% theta=0 means x-axis direction, positive theta approaching the y-axis direction
theta_vals = -pi/2:dy:pi/2;
phi_vals   = -pi/2:dx:pi/2;

[theta, phi] = meshgrid(theta_vals, phi_vals); 

% Vertical direction attenuation (using phi as elevation angle)
% Originally: A_EV0 = -min(12*((theta-90°)/theta_3dB)^2, SLA_V)
% Now phi=0 corresponds to horizontal (originally theta=90°),
% so (theta-90°) in the old code corresponds to phi*(180/pi) here.
A_EV0 = -min(12*((phi/(theta_3dB*pi/180)).^2), SLA_V);

% Horizontal direction attenuation (using theta as horizontal angle)
% Originally: A_EH0 = -min(12*(phi/(phi_3dB))^2, A_m)
% Replace phi with theta since we swapped their roles
A_EH0 = -min(12*((theta/(phi_3dB*pi/180)).^2), A_m);

A0 = -min(-(A_EV0 + A_EH0), A_m);
A0 = 10.^((A0 + G_max)/10);
P = 10.^((G_max) / 10) * A0 / max(A0, [], 'all');

plot_RPP_3D(theta,phi,P);
plot_RPP_polar(P, theta_vals, phi_vals)

function plot_RPP_3D(theta,phi,Ylm)
    set(0,'defaultfigurecolor','w')
    figure; hold on; box on; grid on;
    set(gca,'FontName','Times New Roman','FontSize',16);

    x = Ylm.*cos(phi).*cos(theta);
    y = Ylm.*cos(phi).*sin(theta);
    z = Ylm.*sin(phi);
    color = sqrt(x.^2+y.^2+z.^2);
    surf(x,y,z,color,'edgecolor','none','facecolor','interp');
    colormap parula;
    material shiny;  
    
    colorbarHandle = colorbar;
    colorbarHandle.Label.String = '   dB';
    colorbarHandle.Label.FontSize = 16;
    colorbarHandle.Label.FontName = 'Times New Roman';
    colorbarHandle.Label.Rotation = 90;
    colorbarHandle.Label.HorizontalAlignment = 'center';
    colorbarHandle.Label.VerticalAlignment = 'top';
    
    % Axes arrows
    quiver3(0, 0, 0, 10, 0, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.5); % X-axis (Green)
    quiver3(0, 0, 0, 0, 0, 5, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5); % Z-axis (Red)
    quiver3(0, 0, 0, 0, 5, 0, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5); % Y-axis (Blue)
    
    % Label axes
    text(10, 0, 0.1, 'X', 'FontSize', 16, 'FontWeight', 'Bold', 'Color', 'g');
    text(0, 0, 5, 'Z', 'FontSize', 16, 'FontWeight', 'Bold', 'Color', 'r');
    text(0, 5, 0, 'Y', 'FontSize', 16, 'FontWeight', 'Bold', 'Color', 'b');

    axis equal
    view(-220,20)
    title('Modified 38.901 Pattern');
end

function plot_RPP_polar(P, theta_vals, phi_vals)
    % Example polar plots for certain cuts
    % phi=0 plane cut (horizontal plane)
    [~, phi0_idx] = min(abs(phi_vals - 0));
    % theta=0 direction cut (vertical plane)
    [~, theta0_idx] = min(abs(theta_vals - 0));
    
    P_dB = 10*log10(P);
    
    % Cut at phi=0 (horizontal plane)
    P_phi_0 = P(phi0_idx, :); 
    P_phi_0_dB = P_dB(phi0_idx, :);
    
    figure;subplot(1,2,1)
    polarplot(theta_vals, P_phi_0);
    title('\phi = 0^\circ Pattern');
    set(gca, 'ThetaDir', 'clockwise', 'ThetaZeroLocation', 'top');
    grid on;
    
    subplot(1,2,2)
    polarplot(theta_vals, P_phi_0_dB);
    title('\phi = 0^\circ Pattern (dB)');
    rlim([-30 8]);
    set(gca, 'ThetaDir', 'clockwise', 'ThetaZeroLocation', 'top');
    grid on;
    
    % Cut at theta=0 (vertical plane)
    P_theta_0 = P(:, theta0_idx);
    P_theta_0_dB = P_dB(:, theta0_idx);
    
    figure;subplot(1,2,1)
    polarplot(phi_vals, P_theta_0);
    title('\theta = 0^\circ Pattern');
    grid on;

    subplot(1,2,2)
    polarplot(phi_vals, P_theta_0_dB);
    title('\theta = 0^\circ Pattern (dB)');
    rlim([-30 8]);
    grid on;
end
