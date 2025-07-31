function get_NPCP
      % parameters
        p.yNP = 0.2;
        p.yNC = 0.1;
        p.yND = 0.05;
        p.yCP = 0.2; 
        p.yDC = 0.3; 
        p.KP  = 5;
        p.KC  = 10;
        p.KD  = 15;
        p.kC  = 0.0001;
        p.kdC = 0.5;
        p.kdD = 0.5;
        p.hC  = 0.00001;
        p.hD  = 0.00001;
        p.jNP = 0.3;
        p.jPC = 0.5;
        p.jCD = 0.2;

        % initial values
        P = p.kC*p.KC/(p.yCP*p.jPC - p.kC);
        Cpr = p.KD*p.hD/(p.yDC*p.jCD-p.hD);
        Cd = Cpr*p.hC/p.kdC;
        X0 = [5 P 2 Cpr Cd 0.2 .01]; % N, P, C, Cpr, Cd, D, Dd
        options = odeset('AbsTol',1e-13, 'RelTol',1e-13);
        [t, X] = ode23(@NPCP, [0;1e4], X0, options, p);

        plot(t,X(:,2),'g',t,X(:,3),'k',t,X(:,6),'r')
        xlabel('time, d')
        ylabel('\color{green}{producer}, \color{black}{consumer}, \color{red}{predator} \color{black}{density, Mol}')
        %X(:,1)+p.yNP*X(:,2)+p.yNC*sum(X(:,3:5),2) + p.yND*sum(X(:,6:7),2)
        [1 p.yNP p.yNC p.yNC p.yNC p.yND p.yND] * NPCP(0,X0,p) % should be zero
        %[1 p.yNP p.yNC p.yNC p.yNC p.yND p.yND] * NPCP(0,10.^rand(7,1),p) % should be zero
end

function dX = NPCP(t, X, p)
  N=X(1); P=X(2); C=X(3); Cpr=X(4); Cd=X(5); D=X(6); Dd=X(7);
  fN=N/(N+p.KP); fP=P/(P+p.KC); fCpr=Cpr/(Cpr+Cd+p.KD); fCd=Cd/(Cpr+Cd+p.KD);

  dN = p.yNC*p.kdC*Cd+p.yND*p.kdD*Dd+p.yNP*p.jPC*fP*Cpr-p.jNP*fN*P;
  dP = p.jNP/p.yNP*fN*P-p.jPC*fP*(C+Cpr);
  dC = (p.yCP*p.jPC*fP-p.kC)*C;
  dCpr = p.kC*C-p.jCD*fCpr*D-p.hC*Cpr;
  dCd = p.hC*Cpr-p.jCD*fCd*D-p.kdC*Cd;
  dD = (p.yDC*p.jCD*(fCpr+fCd)-p.hD)*D;
  dDd = p.hD*D-p.kdD*Dd;
  
  dX = [dN;dP;dC;dCpr;dCd;dD;dDd];
%   if abs([1 p.yNP p.yNC p.yNC p.yNC p.yND p.yND] * dX)>1e-3
%     keyboard
%   end
end

