function varargout = rB_W(par, varargin)
 global fVec
 
 n=length(varargin); varargout = cell(n,1); fVec = ones(n,1);
 Wwb = par(1); Wwi = par(2:n+1); rB = par(2+n:1+2*n); ome = par(end);
 L_m = (Wwi(1)/(1 + ome))^(1/3); Lm3 = L_m^3; L_b = (Wwb/(1 + ome))^(1/3);
 for i=1:n
   tW = varargin{i};
   f = roots([ome*Lm3 Lm3 0 0 -Wwi(i)]); f=f(im(f)==0,1); f = f(f>0); fVec(i)=f;
   L = f*L_m - (f*L_m - L_b)*exp(-rB(i)*tW(:,1)); EW = L.^3 * (1 + f * ome); 

   varargout{i} = EW;
 end
  
end
