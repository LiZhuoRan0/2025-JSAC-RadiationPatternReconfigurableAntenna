clear
clc
%% 1. import standard pattern
HPBW_all = [65 55 45 35 25 15];
N_all = [9 7 5];
for i = 1:length(HPBW_all)
for j = 1:length(N_all)
    HPBW = HPBW_all(i);
    N = N_all(j);
    FilePathLoad = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d', HPBW, N);
    FilePathSave = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_notch', HPBW, N);
    Result = load(FilePathLoad).Result;% linear, amplitude
    %% 2. Generate new pattern
    Result_dB = 20*log10(Result);% dB, power
    Result_dB = -Result_dB;% dB, power
    Result = 10.^(Result_dB/10);% linear, power
    
    %% 3. normalize
    Result = RadiationPattern_Normlization(Result, N);% linear, power
    Result = sqrt(Result);% linear, amplitude
    %% 4. save
    save(FilePathSave, 'Result')% linear, amplitude
end
end