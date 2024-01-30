% Supporting Information: The relationship between confidence intervals and
% distributions of estimators for parameters of deterministic models

% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 

function mydata_F2S_wbl
% function mydata_F2S_wbl from loss to survivor function for Weibull
% distribution
%
% F_ML = - 2 log lik = 2 \sum_i(lamb t_i)^k - 2 n ln k - 2 n k ln lamb - 2 (k-1)\sum_i ln t_i
% pdf(t) = k*lambda*(t*lambda)^(k-1)*exp(-(lambda*t)^k)
% Bas Kooijman, 2021/07/28

clear all; close all;
% sets options for DEBtool_M function nmregr, see online package manual: 
nmregr_options('default'); nmregr_options('report',0); nmregr_options('max_step_number',1e5); nmregr_options('max_fun_evals',1e5);
wbl = @(shape, t) sum(t.^shape .* log(t))/ sum(t.^shape) - 1/shape - mean(log(t)); % ML fn for shape par

% par and estimates
lambda = 1;   % 1/d, real par value of wbl distr (must be positive)
k = 3;        % -, shape parameter
n = 5;        % #, number of trials for wbl distr (must be integer)
N = 5000;     % #, number of data sets for F_SB-surv
n_par = 5000; % #, number of parameter points in (par, conf) and (par, surv) graphs

% t0 = sort(wblrnd(lambda,k,n,1)); % d, sorted trials from pdf(t)=k*lambda*(t*lambda)^(k-1)*exp(-(lambda*t)^k)
% save('sample_wbl.mat','t0')
% load('sample_wbl.mat','t0')
t0 =[0.3766, 0.7110, 0.9817, 1.0399, 1.2428]';

par_ML0 = zeros(1,2); par_ML0(2) = fzero(@(shape) wbl(shape,t0), [.001 50]*k);
par_ML0(1) = 1/mean(t0.^par_ML0(2))^(1/par_ML0(2));
FML0 = sum((par_ML0(1)*t0).^par_ML0(2)) - n*log(par_ML0(2)) - n*par_ML0(2)*log(par_ML0(1)) - (par_ML0(2)-1)*sum(log(t0));
D0 = [t0, 1 - ((1:n)' - 0.5)/ n];
[par_SB0, ~, FSB0] = nmregr('weibull', [lambda 1; k 1], D0); par_SB0 = par_SB0(:,1);

% conditional distribution of loss function SB and ML
FSB = zeros(N,1); par_SB = zeros(N,2);  FML = zeros(N,1); par_ML = zeros(N,2); 
for i = 1:N
  l_SB = par_SB0(1,1); k_SB = par_SB0(2,1);
  t_SB = sort(wblrnd(l_SB,k_SB,n,1)); % d, sorted trials from pdf(t)=k*lambda*(t*lambda)^(k-1)*exp(-(lambda*t)^k)
%   [par, ~, FSB(i)] = nmregr('weibull', [lambda 1; k 1], [t, 1 - ((1:n)' - 0.5)/ n]); par_SB(i,:) = par(:,1)';
  [par, ~, FSB(i)] = nmregr('weibull', [par_SB0(1,1) 1; par_SB0(2,1) 1], [t_SB, 1 - ((1:n)' - 0.5)/ n]); par_SB(i,:) = par(:,1)';
  l_ML = par_ML0(1); k_ML = par_ML0(2);
  t_ML = sort(wblrnd(l_ML,k_ML,n,1)); % d, sorted trials from pdf(t)=k*lambda*(t*lambda)^(k-1)*exp(-(lambda*t)^k)
  par_ML(i,2) = fzero(@(shape) wbl(shape,t_ML), [.001 50]*k_ML);
  par_ML(i,1) = 1/mean(t_ML.^par_ML(i,2))^(1/par_ML(i,2));
  FML(i) = sum((par_ML(i,1)*t_ML).^par_ML(i,2)) - n*log(par_ML(i,2)) - n*par_ML(i,2)*log(par_ML(i,1)) - (par_ML(i,2)-1)*sum(log(t_ML));
end
FSB = FSB - FSB0; FSB = FSB(FSB >= 0); N_FSB = length(FSB); SFSB = [sort(FSB), 1 - ((1:N_FSB)' - 0.5)/ N_FSB];
FML = FML - FML0; FML = FML(FML >= 0); N_FML = length(FML); SFML = [sort(FML), 1 - ((1:N_FML)' - 0.5)/ N_FML];

Spar_SB = surv(par_SB(:,1)); Spar_ML = surv(par_ML(:,1)); 
Mpar_SB = median(par_SB(:,1)); Mpar_ML = median(par_ML(:,1)); 

% lf profile of pars
% rate = linspace(.05*lambda, 5*lambda, n_par)'; shape = linspace(.05*k, 5*k, n_par)';
rate = linspace(.05*par_SB0(1,1), 5*par_SB0(1,1), n_par)'; shape = linspace(.05*par_SB0(2,1), 5*par_SB0(2,1), n_par)';

F_SB = zeros(n_par,2); F_ML = zeros(n_par,2); 
for i=1:n_par
   prd = weibull([rate(i); par_SB0(2)], D0); F_SB(i,1) = mean(((prd - D0(:,2)).^2)./(mean(prd)^2 + mean(D0(:,2))^2)); 
   prd = weibull([par_SB0(1); shape(i)], D0); F_SB(i,2) = mean(((prd - D0(:,2)).^2)./(mean(prd)^2 + mean(D0(:,2))^2)); 
   F_ML(i,1) = sum((rate(i)*t0).^par_ML0(2)) - n*log(par_ML0(2)) - n*par_ML0(2)*log(rate(i)) - (par_ML0(2)-1)*sum(log(t0));
   F_ML(i,2) = sum((par_ML0(1)*t0).^shape(i)) - n*log(shape(i)) - n*shape(i)*log(par_ML0(1)) - (shape(i)-1)*sum(log(t0));
end
F_SB = F_SB - FSB0; F_ML = F_ML - FML0;

% 2-parameter lf profile - contour maps
n_par_1 = 200;
sc = linspace(.05*lambda, 2*lambda, n_par_1)'; sh = linspace(.05*k, 2.5*k, n_par_1)';
[X,Y] = meshgrid(sc,sh);
F_SB_2 = zeros(n_par_1,2); F_ML_2 = zeros(n_par_1,2); 
for i=1:n_par_1
    for j=1:n_par_1
        prd = weibull([sc(i); sh(j)], D0); 
        F_SB_2(i,j) = mean(((prd - D0(:,2)).^2)./(mean(prd)^2 + mean(D0(:,2))^2)); 
        F_ML_2(i,j) = sum((sc(i)*t0).^sh(j)) - n*log(sh(j)) - n*sh(j)*log(sc(i)) - (sh(j)-1)*sum(log(t0));
    end
end
conf_c=.1:.2:.9; 
for i=1:length(conf_c)
  Fc_SB(i) = max(0,spline1(1-conf_c(i), flip(flip(SFSB,2),1)));  
  Fc_ML(i) = max(0,spline1(1-conf_c(i), flip(flip(SFML,2),1)));  
end

% conf level of par
conf=.01:.01:.99; n_conf = length(conf); parbl = zeros(n_conf,4); parbu = zeros(n_conf,4);
% SB
for i=1:n_conf
  F = max(0,spline1(1-conf(i), flip(flip(SFSB,2),1)));
  b = rspline1([rate, F_SB(:,1)-F]); if length(b)==1; b = [0, b]; end
  parbl(i,[1 2]) =  [b(1), conf(i)]; parbu(i,[1 2]) =  [b(2), conf(i)];
  b = rspline1([shape, F_SB(:,2)-F]); if length(b)==1; b = [0, b]; end
  parbl(i,[3 4]) =  [b(1), conf(i)]; parbu(i,[3 4]) =  [b(2), conf(i)];
end
parb_SB = [flip(parbl,1); [par_SB0(1) 0 par_SB0(2) 0]; parbu]; 
range_SB = [parbl(n_conf,1), parbu(n_conf,1); parbl(n_conf,3), parbu(n_conf,3)]; % 0.99 conf interval
parS_SB = parb_SB; 
parS_SB(:,2) = (0.5 + parS_SB(:,2)/2) .* (parS_SB(:,1) <=  par_SB0(1)) + (1 - parS_SB(:,2))/2 .* (parS_SB(:,1) >  par_SB0(1));
parS_SB(:,4) = (0.5 + parS_SB(:,4)/2) .* (parS_SB(:,3) <=  par_SB0(2)) + (1 - parS_SB(:,4))/2 .* (parS_SB(:,3) >  par_SB0(2));
% ML
for i=1:n_conf
  F = max(0,spline1(1-conf(i), flip(flip(SFML,2),1)));
  b = rspline1([rate, F_ML(:,1)-F]); if length(b)==1; b = [0, b]; end
  parbl(i,[1 2]) =  [b(1), conf(i)]; parbu(i,[1 2]) =  [b(2), conf(i)];
  b = rspline1([shape, F_ML(:,2)-F]); if length(b)==1; b = [0, b]; end
  parbl(i,[3 4]) =  [b(1), conf(i)]; parbu(i,[3 4]) =  [b(2), conf(i)];
end
parb_ML = [flip(parbl,1); [par_ML0(1) 0 par_ML0(2) 0]; parbu];
range_ML = [parbl(n_conf,1), parbu(n_conf,1); parbl(n_conf,3), parbu(n_conf,3)]; % 0.99 conf interval
range = [min(range_SB(:,1),range_ML(:,1)), max(range_SB(:,2),range_ML(:,2))];
parS_ML = parb_ML; 
parS_ML(:,2) = (0.5 + parS_ML(:,2)/2) .* (parS_ML(:,1) <=  par_ML0(1)) + (1 - parS_ML(:,2))/2 .* (parS_ML(:,1) >  par_ML0(1));
parS_ML(:,4) = (0.5 + parS_ML(:,4)/2) .* (parS_ML(:,3) <=  par_ML0(2)) + (1 - parS_ML(:,4))/2 .* (parS_ML(:,3) >  par_ML0(2));

close all

Hfig1 = figure(1);
St0 = surv(t0); t=linspace(0, 1.1*t0(end),100);
plot(St0(:,1), St0(:,2), 'r')
hold on
plot(D0(:,1), D0(:,2), '.b', 'markersize', 12)
plot(t', weibull(par_SB0,t'), 'r', 'linewidth', 3)
xlabel('time, d');
ylabel('survivor function')
txt = 'data: '; for i=1:n; txt=[txt,' ',num2str(t0(i),'%.2f'),',']; end; txt(end)='';
title(txt)
text(.1,.15, ['\lambda = ', num2str(par_SB0(1),'%.3f'), ' d^{-1}'])
text(.1,.1,['k = ', num2str(par_SB0(2),'%.3f')])
set(gca, 'FontSize', 15)
savefig('sample_wbl')
print -r0 -dpng  sample_wbl
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.5, 0.25, 0.5]);

Hfig2 = figure(2); % loss function profile for rate par
colororder({'r','k'})
yyaxis left
plot(rate,F_SB(:,2),'r', 'linewidth',2);
xlabel('rate parameter, 1/d');
ylabel('\color{red}{F_{SB} - F_{SB}^{ref}}');
title('Weibull')
yyaxis right
plot(rate,F_ML(:,2),'k', 'linewidth',2);
ylabel('\color{black}{F_{ML} - F_{ML}^{ref}}');
set(gca, 'FontSize', 15, 'Box', 'on')
set(gca, 'xlim', range(1,:))
savefig('rate_lf_wbl')
print -r0 -dpng  rate_lf_wbl

Hfig3 = figure(3);
plot(parb_SB(:,1), parb_SB(:,2), 'r', 'linewidth',3) 
hold on 
plot(parb_ML(:,1), parb_ML(:,2), 'k', 'linewidth',3) 
xlabel('rate parameter, 1/d')
ylabel('confidence level')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_ci_wbl')
print -r0 -dpng  rate_ci_wbl
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0.5, 0.25, 0.5]);

Hfig4 = figure(4);
plot(parS_SB(:,1), parS_SB(:,2), 'r', 'linewidth',3) 
hold on
plot(parS_ML(:,1), parS_ML(:,2), 'k', 'linewidth',3) 
xlabel('rate parameter, 1/d')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_sv_wbl')
print -r0 -dpng  rate_sv_wbl
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0.5, 0.25, 0.5]);

Hfig5 = figure(5); % surv for loss functions 
xlabels{1} = 'F_{SB} - F_{SB}^{ref}';
xlabels{2} = 'F_{ML} - F_{ML}^{ref}';
ylabels{1} = 'survivor function';
ylabels{2} = 'survivor function';
[~,~,~] = plotxx(SFSB(:,1), SFSB(:,2), SFML(:,1), SFML(:,2),  xlabels, ylabels, 'r', 'k');
set(gca, 'FontSize', 15)
savefig('lf_wbl')
print -r0 -dpng  lf_wbl
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.25, 0.5]);

Hfig6 = figure(6); % loss function profile for shape par
colororder({'r','k'})
yyaxis left
plot(shape,F_SB(:,2),'r', 'linewidth',2);
xlabel('shape parameter, -')
ylabel('\color{red}{F_{SB} - F_{SB}^{ref}}');
title('Weibull')
yyaxis right
plot(shape,F_ML(:,2),'k', 'linewidth',2);
ylabel('\color{black}{F_{ML} - F_{ML}^{ref}}');
set(gca, 'FontSize', 15)
set(gca, 'FontSize', 15, 'Box', 'on')
set(gca, 'xlim', range(2,:))
savefig('shape_lf_wbl')
print -r0 -dpng  shape_lf_wbl
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.25, 0, 0.25, 0.5]);

Hfig7 = figure(7);
plot(parb_SB(:,3), parb_SB(:,4), 'r', 'linewidth',3) 
hold on 
plot(parb_ML(:,3), parb_ML(:,4), 'k', 'linewidth',3) 
xlabel('shape parameter, -')
ylabel('confidence level')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('shape_ci_wbl')
print -r0 -dpng  shape_ci_wbl
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0, 0.25, 0.5]);

Hfig8 = figure(8);
plot(parS_SB(:,3), parS_SB(:,4), 'r', 'linewidth',3) 
hold on
plot(parS_ML(:,3), parS_ML(:,4), 'k', 'linewidth',3) 
xlabel('shape parameter, -')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('shape_sv_wbl')
print -r0 -dpng  shape_sv_wbl
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);


Hfig9 = figure(9);
[C,h] = contour(X, Y, F_SB_2' - FSB0, [Fc_SB Fc_SB]);
xlim([0.5,1.5])
ylim([0,8])
title('SB-method')
xlabel('rate parameter, 1/d')
ylabel('shape parameter, -')
hold on
plot(lambda, k, '.g', par_SB0(1), par_SB0(2), '.k', 'markersize',20)
colormap(color_lava([1:256]/300))
h.LineWidth = 2;
savefig('profiles_SB')
print -r0 -dpng  profiles_SB
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);
set(gca, 'FontSize', 15, 'Box', 'on')

Hfig10 = figure(10);
[C,h] = contour(X,Y,F_ML_2' - FML0, [Fc_ML Fc_ML]);
xlim([0.5,1.5])
ylim([0,8])
title('ML-method')
xlabel('rate parameter, 1/d')
ylabel('shape parameter, -')
hold on
plot(lambda, k, '.g', par_ML0(1), par_ML0(2), '.k', 'markersize',20)
colormap(color_lava([1:256]/300))
h.LineWidth = 2;
savefig('profiles_ML')
print -r0 -dpng  profiles_ML
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0, 0.25, 0.5]);
set(gca, 'FontSize', 15, 'Box', 'on')

Spar_SB = surv(par_SB(:,1)); Spar_ML = surv(par_ML(:,1)); 
Mpar_SB = median(par_SB(:,1)); Mpar_ML = median(par_ML(:,1)); 

Hfig20 = figure(20); % survivor functions
hold on
plot(Spar_SB(:,1),Spar_SB(:,2),'r', ...
     Spar_ML(:,1),Spar_ML(:,2),'k', 'linewidth',3)
plot([0;Mpar_SB;Mpar_SB], [0.5;0.5;0],'r', ...
     [0;Mpar_ML;Mpar_ML], [0.5;0.5;0],'k')
ylim([0 1])
xlim([min(Spar_SB(1,1),Spar_ML(1,1)) 2*lambda])
xlabel('rate parameter, 1/d')
ylabel('survivor function')
text(lambda,0.90, ['\color{red}{SB, median = ', num2str(Mpar_SB,'%.3f'), '}'])
text(lambda,0.85, ['\color{black}{ML}, median = ', num2str(Mpar_ML,'%.3f')])
% title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda), ', k = ', num2str(k)])
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('rate_wbl')
print -r0 -dpng rate_wbl.png

Spar_SB = surv(par_SB(:,2)); Spar_ML = surv(par_ML(:,2)); 
Mpar_SB = median(par_SB(:,2)); Mpar_ML = median(par_ML(:,2)); 

Hfig21 = figure(21); % survivor functions
hold on
plot(Spar_SB(:,1),Spar_SB(:,2),'r', ...
     Spar_ML(:,1),Spar_ML(:,2),'k', 'linewidth',3)
plot([0;Mpar_SB;Mpar_SB], [0.5;0.5;0],'r', ...
     [0;Mpar_ML;Mpar_ML], [0.5;0.5;0],'k')
ylim([0 1])
xlim([0 8*k])
xlabel('shape parameter, -')
ylabel('survivor function')
text(3*k,0.90, ['\color{red}{SB, median = ', num2str(Mpar_SB,'%.3f'), '}'])
text(3*k,0.85, ['\color{black}{ML}, median = ', num2str(Mpar_ML,'%.3f')])
% title(['n = ', num2str(n), '; N = ', num2str(N), '; \lambda = ', num2str(lambda), ', k = ', num2str(k)])
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('shape_wbl')
print -r0 -dpng shape_wbl.png

% compute bias
Bias_ML = [par_ML0(1) - median(par_ML(:,1)), par_ML0(2) - median(par_ML(:,2))]
Bias_SB = [par_SB0(1) - median(par_SB(:,1)), par_SB0(2) - median(par_SB(:,2))]

end



