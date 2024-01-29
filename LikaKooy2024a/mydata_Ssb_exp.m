% Supporting Information: The relationship between confidence intervals and
% distributions of estimators for parameters of deterministic models

% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 

function mydata_Ssb_exp
% compare SB-estimates for par of exponential distribution based on fitting exp(-lambda*t) for 2 definitions of empirical survival data
%  = {t_i, 1-(2i-1)/(2n)}, i=1:n (red)
% the black curve is the ML estimate
% Bas Kooijman, 2021/07/28

clc; clear all; close all;
lambda = 1; % 1/d, real par value of exp distr (must be positive)
n = 5;      % #, number of trials from the exponential distribution (must be integer)
N = 5000;   % #, number of Monte Carlo runs
lambda_SB = zeros(N,1); lambda_ML = zeros(N,1); FSB = zeros(N,1); 

% sets options for DEBtool_M function nmregr, see online package manual:
nmregr_options('default'); nmregr_options('report',0); nmregr_options('max_step_number',1e5); nmregr_options('max_fun_evals',1e5);

for i = 1:N
  t = sort(exprnd(1/lambda,n,1)); % d, sorted trials from pdf(t)=lambda*exp(-lambda*t)
  D0 = [t, 1 - ((1:n)' - 0.5)/ n];
  [lam, ~, FSB(i)] = nmregr('exponential', [lambda 1], D0); lambda_SB(i) = lam(1); 
  lambda_ML(i) = 1/mean(t); 
end
FML = 2*n*(1 - log(lambda_ML));

Slambda_SB = surv(lambda_SB); Slambda_ML = surv(lambda_ML); 
Mlambda_SB = median(lambda_SB); Mlambda_ML = median(lambda_ML); 
SFSB = surv(FSB); SFML = surv(FML); 
close all

Hfig1 = figure(1); % survivor functions
hold on
plot(Slambda_SB(:,1),Slambda_SB(:,2),'r', ...
     Slambda_ML(:,1),Slambda_ML(:,2),'k', 'linewidth',3)
plot([0;Mlambda_SB;Mlambda_SB], [0.5;0.5;0],'r', ...
     [0;Mlambda_ML;Mlambda_ML], [0.5;0.5;0],'k', ...
     lambda, 0, '.k', 'markersize',20) % true value
ylim([0 1])
xlim([0 2*lambda])
xlabel('rate parameter, 1/d')
ylabel('survivor function')
text(lambda,0.90, ['\color{red}{SB, median = ', num2str(Mlambda_SB), '}'])
text(lambda,0.85, ['\color{black}{ML}, median  = ', num2str(Mlambda_ML)])
set(gca, 'FontSize', 15, 'Box', 'on')
title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda)])
savefig('scale_exp')
print -r0 -dpng 'scale_exp.png'
%set(Hfig1, 'Outerposition',[50 200 600 600]);

Hfig2 = figure(2); % loss functions
xlabels{1} = 'loss function F_{SB}';
xlabels{2} = 'loss function F_{ML}';
ylabels{1} = 'survivor function';
ylabels{2} = 'survivor function';
[~,~,~] = plotxx(SFSB(:,1), SFSB(:,2), SFML(:,1), SFML(:,2),  xlabels, ylabels, 'r', 'k');
set(gca, 'FontSize', 15)
title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda)])
savefig('lf_exp')
print -r0 -dpng lf_exp.png
%set(Hfig2, 'Outerposition',[650 200 600 600]);
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0, 0.5, 0.5]);
end



