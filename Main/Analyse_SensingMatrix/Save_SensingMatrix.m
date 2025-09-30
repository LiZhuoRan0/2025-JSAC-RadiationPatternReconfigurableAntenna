clear
clc

if isempty(gcp('nocreate'))   
    numWorkers = 10;      
    parpool('local', numWorkers);
end
HPBW_all = [65 45 25 15];
N_all = [11 9 7];
threshold = -30;

for i = 1:length(HPBW_all)
for j = 1:length(N_all)
    fprintf('i/I = %d/%d, j/J = %d/%d\n', i, length(HPBW_all), j, length(N_all));
    HPBW = HPBW_all(i);
    N = N_all(j);
    FilePath_Load = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d.mat',HPBW, N);
    if threshold <= 0
        FilePath_Save = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d_%ddB.mat',HPBW, N, -threshold);
    else
        FilePath_Save = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d+%ddB.mat',HPBW, N, threshold);
    end
    Result_Pre = load(FilePath_Load).Result;
    Result = zeros(N*N, 181*181);
    size_cum = zeros(N*N, 1);
%% 1. FFT
    Size_Result = zeros(N*N, 1);
    parfor k = 1:N*N
        tmp = reshape(Result_Pre(k,:), 181, 181);
        tmp_FFT = fftshift(fft2(tmp.*(hamming(181)*hamming(181).')));
%% 2. Select Values
        dB_FFT = 10*log10(abs(tmp_FFT)/max(abs(tmp_FFT),[],'all'));
        mask = dB_FFT > threshold;
        size_cum(k) = sum(mask,'all');
%% 3. Save Sensing Matrix
        tmp_FFT = tmp_FFT .* mask;
        tmp_1 = ifft2(fftshift(tmp_FFT)).*(1./hamming(181)*1./(hamming(181).'));
        Result(k,:) = abs(reshape(tmp_1, 1, 181*181));
    end
    size = sum(size_cum);
    save(FilePath_Save,'Result','size')
end
end