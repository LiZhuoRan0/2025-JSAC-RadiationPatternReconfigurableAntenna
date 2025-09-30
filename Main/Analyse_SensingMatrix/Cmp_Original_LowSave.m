clear
clc

% if isempty(gcp('nocreate'))   
%     numWorkers = 10;      
%     parpool('local', numWorkers);
% end
HPBW_all = [65 45 25 15];
N_all = [11 9 7];
threshold = -30;
NMSE = zeros(length(HPBW_all),length(N_all));

for i = 1:length(HPBW_all)
for j = 1:length(N_all)
    fprintf('i/I = %d/%d, j/J = %d/%d\n', i, length(HPBW_all), j, length(N_all));
    HPBW = HPBW_all(i);
    N = N_all(j);
    FilePath_Load_Original = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d.mat',HPBW, N);
    if threshold <= 0
        FilePath_Load_LowSave = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_%ddB.mat',HPBW, N, -threshold);
    else
        FilePath_Load_LowSave = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d+%ddB.mat',HPBW, N, threshold);
    end
    Result_Original = load(FilePath_Load_Original).Result;
    Result_LowSave = load(FilePath_Load_LowSave).Result;

    NMSE(i,j) = norm(Result_Original - Result_LowSave,'fro')^2 ...
          /norm(Result_Original,'fro')^2;
end
end
10*log10(NMSE)