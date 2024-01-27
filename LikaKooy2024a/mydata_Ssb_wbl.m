% Supporting Information: The relationship between confidence intervals and
% distributions of estimators for parameters of deterministic models

% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 

function mydata_Ssb_wbl
% compare SB and ML-estimates for par of weibull distribution based on fitting exp(-(lambda*t)^k) 
% F_ML = - n ln k - n k ln lamb - (k-1)\sum_i ln t_i + \sum_i(lamb t_i)^k
% Bas Kooijman, 2021/07/28

clc; clear all; close all;
% sets options for DEBtool_M function nmregr, see online package manual:
nmregr_options('default'); nmregr_options('report',0); nmregr_options('max_step_number',1e5); nmregr_options('max_fun_evals',1e5);
wbl = @(shape, t) sum(t.^shape .* log(t))/ sum(t.^shape) - 1/shape - mean(log(t)); % ML fn for shape par

  lambda = 1; % 1/d, real scale parameter (must be positive)
  k = 3;      % - , shape parameter
  n = 5;      % #, number of trials from the weibull distribution (must be integer)
  N = 5000;   % #, number of Monte Carlo runs

par_SB = zeros(N,2); par_ML = zeros(N,2); 
FSB = zeros(N,1); FML = zeros(N,1); 

for i = 1:N
  t = sort(wblrnd(lambda,k,n,1)); % d, sorted trials from pdf(t)=k*lambda*(t*lambda)^(k-1)*exp(-(lambda*t)^k)
  D0 = [t, 1 - ((1:n)' - 0.5)/ n];
  [par, ~, FSB(i)] = nmregr('weibull', [lambda 1; k 1], D0); par_SB(i,:) = par(:,1)'; 
  par_ML(i,2) = fzero(@(shape) wbl(shape,t), [.001 50]*k);
  par_ML(i,1) = 1/mean(t.^par_ML(i,2))^(1/par_ML(i,2));
  FML(i) = sum((par_ML(i,2)*t).^par_ML(i,1)) - n*log(par_ML(i,1)) - n*par_ML(i,1)*log(par_ML(i,2)) - (par_ML(i,1)-1)*sum(log(t));
end

close all

Spar_SB = surv(par_SB(:,1)); Spar_ML = surv(par_ML(:,1)); 
Mpar_SB = median(par_SB(:,1)); Mpar_ML = median(par_ML(:,1)); 

Hfig1 = figure(1); % survivor functions
hold on
plot(Spar_SB(:,1),Spar_SB(:,2),'r', ...
     Spar_ML(:,1),Spar_ML(:,2),'k', 'linewidth',3)
plot([0;Mpar_SB;Mpar_SB], [0.5;0.5;0],'r', ...
     [0;Mpar_ML;Mpar_ML], [0.5;0.5;0],'k', ...
     lambda, 0, '.k', 'markersize',20) % true value
ylim([0 1])
xlim([min(Spar_SB(1,1),Spar_ML(1,1)) 2*lambda])
xlabel('scale parameter, 1/d')
ylabel('survivor function')
text(lambda,0.90, ['\color{red}{SB1, median = ', num2str(Mpar_SB), '}'])
text(lambda,0.85, ['\color{black}{ML}, median  = ', num2str(Mpar_ML)])
title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda), ', k = ', num2str(k)])
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('scale_wbl')
print -r0 -dpng scale_wbl.png
%set(Hfig1, 'Outerposition',[0 0.5 0.5 0.5]);

Spar_SB = surv(par_SB(:,2)); Spar_ML = surv(par_ML(:,2)); 
Mpar_SB = median(par_SB(:,2)); Mpar_ML = median(par_ML(:,2)); 

Hfig2 = figure(2); % survivor functions
hold on
plot(Spar_SB(:,1),Spar_SB(:,2),'r', ...
     Spar_ML(:,1),Spar_ML(:,2),'k', 'linewidth',3)
plot([0;Mpar_SB;Mpar_SB], [0.5;0.5;0],'r', ...
     [0;Mpar_ML;Mpar_ML], [0.5;0.5;0],'k', ...
     k, 0, '.k', 'markersize',20) % true value
ylim([0 1])
xlim([0 8*k])
xlabel('shape parameter, -')
ylabel('survivor function')
text(3*k,0.90, ['\color{red}{SB, median = ', num2str(Mpar_SB), '}'])
text(3*k,0.85, ['\color{black}{ML}, median  = ', num2str(Mpar_ML)])
title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda), ', k = ', num2str(k)])
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('shape_wbl')
print -r0 -dpng shape_wbl.png
%set(Hfig2, 'Outerposition',[0.5 0.5 0.5 0.5]);


SFSB = surv(FSB); SFML = surv(FML); 

Hfig3 = figure(3); % loss 
xlabels{1} = 'loss function F_{SB}';
xlabels{2} = 'loss function F_{ML}';
ylabels{1} = 'survivor function';
ylabels{2} = 'survivor function';
[ax,hl1,hl2] = plotxx(SFSB(:,1), SFSB(:,2), SFML(:,1), SFML(:,2),  xlabels, ylabels, 'r', 'k');
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0, 0.5, 0.5]);
set(gca, 'FontSize', 15)
title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda), ', k = ', num2str(k)])
savefig('lf_wbl')
print -r0 -dpng lf_wbl.png
%set(Hfig3, 'Outerposition',[0.25 0 0.5 0.5]);

end

function p = weibull(par,tS)
  p = exp(-(tS(:,1)*par(1)).^par(2));
end