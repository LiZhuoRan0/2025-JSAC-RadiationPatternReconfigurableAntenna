function C_sub = SubSampleDict(C_full, DictScale)
% 从 0.5° 高分辨率字典中抽样得到 DictScale(=1 or 2) 的粗分辨率字典
%
% 输入
%   C_full    : [M × 361²]，0.5° 网格字典
%   DictScale : 0.5 / 1 / 2
% 输出
%   C_sub     : [M × (361/Factor)²]，粗分辨率字典

    baseStep = 0.5;             % 基准分辨率
    factor   = DictScale / baseStep;

    if abs(factor - round(factor)) > 1e-12 || DictScale < baseStep
        error('DictScale 必须是 0.5 的整数倍 (0.5 / 1 / 2 …)');
    end

    % 轴向长度：-90:0.5:90 共 361 点
    lenAxis = 180/baseStep + 1; % 361
    idx     = 1:factor:lenAxis; % 采样下标

    % 构造平面网格的线性索引
    [ii, jj] = ndgrid(idx, idx);               % ii -> φ, jj -> θ
    idx_flat = sub2ind([lenAxis, lenAxis], ii(:), jj(:));

    % 按列抽取 (MATLAB reshape 为列主序)
    C_sub = C_full(:, idx_flat);
end
