clear all;

rng(0);
K = 3;
Nt = 2;
N0 = 1;
PA_beta = 0.01;
H = 1/sqrt(2)*(randn(Nt,K,K)+1j*randn(Nt,K,K));

param.K = K;
param.Nt = Nt;
param.N0 = N0;
param.PA_beta = PA_beta;
param.H = H;

SNR_range = -20:10:20;
R = zeros(K,length(SNR_range));

%% max-min optimization through bisection