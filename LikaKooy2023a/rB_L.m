function varargout = rB_L(par, varargin)
 global fVec
 n=length(varargin); varargout = cell(n,1); fVec = ones(n,1);
 Lw_b = par(1); Lwi = par(2:n+1); rB = par(2+n:1+2*n); del_M = par(end-1); L_m = par(end);
 
 for i=1:n
   tL = varargin{i};
   f = Lwi(i)*del_M/L_m; fVec(i)=f; L_b = Lw_b * del_M;
   L = f*L_m - (f*L_m - L_b)*exp(-rB(i)*tL(:,1)); EL = L/del_M; 

   varargout{i} = EL;
 end
  
end
