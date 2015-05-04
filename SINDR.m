function gamma = SINDR(W,param,k)

Nt = param.Nt;
K = param.K;
beta = param.PA_beta;
N0 = param.N0;
H = param.H;


if ((size(W,1)~=Nt)||(size(W,2)~=K))
    error('Check the size of W!')
end

S = abs(H(:,k,k).'*W(:,k))^2;
I = 0;
D = 0;
for j = 1:K
    if j~=k
        I = I + abs(H(:,k,j).'*W(:,j))^2;
    end
    Cx = W(:,j)*W(:,j)';
    Cd = zeros(Nt,Nt);
    for n = 1:length(beta)
        Cd = Cd + beta(n)*Cx.*abs(Cx).^(2*n+1);
    end
    D = D + real(H(:,k,j)'*Cd*H(:,k,j));
end
gamma = real(S/(I+D+N0));
end

