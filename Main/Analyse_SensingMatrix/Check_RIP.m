function delta = CheckRIP(A, k, num_trials)
% checkRIP 检测感知矩阵A是否满足k-稀疏的受限等距性质（RIP）
%
% 输入参数:
%   A         - 感知矩阵 (m x n)
%   k         - 稀疏度 (k-sparse)
%   num_trials - 验证的随机子集数量
%
% 输出参数:
%   delta     - 估计的RIP常数δ_k

% 获取矩阵A的尺寸
[m, n] = size(A);

% 检查k是否合理
if k > n
    error('稀疏度k不能大于矩阵A的列数n.');
end

% 初始化delta
delta = 0;

% 开始随机抽样验证
for trial = 1:num_trials
    % 随机选择k个不同的列索引
    S = randperm(n, k);
    
    % 提取子矩阵A_S
    A_S = A(:, S);
    
    % 计算A_S的奇异值
    singular_values = svd(A_S);
    
    % 计算子矩阵A_S的最大和最小奇异值
    sigma_max = max(singular_values);
    sigma_min = min(singular_values);
    
    % 计算当前子集的RIP条件的delta
    current_delta = max(abs(sigma_max^2 - 1), abs(sigma_min^2 - 1));
    
    % 更新全局delta
    if current_delta > delta
        delta = current_delta;
    end
    
    % 显示进度（可选）
    fprintf('Trial %d/%d: Current delta = %.4f\n', trial, num_trials, delta);
end

% 输出最终的delta
fprintf('Estimated RIP constant δ_%d = %.4f\n', k, delta);

end
