clear
N_it = 4;
N_p = 49;
N_U = 4;
N_a = 181*181;
N_s = 1e3;

Algorithm_1 = 3/4*N_it^4 + ...
              2*N_p*N_it^3 + ...
              (N_p*N_U + N_p^2/2)*N_it^2 + ...
              (N_p*N_a*N_U + N_p^2*N_U)*N_it + ...
              N_p*N_a*log2(N_a) + ...
              N_s*N_U*N_p;
MUSIC = N_U^3 + N_U^2*(N_s*N_p + N_a);

Est_Jammer = N_U*N_p*(N_a + 2*N_s);

N_it = 2;
L_C = 2;
Algorithm_2 = N_it * ((L_C+2)*N_U^2 + 6*N_U^3 + N_p^2);

fprintf('Complexity of Algorithm 1 = %.1f\n', Algorithm_1)
fprintf('Complexity of MUSIC       = %.1f\n', MUSIC)
fprintf('Complexity of Est_Jammer  = %.1f\n', Est_Jammer)
fprintf('Complexity of Algorithm 2 = %.1f\n', Algorithm_2)