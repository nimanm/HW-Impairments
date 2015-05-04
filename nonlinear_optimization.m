%%% non-linear optimization of SINR
%%%% 2015-04-20
%%%% 3 users, MISO scenario with 2 transmit antennas
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
count = 0;
for SNR_dB = SNR_range;
    count = count +1;
    SNR = 10^(SNR_dB/10);
    delta = SNR*N0;
    param.delta = delta;
    save param param;
    
    rng(1);
    W0 = sqrt(0.5)*(randn(K*Nt*2+1,1)+1j*randn(K*Nt*2+1,1));
    W0(end) = randn;
    options = optimoptions(@fmincon,'Algorithm','sqp','MaxFunEvals',2e3);
    W = fmincon(@objfun,W0,[],[],[],[],[],[],@confun);
    temp = confun(W);
    Min_SINDR = -temp(end);
    SINDR_opt = -temp(1:2:end-1)+ Min_SINDR;
    P = temp(2:2:end-1)+delta;
    
     
    
    if (sum(P>delta)>0)
        warning('Power conditon is not satisfied')
    end
    if (sum(SINDR_opt<Min_SINDR)>0)
        warning('SINDR condition is not satisfied!')
    end
    
    Wcomplex = W2Wcomplex(W(1:end-1),K,Nt);
    %%% Calculating the rates
    for k = 1:K
        R(k,count) = log2(1+SINDR(Wcomplex,param,k));
    end

end

