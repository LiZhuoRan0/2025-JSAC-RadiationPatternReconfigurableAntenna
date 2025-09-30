% 生成一个示例感知矩阵（例如，随机高斯矩阵）
m = 200;  % 测量数
n = 200;  % 信号长度
A = randn(m, n)/ sqrt(m);  % 高斯随机矩阵

% 设置稀疏度k和抽样次数
k = 3;
num_trials = 10000;

% 调用checkRIP函数
estimated_delta = Check_RIP(A, k, num_trials);


% filename = sprintf('../../Data/RadiationPattern/HPBW_65_Axis_90/RadiationPattern_%d.mat', 5);
% load(filename);
% % 计算每列的范数
% col_norms = vecnorm(Result);
% 
% % 归一化每一列
% normalized_result = Result ./ col_norms;
% estimated_delta = CheckRIP(normalized_result, k, num_trials);

% 显示结果
fprintf('The estimated RIP constant δ_%d for matrix A is %.4f\n', k, estimated_delta);
