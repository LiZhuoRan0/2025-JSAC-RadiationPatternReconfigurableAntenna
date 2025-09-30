
clear
clc
%% 1. import standard pattern
HPBW_all = [65 55 45 35 25 15];
N_all = [9 7 5];
for i = 1:length(HPBW_all)
for j = 1:length(N_all)
    HPBW = HPBW_all(i);
    N = N_all(j);
    FilePathSave = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_randn', HPBW, N);
    Result = randn(N*N, 181*181);% linear, amplitude
    %% 2. Generate new pattern
    Result = Result.^2;% linear, power
    
    %% 3. normalize
    Result = RadiationPattern_Normlization(Result, N);% linear, power
    Result = sqrt(Result);% linear, amplitude
    %% 4. save
    save(FilePathSave, 'Result')% linear, amplitude
end
end