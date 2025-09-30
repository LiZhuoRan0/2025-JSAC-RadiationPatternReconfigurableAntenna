function A = Gen_SteeringVec(varphi, theta, N_ele, N_azi)
%% Generate steering vectors without explicit loops
% input
%       varphi      elevation angle (NumAngle x 1)
%       theta       azimuth angle   (NumAngle x 1)
%       N_ele       # of antenna elements in vertical dimension
%       N_azi       # of antenna elements in horizontal dimension
% output
%       A           N_ele*N_azi x NumAngle
%%
NumAngle = length(varphi);
if NumAngle ~= length(theta)
    error('size(varphi) ~= size(theta)')
end

% vertical
ele_idx = (0:N_ele-1).';
vals_ele = (cosd(varphi).*sind(theta)).'; % 1 x NumAngle
X_ele = exp(1j*pi*(ele_idx .* vals_ele)); % N_ele x NumAngle

% horizontal
azi_idx = (0:N_azi-1).';
vals_azi = sind(varphi).'; % 1 x NumAngle
X_azi = exp(1j*pi*(azi_idx .* vals_azi)); % N_azi x NumAngle

% X_ele_3D: N_ele x 1 x NumAngle
% X_azi_3D: 1 x N_azi x NumAngle
X_ele_3D = reshape(X_ele, [N_ele, 1, NumAngle]);
X_azi_3D = reshape(X_azi, [1, N_azi, NumAngle]);

% N_ele x N_azi x NumAngle
A_3D = X_ele_3D .* X_azi_3D;

% N_ele*N_azi x NumAngle
A = reshape(A_3D, [N_ele*N_azi, NumAngle]);

end
