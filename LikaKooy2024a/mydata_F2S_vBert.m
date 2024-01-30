% Supporting Information: The relationship between confidence intervals and
% distributions of estimators for parameters of deterministic models
% generates fig. 11 and 12
%
% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 
%
% calls custum function vBert.m

function mydata_F2S_vBert
% data for Nothobranchius_furzeri (Turquoise killifish) females, males
% Blazek, R., Polacik, M., and Reichard, M. (2013). Rapid growth, early
% maturation and short generation time in African annual fishes. EvoDevo, 4:1–24
% 
% Model (see text): 
% L(t) = L_i - (L_i - L_0) exp(-r_B t); L_i = f v/g k_M; r_B = k_M/3/(1 + f/g);
% parameters (see text): L_b, L_i, L_im, g, k_M

close all; 
% sets options for DEBtool_M function nmregr, see online package manual:
nmregr_options('default'); nmregr_options('max_step_number',1e3); nmregr_options('max_fun_evals',1e3);
nmregr_options('report',0); 

%% % Data extracted from Blazek et al 2013:
% % time-length
% % t-L/N data population NF221
tL_f = [ ... % time since birth (d), standard length (cm) females
0.000	0.458
6.146	1.017
13      2.37 % puberty
13.659	2.525
19      2.9  % first spawn
20.488	3.186
27.659	3.525
41.659	4.271
62.829	4.610
84.000	4.542
112.341	4.373];
% units are day and cm; xlabel is time since birth; y labels are total
% length; experimental temparature is: 27.5 deg C.; comments on the data on population NF221; hatch at 16 C, till 2 d, then 25.3 C till 8 d';
%
tL_m = [ ... % time since birth (d), standard length (cm) males
0.000	0.458
6.146	1.017
13      2.37 % puberty
13.659	2.525
19      3.52 % first spawn  
20.488	3.746
27.659	4.712
41.659	5.559
63.171	6.102
84.000	6.492
112.000	6.644];
% % units are day and cm; xlabel is time since birth; y labels are total
% % length; experimental temparature is: 27.5 deg C.; comments on the data on population NF221; hatch at 16 C, till 2 d, then 25.3 C till 8 d';

% model parameters: 
L_b  = 0.24; % cm
L_i  = 4.66; % cm
L_im = 6.89; % cm
g    = 0.15; % -
k_M  = 1.14; % 1/d
N    = 1000;% # of successful Monte Carlo trials of adding noise (takes lots of time)
n_range = 100;
  
% data + prd
par_0 = [L_b 0; L_i 1;  L_im 1; g 1; k_M 1]; 
[par_0, ~, FSB0] = nmregr('vBert', par_0, tL_f, tL_m); 
t = linspace(0,115,100)'; 
[EL_f, EL_m] = vBert(par_0(:,1), tL_f, tL_m); 
[L_f, L_m] = vBert(par_0(:,1), t, t); 

% compute cv to be used to generate new datasets
% cv = the mean of the absolute difference between observed and predicted 
% values divided by the predicted value
cv = 0.5 * (sum(abs(tL_f(:,2)-EL_f)./EL_f)/length(EL_f) + sum(abs(tL_m(:,2)-EL_m)./EL_m)/length(EL_m) );

% survivor of F_SB
% par_MC = zeros(N,5); FSB = zeros(N,1); info = 0; 
% for i=1:N
%   while info==0 || FSB(i) < FSB0 || par_MC(i,5) < 1e-3 || par_MC(i,5) > 100
%     tLf = [tL_f(:,1), add_noise(EL_f, cv, 1)];  
%     tLm = [tL_m(:,1), add_noise(EL_m, cv, 1)];  
%     [pari, info, FSB(i)] = nmregr('vBert', par_0, tLf, tLm);  
%     par_MC(i,:) = pari(:,1)';
%   end
%   if mod(i,50) == 0
%     fprintf(['i = ', num2str(i), ' of ', num2str(N), '\n'])
%   end
% end
% save('vBert.mat', 'par_0', 'FSB0', 'FSB', 'par_MC', '-append');
load('vBert.mat', 'par_0', 'FSB0', 'FSB', 'par_MC');

% add point estimate and create survivor functions
FSB  = [0; FSB - FSB0]; 
surv = [1; 1 - ((1:N)' - 0.5)/ N];
surv_FSB = [sort(FSB), surv]; %FSB01 = spline1(0.01, flip(surv_FSB,2));
surv_Li  = [sort([par_0(2,1);par_MC(:,2)]), surv];
surv_Lim = [sort([par_0(3,1);par_MC(:,3)]), surv];
surv_g   = [sort([par_0(4,1);par_MC(:,4)]), surv];
surv_kM  = [sort([par_0(5,1);par_MC(:,5)]), surv];

% F_SB profiles starting close to point estimate, working down and up
% F_SB profile for L_i
par = par_0; par(2:5,2) = 1; ind = 1:n_range;
L_i = linspace(1,10,n_range)'; par_L_i = zeros(n_range,5); FSB_L_i = zeros(n_range,1);
for i=flip(ind(L_i < par_0(2,1)))
  par(2,:) = [L_i(i) 0]; 
  [par, ~, FSB_L_i(i)] = nmregr('vBert', par, tL_f, tL_m); par_L_i(i,:) = par(:,1)';
  FSB_L_i(i) = FSB_L_i(i)-FSB0;
end
par = par_0;
for i=ind(L_i >= par_0(2,1))
  par(2,:) = [L_i(i) 0]; 
  [par, ~, FSB_L_i(i)] = nmregr('vBert', par, tL_f, tL_m); par_L_i(i,:) = par(:,1)';
  FSB_L_i(i) = FSB_L_i(i)-FSB0;
end
save('vBert.mat', 'L_i', 'FSB_L_i', '-append');

% F_SB profile for L_im
par = par_0; par(2:5,2) = 1; ind = 1:n_range;
L_im = linspace(2,13,n_range)'; par_L_im = zeros(n_range,5); FSB_L_im = zeros(n_range,1);
for i=flip(ind(L_im < par_0(3,1)))
  par(3,:) = [L_im(i) 0]; 
  [par, ~, FSB_L_im(i)] = nmregr('vBert', par, tL_f, tL_m); par_L_im(i,:) = par(:,1)';
  FSB_L_im(i) = FSB_L_im(i)-FSB0;
end
par = par_0;
for i=ind(L_im >= par_0(3,1))
  par(3,:) = [L_im(i) 0]; 
  [par, ~, FSB_L_im(i)] = nmregr('vBert', par, tL_f, tL_m); par_L_im(i,:) = par(:,1)';
  FSB_L_im(i) = FSB_L_im(i)-FSB0;
end
save('vBert.mat', 'L_im', 'FSB_L_im', '-append');

% F_SB profile for g
par = par_0; par(2:5,2) = 1; ind = 1:n_range;
g = linspace(0.001,2.5,n_range)'; par_g = zeros(n_range,5); FSB_g = zeros(n_range,1);
for i=flip(ind(g < par_0(4,1)))
  par(4,:) = [g(i) 0]; 
  [par, ~, FSB_g(i)] = nmregr('vBert', par, tL_f, tL_m); par_g(i,:) = par(:,1)';
  FSB_g(i) = FSB_g(i)-FSB0;
end
par = par_0;
for i=ind(g >= par_0(4,1))
  par(4,:) = [g(i) 0]; 
  [par, ~, FSB_g(i)] = nmregr('vBert', par, tL_f, tL_m); par_g(i,:) = par(:,1)';
  FSB_g(i) = FSB_g(i)-FSB0;
end
save('vBert.mat', 'g', 'FSB_g', '-append');

% F_SB profile for k_M
par = par_0; par(2:5,2) = 1; ind = 1:n_range;
k_M = linspace(0.1,20,n_range)'; par_k_M = zeros(n_range,5); FSB_k_M = zeros(n_range,1);
for i=flip(ind(k_M < par_0(5,1)))
  par(5,:) = [k_M(i) 0]; 
  [par, ~, FSB_k_M(i)] = nmregr('vBert', par, tL_f, tL_m); par_k_M(i,:) = par(:,1)';
  FSB_k_M(i) = FSB_k_M(i)-FSB0;
end
par = par_0;
for i=ind(k_M >= par_0(5,1))
  par(5,:) = [k_M(i) 0]; 
  [par, ~, FSB_k_M(i)] = nmregr('vBert', par, tL_f, tL_m); par_k_M(i,:) = par(:,1)';
  FSB_k_M(i) = FSB_k_M(i)-FSB0;
end
save('vBert.mat', 'k_M', 'FSB_k_M', '-append');

% conf level of par
conf=.01:.01:.99; n_conf = length(conf); 
Li_bl  = zeros(n_conf,2); Li_bu  = zeros(n_conf,2);
Lim_bl = zeros(n_conf,2); Lim_bu = zeros(n_conf,2);
g_bl   = zeros(n_conf,2); g_bu   = zeros(n_conf,2);
kM_bl  = zeros(n_conf,2); kM_bu  = zeros(n_conf,2);
for i=1:n_conf
  F = spline1(1-conf(i), flip(flip(surv_FSB,2),1));
  b = rspline1([L_i, FSB_L_i-F]); 
  if length(b)<2; fprintf('L_i\n');end
  Li_bl(i,:) =  [b(1), conf(i)]; Li_bu(i,:) =  [b(2), conf(i)];
  
  b = rspline1([L_im, FSB_L_im-F]);
  if length(b)<2; fprintf('L_im\n');end
  Lim_bl(i,:) =  [b(1), conf(i)]; Lim_bu(i,:) =  [b(2), conf(i)];
  
  b = rspline1([g, FSB_g-F]); 
  if length(b)<1; b = [0 2.5]; elseif length(b)<2; b = [0 b]; end
  g_bl(i,:) =  [b(1), conf(i)]; g_bu(i,:) =  [b(2), conf(i)];
  
  b = rspline1([k_M, FSB_k_M-F]); 
  if length(b)<1; b = [0 20]; elseif length(b)<2; b = [b, 20]; end
  kM_bl(i,:) =  [b(1), conf(i)]; kM_bu(i,:) =  [b(2), conf(i)];
end
% ci boundaries
Li_b  = [flip(Li_bl,1);  [par_0(2,1) 0]; Li_bu];  Li_S = Li_b;
Lim_b = [flip(Lim_bl,1); [par_0(3,1) 0]; Lim_bu]; Lim_S = Lim_b;
g_b   = [flip(g_bl,1);   [par_0(4,1) 0]; g_bu];   g_S = g_b;
kM_b  = [flip(kM_bl,1);  [par_0(5,1) 0]; kM_bu];  kM_S = kM_b;
save('vBert.mat', 'Li_b', 'Lim_b', 'g_b', 'kM_b', '-append');
%load('vBert.mat', 'Li_b', 'Lim_b', 'g_b', 'kM_b');
% surv
Li_S(:,2)  = (0.5 + Li_S(:,2)/2)  .* (Li_S(:,1)  <=  par_0(2,1)) + (1 - Li_S(:,2))/2  .* (Li_S(:,1)  >  par_0(2,1));
Lim_S(:,2) = (0.5 + Lim_S(:,2)/2) .* (Lim_S(:,1) <=  par_0(3,1)) + (1 - Lim_S(:,2))/2 .* (Lim_S(:,1) >  par_0(3,1));
g_S(:,2)   = (0.5 + g_S(:,2)/2)   .* (g_S(:,1)   <=  par_0(4,1)) + (1 - g_S(:,2))/2   .* (g_S(:,1)   >  par_0(4,1));
kM_S(:,2)  = (0.5 + kM_S(:,2)/2)  .* (kM_S(:,1)  <=  par_0(5,1)) + (1 - kM_S(:,2))/2  .* (kM_S(:,1)  >  par_0(5,1));
save('vBert.mat', 'Li_S', 'Lim_S', 'g_S', 'kM_S', '-append');
%load('vBert.mat', 'Li_S', 'Lim_S', 'g_S', 'kM_S');

close all

figure(1) % data + prd
plot(tL_f(:,1), tL_f(:,2), '.r', tL_m(:,1), tL_m(:,2), '.b', 'markersize', 20);
hold on
plot(t, L_f, 'r', t, L_m, 'b', 'linewidth', 3)
xlabel('time since birth, d')
ylabel('total length, cm')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('vBert')
print -r0 -dpng vBert

figure(2) % Monte Carlo surv FSB
plot(surv_FSB(:,1), surv_FSB(:,2), 'r', 'linewidth', 3);
xlabel('loss function F_{SB} - F_{SB}^{min}')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('lf_vBert')
print -r0 -dpng lf_vBert

figure(3) % Monte Carlo surv Li and Lim
plot(surv_Li(:,1), surv_Li(:,2), 'r', 'linewidth', 3);
hold on
plot(surv_Lim(:,1), surv_Lim(:,2), 'b', 'linewidth', 3);
xlabel('ultimate total length L_{\infty}, cm')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('Li_vBert')
print -r0 -dpng Li_vBert

figure(4) % Monte Carlo surv g
plot(surv_g(:,1), surv_g(:,2), 'r', 'linewidth', 3);
xlabel('energy investment ratio of female g_f, -')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('g_vBert')
print -r0 -dpng g_vBert

figure(5) % Monte Carlo surv kM
plot(surv_kM(:,1), surv_kM(:,2), 'r', 'linewidth', 3);
xlabel('maintenance rate coeffient k_M, 1.d')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('kM_vBert')
print -r0 -dpng kM_vBert

figure(6) % profile for Li and Lim
plot(L_i(:,1), FSB_L_i, 'r', 'linewidth', 3);
hold 
ylim([0 .03])
plot(L_im, FSB_L_im, 'b', 'linewidth', 3);
xlabel('ultimate total length L_{\infty}, cm')
ylabel('loss function F_{SB} - F_{SB}^{min}')
set(gca, 'FontSize', 15, 'Box', 'on')
savefig('Li_lf_vBert')
print -r0 -dpng Li_lf_vBert

figure(7) % profile for g
plot(g, FSB_g, 'r', 'linewidth', 3);
xlabel('energy investment ratio of female g_f, -')
ylabel('loss function F_{SB} - F_{SB}^{min}')
set(gca, 'FontSize', 15, 'Box', 'on')
%ylim([0 FSB01]);
savefig('g_lf_vBert')
print -r0 -dpng g_lf_vBert

figure(8) % profile for kM
plot(k_M, FSB_k_M, 'r', 'linewidth', 3);
xlabel('maintenance rate coeffient k_M, 1/d')
ylabel('loss function F_{SB} - F_{SB}^{min}')
set(gca, 'FontSize', 15, 'Box', 'on')
ylim([0 0.0001]);
savefig('kM_lf_vBert')
print -r0 -dpng kM_lf_vBert

figure(9) % ci for Li and Lim
plot(Li_b(:,1), Li_b(:,2), 'r', 'linewidth', 3);
hold on
plot(Lim_b(:,1), Lim_b(:,2), 'b', 'linewidth', 3);
xlabel('ultimate total length L_{\infty}, cm')
ylabel('confidence level')
set(gca, 'FontSize', 15, 'Box', 'on')
ylim([0 1]); xlim([3 11]);
savefig('Li_ci_vBert')
print -r0 -dpng Li_ci_vBert

figure(10) % ci for g
plot(g_b(:,1), g_b(:,2), 'r', 'linewidth', 3);
xlabel('energy investment ratio of female g_f, -')
ylabel('confidence level')
set(gca, 'FontSize', 15, 'Box', 'on')
xlim([0 2.499])
ylim([0 1]);
savefig('g_ci_vBert')
print -r0 -dpng g_ci_vBert

figure(11) % ci for kM
plot(kM_b(:,1), kM_b(:,2), 'r', 'linewidth', 3);
xlabel('maintenance rate coeffient k_M, 1/d')
ylabel('confidence level')
set(gca, 'FontSize', 15, 'Box', 'on')
xlim([0 19.99])
ylim([0 1]);
savefig('kM_ci_vBert')
print -r0 -dpng kM_ci_vBert

figure(12) % surv for Li and Lim
plot(Li_S(:,1), Li_S(:,2), 'r', 'linewidth', 3);
hold on
plot(Lim_S(:,1), Lim_S(:,2), 'b', 'linewidth', 3);
xlabel('ultimate total length L_{\infty}, cm')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
ylim([0 1]);
savefig('Li_sv_vBert')
print -r0 -dpng Li_sv_vBert

figure(13) % surv for g
plot(g_S(:,1), g_S(:,2), 'r', 'linewidth', 3);
xlabel('energy investment ratio of female g_f, -')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
xlim([0 2.499])
ylim([0 1]);
savefig('g_sv_vBert')
print -r0 -dpng g_sv_vBert

figure(14) % surv for kM
plot(kM_S(:,1), kM_S(:,2), 'r', 'linewidth', 3);
xlabel('maintenance rate coeffient k_M, 1/d')
ylabel('survivor function')
set(gca, 'FontSize', 15, 'Box', 'on')
xlim([0 19.99])
ylim([0 1]);
savefig('kM_sv_vBert')
print -r0 -dpng kM_sv_vBert

end

