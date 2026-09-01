function aW = sad(f,par)
  % survivor function of stable age and weight distribution of a level in the trophic pyramid
  llegend_levels = {...
    {'-', 2, [0 0 1]}, '1'; ....
    {'-', 2, [1 0 1]}, '2'; ....
    {'-', 2, [1 0 0]}, '3'; ....
  };
  shllegend(llegend_levels,[],[0.9 0.2],'levels');
  %saveas(gcf,'legend_levels.png'); cropWhite('legend_levels')

  pdf_a = @(t,f,p) surv_pyr(t,f,p); % prob dens fn of the stable age distribution
  t0 = linspace(0,5e3,100)';  n = length(t0); m = length(par.kap); S_sad = NaN(n,m); S_swd = NaN(n,m); pdf_sad = NaN(n,m); W = NaN(n,m);
  for i = 1:m
    % overwrite par to reduce vectors to scalars
    p = par;flds=fields(p);for j=1:length(flds);if length(p.(flds{j}))>1;p.(flds{j})=p.(flds{j})(i);end;end
    
    Li = f(i)*p.Lm; Wb = (p.Lm*get_lb([p.g, p.k, p.vHb],f(i)))^3*(1+f(i)*p.ome); Wi = Li^3*(1+f(i)*p.ome); W(:,i) = linspace(Wb,Wi-1e-10,100)';    
    S0 = integral(@(t)pdf_a(t,f(i),p),0,Inf);
    for j=1:n
      S_sad(j,i) = integral(@(t)pdf_a(t,f(i),p),t0(j),Inf)/ S0; 
      S_swd(j,i) = integral(@(t)pdf_a(t,f(i),p),W2t(W(j,i),f(i),p),Inf)/ S0; 
    end
    pdf_sad(:,i) = pdf_a(t0,f(i),p)/ S0; 
  end
  
  figure % plotting stable age distribution (sad)'s     
  plot(t0,S_sad(:,1),'b', 'LineWidth',2); hold on
  plot(t0,S_sad(:,2),'m', 'LineWidth',2);
  plot(t0,S_sad(:,3),'r', 'LineWidth',2); 
  xlabel('time since birth, d')
  ylabel('survivor function, -')
  set(gca, 'FontSize',15, 'Box','on')
  title('stable age distribution', 'FontSize',15, 'FontWeight','normal')
  saveas(gca,'S_sad.png')
  
  mean_a = [ispline1(t0([1;end]), [t0,S_sad(:,1)]), ispline1(t0([1;end]), [t0,S_sad(:,2)]), ispline1(t0([1;end]), [t0,S_sad(:,3)])];
  aW = mean_a(2,:)'; % mean age

  figure % plotting pdf_a's     
  plot(t0,pdf_sad(:,1),'b', 'LineWidth',2); hold on
  plot(t0,pdf_sad(:,2),'m', 'LineWidth',2);
  plot(t0,pdf_sad(:,3),'r', 'LineWidth',2); 
  set(gca, 'FontSize',15, 'Box','on')
  title('stable age distribution', 'FontSize',15, 'FontWeight','normal')
  xlabel('time since birth, d')
  ylabel('probability density function, 1/d')
    
  set(gca, 'FontSize',15, 'Box','on')
  saveas(gca,'pdf_sad.png')

  figure % plotting stable weight distribution (swd)'s     
  plot(W(:,1),S_swd(:,1),'b', 'LineWidth',2); hold on
  plot(W(:,2),S_swd(:,2),'m', 'LineWidth',2);
  plot(W(:,3),S_swd(:,3),'r', 'LineWidth',2); 
  xlabel('weight, g')
  ylabel('survivor function, -')
  set(gca, 'FontSize',15, 'Box','on')
  title('stable weight distribution', 'FontSize',15, 'FontWeight','normal')
  saveas(gca,'S_swd.png')

  mean_weight = [ispline1(W([1;end],1), [W(:,1),S_swd(:,1)]), ispline1(W([1;end],2), [W(:,2),S_swd(:,2)]), ispline1(W([1;end],3), [W(:,3),S_swd(:,3)])];
  aW = [aW, mean_weight(2,:)']; % mean age, weight

end
