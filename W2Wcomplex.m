function Wcomplex = W2Wcomplex(W,K,Nt)
Wcomplex = zeros(Nt,K);
W = reshape(W,2*Nt,K);
for i = 1:K
    Wcomplex(:,i) = W(1:2:end,i) + 1j*W(2:2:end,i);
end
