clear
clc
close all

HPBW = 65;
N = 11;
RadiationPtn = load(sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d.mat', HPBW, N)).Result;

tmp = reshape(RadiationPtn(41,:), 181, 181);
tmp_FFT = fftshift(fft2(tmp.*(hamming(181)*hamming(181).')));

% 计算 dB 表示
tmp_dB = 10*log10(abs(tmp)/max(abs(tmp),[],'all'));
dB_FFT = 10*log10(abs(tmp_FFT)/max(abs(tmp_FFT),[],'all'));

% 找出大于 -30dB 的位置
threshold = -30;
mask = dB_FFT > threshold;
[Azimuth, Elevation] = meshgrid(-90:90);


figure
mesh(Azimuth, Elevation, tmp_dB); % 绘制3D网格图
xlim([-90,90])
ylim([-90,90])
xlabel('Elevation Angle');
ylabel('Azimuth Angle');
zlabel('dB');
set(gca,'FontName','Times New Roman','FontSize',16);

% 可视化
figure;
mesh(Azimuth, Elevation, dB_FFT); % 绘制3D网格图

% 标注大于 -20dB 的点
hold on;
[rows, cols] = find(mask);
scatterHandle = scatter3(cols-91, rows-91, dB_FFT(sub2ind(size(dB_FFT), rows, cols)), 20, 'r', 'filled'); 
hold off;

% 只给 scatter3 添加 legend
legend(scatterHandle, 'Selected Points');

% 设置图形
title('');
xlabel('Elevation Angle');
ylabel('Azimuth Angle');
zlabel('dB');
% colormap(jet);
% colorbar;
xlim([-90,90])
ylim([-90,90])
set(gca,'FontName','Times New Roman','FontSize',16);



%% Calculate Error
tmp_1 = zeros(181, 181);
tmp_1(rows, cols) = tmp_FFT(rows, cols);
tmp_est = abs(ifft2(fftshift(tmp_1))./(hamming(181)*hamming(181).'));
10*log10(norm(tmp-tmp_est,'fro')^2/norm(tmp,'fro')^2)