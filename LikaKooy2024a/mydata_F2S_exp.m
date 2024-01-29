% Supporting Information: The relationship between confidence intervals and
% distributions of estimators for parameters of deterministic models

% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 

function  mydata_F2S_exp 
% function mydata_F2S_exp from loss to survivor function for exponential
% distribution
% 
% F_ML = - 2 log lik = 2 n (1 - ln lambda)
% pdf(t) = lamb exp(-lambda t)
% Bas Kooijman, 2021/07/28
% modified by Dina Lika, 2021/08/05, MC simulations are with the estimate
% of lambda based on the D0 sample

clear all; close all;

% sets options for DEBtool_M function nmregr, see online package manual
nmregr_options('default'); nmregr_options('report',0); nmregr_options('max_step_number',1e5); nmregr_options('max_fun_evals',1e5); 

% par and estimates
lambda = 1;   % 1/d, real par value of exp distr (must be positive)
n = 5;        % #, number of trials for exp distr (must be integer)
N = 5000;     % #, number of data sets for F_SB-surv
n_par = 5000; % #, number of parameter points in (par, conf) and (par, surv) graphs
%
% t0 = sort(exprnd(1/lambda,n,1)); % d, sorted trials from exp distr
% save('sample_exp.mat','t0')
% load('sample_exp.mat','t0')
t0 = [0.4245, 0.4465, 0.7100, 0.7707, 2.3485]';

lambda_ML0 = 1/mean(t0); FML0 = 2 * n * (1 - log(lambda_ML0)); % 1/d, point ML estimate for par
D0 = [t0, 1 - ((1:n)' - 0.5)/ n];

[lambda_SB0, ~, FSB0] = nmregr('exponential', [lambda 1], D0); lambda_SB0 = lambda_SB0(1);

% conditional distribution of loss function SB and ML
FSB = zeros(N,1); lambda_ML = zeros(N,1); lambda_SB = zeros(N,1);
for i = 1:N
  t = sort(exprnd(1/lambda_SB0,n,1)); % d, sorted trials from exp distr
  [lam, ~, FSB(i)] = nmregr('exponential', [lambda_SB0 1], [t, 1 - ((1:n)' - 0.5)/ n]); 
  lambda_SB(i) = lam(1);
end
FSB = FSB - FSB0; FSB = FSB(FSB >= 0); N_FSB = length(FSB); SFSB = [sort(FSB), 1 - ((1:N_FSB)' - 0.5)/ N_FSB];

for i = 1:N
  t = sort(exprnd(1/ lambda_ML0, n, 1)); % d, sorted trials from exp distr
  lambda_ML(i) = 1/ mean(t); 
end
FML = 2 * n * (1 - log(lambda_ML)) - FML0; FML = FML(FML >= 0); N_FML = length(FML); SFML = [sort(FML), 1 - ((1:N_FML)' - 0.5)/ N_FML];


Slambda_SB = surv(lambda_SB);   Slambda_ML   = surv(lambda_ML); 
Mlambda_SB = median(lambda_SB); Mlambda_ML = median(lambda_ML); 

% lf profile of par
%lamb = linspace(.05 * lambda_SB0, 5 * lambda_SB0, n_par)';
lamb = linspace(.05 * lambda_SB0, 5, n_par)';
F_SB = zeros(100,1); 
for i=1:n_par; prd = exponential(lamb(i), D0); F_SB(i) = mean(((prd - D0(:,2)).^2)./(mean(prd)^2 + mean(D0(:,2))^2)); end
F_SB = F_SB - FSB0;
F_ML = 2 * n * (lamb * mean(t0) - log(lamb)) - FML0;

% conf level of par
conf=.01:.01:.99; n_conf = length(conf); parbl = zeros(n_conf,2); parbu = zeros(n_conf,2);
% SB
for i=1:n_conf
  F = max(0,spline1(1-conf(i), flip(flip(SFSB,2),1)));
  b = rspline1([lamb, F_SB-F]); if length(b)==1; b = [0, b]; end
  parbl(i,:) =  [b(1), conf(i)]; parbu(i,:) =  [b(2), conf(i)];
end
parb_SB = [flip(parbl,1); [lambda_SB0 0]; parbu];
parS_SB = parb_SB; parS_SB(:,2) = (0.5 + parS_SB(:,2)/2) .* (parS_SB(:,1) <=  lambda_SB0) + (1 - parS_SB(:,2))/2 .* (parS_SB(:,1) >  lambda_SB0);
% ML
for i=1:n_conf
  F = max(0, spline1(1-conf(i), flip(flip(SFML,2),1)));
  b = rspline1([lamb, F_ML-F]); if length(b)==1; b = [0, b]; end
  parbl(i,:) =  [b(1), conf(i)]; parbu(i,:) =  [b(2), conf(i)];
end
parb_ML = [flip(parbl,1); [lambda_ML0 0]; parbu];
parS_ML = parb_ML; parS_ML(:,2) = (0.5 + parS_ML(:,2)/2) .* (parS_ML(:,1) <=  lambda_ML0) + (1 - parS_ML(:,2))/2 .* (parS_ML(:,1) >  lambda_ML0);

close all

Hfig1 = figure(1);
St0 = surv(t0); t=linspace(0, 1.1 * t0(end),100);
plot(St0(:,1), St0(:,2), 'r')
hold on
plot(D0(:,1), D0(:,2), '.b', 'markersize', 12)
plot(t, exp(-lambda_SB0*t), 'r', 'linewidth', 3)
txt = 'data: '; for i=1:n; txt=[txt,' ', num2str(t0(i),'%.2f'),',']; end; txt(end)='';
title(txt)
text(.1,.1,['\lambda = ', num2str(lambda_SB0,'%.3f'), ' d^{-1}'])
xlabel('time, d');
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('sample_exp')
print -r0 -dpng sample_exp.png

Hfig2 = figure(2); % loss functions
colororder({'k','r'})
yyaxis left
plot(lamb,F_SB,'r', 'linewidth',2);
xlabel('rate parameter, 1/d');
ylabel('\color{red}{F_{SB} - F_{SB}^{ref} | F_{SB} \geq F_{SB}^{ref}}');
title('Exponential')
yyaxis right
plot(lamb,F_ML,'k', 'linewidth',2);
ylabel('\color{black}{F_{ML} - F_{ML}^{ref} | F_{ML} \geq F_{ML}^{ref}}');
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_lf_exp')
print -r0 -dpng rate_lf_exp

set(gca, 'FontSize', 15)
% txt = 'data: '; for i=1:n; txt=[txt,num2str(t0(i)),',']; end; txt(end)='';
% title(txt)
%xlim([0 2*lambda])
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_lf_exp')
print -r0 -dpng rate_lf_exp

Hfig3 = figure(3); % loss functions
Hfig3.Units = 'centimeters';
xlabels{1} = 'F_{SB} - F_{SB}^{ref} | F_{SB} \geq F_{SB}^{ref}';
xlabels{2} = 'F_{ML} - F_{ML}^{ref} | F_{ML} \geq F_{ML}^{ref}';
ylabels{1} = 'survivor function';
ylabels{2} = 'survivor function';
[~,~,~] = plotxx(SFSB(:,1), SFSB(:,2), SFML(:,1), SFML(:,2),  xlabels, ylabels, 'r', 'k');
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('lf_exp')
print -r0 -dpng lf_exp 

Hfig4 = figure(4);
plot(parb_SB(:,1), parb_SB(:,2), 'r', 'linewidth',3) 
hold on 
plot(parb_ML(:,1), parb_ML(:,2), 'k', 'linewidth',3) 
xlabel('rate parameter, 1/d')
ylabel('confidence level')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_ci_exp')
print -r0 -dpng rate_ci_exp

Hfig5 = figure(5);
plot(parS_SB(:,1), parS_SB(:,2), 'r', 'linewidth',3) 
hold on
plot(parS_ML(:,1), parS_ML(:,2), 'k', 'linewidth',3) 
xlabel('rate parameter, 1/d')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_sv_exp')
print -r0 -dpng rate_sv_exp
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0, 0.5, 0.5]);


Hfig6 = figure(6); % survivor functions
hold on
plot(Slambda_SB(:,1),Slambda_SB(:,2),'r', ...
     Slambda_ML(:,1),Slambda_ML(:,2),'k', 'linewidth',3)
plot([0;Mlambda_SB;Mlambda_SB], [0.5;0.5;0],'r', ...
     [0;Mlambda_ML;Mlambda_ML], [0.5;0.5;0],'k')
ylim([0 1])
xlim([0 2*lambda])
xlabel('rate parameter, 1/d')
ylabel('survivor function')
text(lambda,0.90, ['\color{red}{SB, median = ', num2str(Mlambda_SB,'%.3f'), '}'])
text(lambda,0.85, ['\color{black}{ML}, median = ', num2str(Mlambda_ML,'%.3f')])
set(gca, 'FontSize', 15, 'Box', 'on')
% title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda)])
savefig('rate_exp')
print -r0 -dpng 'rate_exp.png'
set(Hfig6, 'Outerposition',[50 200 600 600]);


end








