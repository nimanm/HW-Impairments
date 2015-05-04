%%% SINDR optimization constraints
function [c, ceq] = confun(Wdelta)
W = Wdelta(1:end-1);
Min_SINDR = Wdelta(end);
 
load param
K = param.K;
Nt = param.Nt;
Wcomplex = W2Wcomplex(W,K,Nt);


% Nonlinear inequality constraints
c = zeros(K,1);
i = 0;
for k = 1:K
    i = i+1;
    c(i) = -SINDR(Wcomplex,param,k)+Min_SINDR;
    i = i+1;
    c(i) = real(Wcomplex(:,k)'*Wcomplex(:,k))-param.delta;
end
i = i+1;
c(i) = -Min_SINDR;

% Nonlinear equality constraints
ceq = [];

end