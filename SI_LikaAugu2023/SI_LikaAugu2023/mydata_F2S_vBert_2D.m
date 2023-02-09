% Supporting Information: The relationship between confidence intervals and
% distributions of estimators for parameters of deterministic models
%
% calls custum function vBert.m
%
% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code that is commented in the function here below allows generating
% the data saved in vBert_2D.mat as well as vBert.mat - uncomment relevant
% parts to re-generate the underlying data for fig. 13, however this will
% take time. Otherwise file loads vBert_2D.mat with stored variables and
% generates plots for fig. 13. It is also possible to use the monte carlo
% generated data in vBert.mat and re-run the code to generate variables
% stored in vBert_2D.mat

function mydata_F2S_vBert_2D
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

N = 1000; % # of successful Monte Carlo trials of adding noise (takes lots of time)

%% % Data extracted from Blazek et al 2013:
% % time-length
% % t-L data population NF221
% tL_f = [ ... % time since birth (d), standard length (cm) females
% 0.000	0.458
% 6.146	1.017
% 13      2.37 % puberty
% 13.659	2.525
% 19      2.9  % first spawn
% 20.488	3.186
% 27.659	3.525
% 41.659	4.271
% 62.829	4.610
% 84.000	4.542
% 112.341	4.373];
% % units are day and cm; xlabel is time since birth; y labels are total
% % length; experimental temparature is: 27.5 deg C.; comments on the data on population NF221; hatch at 16 C, till 2 d, then 25.3 C till 8 d';
% %
% tL_m = [ ... % time since birth (d), standard length (cm) males
% 0.000	0.458
% 6.146	1.017
% 13      2.37 % puberty
% 13.659	2.525
% 19      3.52 % first spawn  
% 20.488	3.746
% 27.659	4.712
% 41.659	5.559
% 63.171	6.102
% 84.000	6.492
% 112.000	6.644];
% % units are day and cm; xlabel is time since birth; y labels are total
% % length; experimental temparature is: 27.5 deg C.; comments on the data on population NF221; hatch at 16 C, till 2 d, then 25.3 C till 8 d';

%% % Define parameters: 
% L_b = 0.24; % cm
% L_i = 4.66; % cm
% L_im = 6.89; % cm
% g = 0.15; % -
% k_M = 1.14; % 1/d
% n_range = 100;
  
%% % data + prd
% par_0 = [L_b 0; L_i 1;  L_im 1; g 1; k_M 1]; 
% [par_0, ~, FSB0] = nmregr('vBert', par_0, tL_f, tL_m); save('par_vBert', 'par_0', 'FSB0');
% t = linspace(0,115,100)'; 
% [EL_f, EL_m] = vBert(par_0(:,1), tL_f, tL_m); n_Lf = length(EL_f); n_Lm = length(EL_m);
% [L_f, L_m]   = vBert(par_0(:,1), t, t); 
% % par_0(:,1)
% % FSB0

%% % survivor of F_SB
% sd_f = (mean((EL_f - tL_f(:,2)).^2))^0.5; sd_m = (mean((EL_m - tL_m(:,2)).^2))^0.5;
% par_MC = zeros(N,5); FSB = zeros(N,1); info = 0; 
% for i=1:N
%   while info==0 || FSB(i) < FSB0 || par_MC(i,5) < 1e-3 || par_MC(i,5) > 100
%     scat_f = sqrt(-2 * log(rand(n_Lf,1))) .* cos(2 * pi * rand(n_Lf,1));
%     scat_m = sqrt(-2 * log(rand(n_Lm,1))) .* cos(2 * pi * rand(n_Lm,1));
%     tLf = [tL_f(:,1), EL_f+sd_f*scat_f]; tLm = [tL_m(:,1), EL_m+sd_m*scat_m]; 
%     [pari, info, FSB(i)] = nmregr('vBert', par_0, tLf, tLm);  
%     par_MC(i,:) = pari(:,1)';
%   end
%   if mod(i,50) == 0
%     fprintf(['i = ', num2str(i), ' of ', num2str(N), '\n'])
%   end
% end
% save('vBert.mat', 'par_0', 'FSB0', 'FSB', 'par_MC', '-append');
% load('vBert.mat', 'par_0', 'FSB0', 'FSB', 'par_MC');
load('vBert.mat', 'par_0',  'FSB');

%% % add point estimate and create survivor functions
% FSB  = [0; FSB - FSB0]; 
surv = [1; 1 - ((1:N)' - 0.5)/ N];
surv_FSB = [sort(FSB), surv]; %FSB01 = spline1(0.01, flip(surv_FSB,2));
% surv_Li  = [sort([par_0(2,1);par_MC(:,2)]), surv];
% surv_Lim = [sort([par_0(3,1);par_MC(:,3)]), surv];
% surv_g   = [sort([par_0(4,1);par_MC(:,4)]), surv];
% surv_kM  = [sort([par_0(5,1);par_MC(:,5)]), surv];

% load('vBert.mat', 'Li_S', 'Lim_S', 'g_S', 'kM_S');

%% % 2-parameter lf profile - contour maps
% % % profile for L_i and L_im
% par = par_0; par(2:5,2) = 1; ind = 1:n_range;
% L_i = linspace(3,6,n_range)'; L_im = linspace(5,8,n_range)'; 
% par_L_i_im = zeros(n_range,5); FSB_L_i_im = zeros(n_range,2);
% par_4 = par_0(4,1)*ones(n_range, n_range); par_5 = par_0(5,1)*ones(n_range, n_range); 
% [X_L_i_im,Y_L_i_im] = meshgrid(L_i,L_im);
% for i=flip(ind(L_i < par_0(2,1)))
%     for j=flip(ind(L_im < par_0(3,1)))
%         par(2,:) = [L_i(i) 0]; 
%         par(3,:) = [L_im(j) 0];
%         par(4,:) = [par_4(i+1,j+1) 1];
%         par(5,:) = [par_5(i+1,j+1) 1];
%         [par, ~, FSB_L_i_im(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_im(i,:) = par(:,1)';
%         par_4(i,j) = par(4,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_im(i,j) = FSB_L_i_im(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(L_im >= par_0(3,1))
%         par(2,:) = [L_i(i) 0]; 
%         par(3,:) = [L_im(j) 0];
%         par(4,:) = [par_4(i+1,j-1) 1];
%         par(5,:) = [par_5(i+1,j-1) 1];
%         [par, ~, FSB_L_i_im(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_im(i,:) = par(:,1)';
%         par_4(i,j) = par(4,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_im(i,j) = FSB_L_i_im(i,j)-FSB0;
%     end
% end
% 
% for i=ind(L_i >= par_0(2,1))
%     for j=flip(ind(L_im < par_0(3,1)))
%         par(2,:) = [L_i(i) 0]; 
%         par(3,:) = [L_im(j) 0];
%         par(4,:) = [par_4(i-1,j+1) 1];
%         par(5,:) = [par_5(i-1,j+1) 1];
%         [par, ~, FSB_L_i_im(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_im(i,:) = par(:,1)';
%         par_4(i,j) = par(4,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_im(i,j) = FSB_L_i_im(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(L_im >= par_0(3,1))
%         par(2,:) = [L_i(i) 0]; 
%         par(3,:) = [L_im(j) 0];
%         par(4,:) = [par_4(i-1,j-1) 1];
%         par(5,:) = [par_5(i-1,j-1) 1];
%         [par, ~, FSB_L_i_im(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_im(i,:) = par(:,1)';
%         par_4(i,j) = par(4,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_im(i,j) = FSB_L_i_im(i,j)-FSB0;
%     end
% end
% 
% save('vBert_2D.mat', 'FSB_L_i_im', 'X_L_i_im', 'Y_L_i_im')
% 
%% % profile for L_i and g
% par = par_0; par(2:5,2) = 1; ind = 1:n_range;
% L_i = linspace(3,6,n_range)'; g = linspace(0.00001,4,n_range)';
% par_L_i_g = zeros(n_range,5); FSB_L_i_g = zeros(n_range,2);
% par_3 = par_0(3,1)*ones(n_range, n_range); par_5 = par_0(5,1)*ones(n_range, n_range); 
% [X_L_i_g,Y_L_i_g] = meshgrid(L_i,g);
% for i=flip(ind(L_i < par_0(2,1)))
%     for j=flip(ind(g < par_0(4,1)))
%         par(2,:) = [L_i(i) 0]; 
%         par(4,:) = [g(j) 0];
%         par(3,:) = [par_3(i+1,j+1) 1];
%         par(5,:) = [par_5(i+1,j+1) 1];
%         [par, ~, FSB_L_i_g(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_g(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_g(i,j) = FSB_L_i_g(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(g >= par_0(4,1))
%         par(2,:) = [L_i(i) 0]; 
%         par(4,:) = [g(j) 0];
%         par(3,:) = [par_3(i+1,j-1) 1];
%         par(5,:) = [par_5(i+1,j-1) 1];
%         [par, ~, FSB_L_i_g(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_g(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_g(i,j) = FSB_L_i_g(i,j)-FSB0;
%     end
% end
% 
% for i=ind(L_i >= par_0(2,1))
%     for j=flip(ind(g < par_0(4,1)))
%         par(2,:) = [L_i(i) 0]; 
%         par(4,:) = [g(j) 0];
%         par(3,:) = [par_3(i-1,j+1) 1];
%         par(5,:) = [par_5(i-1,j+1) 1];
%         [par, ~, FSB_L_i_g(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_g(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_g(i,j) = FSB_L_i_g(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(g >= par_0(4,1))
%         par(2,:) = [L_i(i) 0]; 
%         par(4,:) = [g(j) 0];
%         par(3,:) = [par_3(i-1,j-1) 1];
%         par(5,:) = [par_5(i-1,j-1) 1];
%         [par, ~, FSB_L_i_g(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_g(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_5(i,j) = par(5,1); 
%         FSB_L_i_g(i,j) = FSB_L_i_g(i,j)-FSB0;
%     end
% end
% 
% save('vBert_2D.mat', 'FSB_L_i_g', 'X_L_i_g', 'Y_L_i_g', '-append')
% 
%% % profile for L_i and k_M
% par = par_0; par(2:5,2) = 1; ind = 1:n_range;
% L_i = linspace(3,6,n_range)'; k_M = linspace(0.1,20,n_range)'; 
% par_L_i_kM = zeros(n_range, 5); FSB_L_i_kM = zeros(n_range, n_range);
% par_3 = par_0(3,1)*ones(n_range, n_range); par_4 = par_0(4,1)*ones(n_range, n_range); 
% [X_L_i_kM, Y_L_i_kM] = meshgrid(L_i,k_M);
% for i=flip(ind(L_i < par_0(2,1)))
%     for j=flip(ind(k_M < par_0(5,1)))
%         par(2,:) = [L_i(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(3,:) = [par_3(i+1,j+1) 1];
%         par(4,:) = [par_4(i+1,j+1) 1];
%         [par, ~, FSB_L_i_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_kM(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_4(i,j) = par(4,1); 
%         FSB_L_i_kM(i,j) = FSB_L_i_kM(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(k_M >= par_0(5,1))
%         par(2,:) = [L_i(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(3,:) = [par_3(i+1,j-1) 1];
%         par(4,:) = [par_4(i+1,j-1) 1];
%         [par, ~, FSB_L_i_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_kM(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_4(i,j) = par(4,1); 
%         FSB_L_i_kM(i,j) = FSB_L_i_kM(i,j)-FSB0;
%     end
% end
% 
% for i=ind(L_i >= par_0(2,1))
%     for j=flip(ind(k_M < par_0(5,1)))
%         par(2,:) = [L_i(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(3,:) = [par_3(i-1,j+1) 1];
%         par(4,:) = [par_4(i-1,j+1) 1];
%         [par, ~, FSB_L_i_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_kM(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_4(i,j) = par(4,1); 
%         FSB_L_i_kM(i,j) = FSB_L_i_kM(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(k_M >= par_0(5,1))
%         par(2,:) = [L_i(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(3,:) = [par_3(i-1,j-1) 1];
%         par(4,:) = [par_4(i-1,j-1) 1];
%         [par, ~, FSB_L_i_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_L_i_kM(i,:) = par(:,1)';
%         par_3(i,j) = par(3,1); par_4(i,j) = par(4,1); 
%         FSB_L_i_kM(i,j) = FSB_L_i_kM(i,j)-FSB0;
%     end
% end
% save('vBert_2D.mat', 'FSB_L_i_kM', 'X_L_i_kM', 'Y_L_i_kM', '-append')
% 
%% % profile for g and kM
% par = par_0; par(2:5,2) = 1; ind = 1:n_range;
% g = linspace(0.05,0.5,n_range)'; k_M = linspace(0.5,2.5,n_range)'; 
% par_g_kM = zeros(n_range,5); FSB_g_kM = zeros(n_range,2);
% par_2 = par_0(2,1)*ones(n_range, n_range); par_3 = par_0(3,1)*ones(n_range, n_range); 
% [X_g_kM,Y_g_kM] = meshgrid(g,k_M);
% for i=flip(ind(g < par_0(4,1)))
%     for j=flip(ind(k_M < par_0(5,1)))
%         par(4,:) = [g(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(2,:) = [par_2(i+1,j+1) 1];
%         par(3,:) = [par_3(i+1,j+1) 1];
%         [par, ~, FSB_g_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_g_kM(i,:) = par(:,1)';
%         par_2(i,j) = par(2,1); par_3(i,j) = par(3,1); 
%         FSB_g_kM(i,j) = FSB_g_kM(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(k_M >= par_0(5,1))
%         par(4,:) = [g(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(2,:) = [par_2(i+1,j-1) 1];
%         par(3,:) = [par_3(i+1,j-1) 1];
%         [par, ~, FSB_g_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_g_kM(i,:) = par(:,1)';
%         par_2(i,j) = par(2,1); par_3(i,j) = par(3,1); 
%         FSB_g_kM(i,j) = FSB_g_kM(i,j)-FSB0;
%     end
% end
% 
% for i=ind(g >= par_0(4,1))
%     for j=flip(ind(k_M < par_0(5,1)))
%         par(4,:) = [g(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(2,:) = [par_2(i-1,j+1) 1];
%         par(3,:) = [par_3(i-1,j+1) 1];
%         [par, ~, FSB_g_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_g_kM(i,:) = par(:,1)';
%         par_2(i,j) = par(2,1); par_3(i,j) = par(3,1); 
%         FSB_g_kM(i,j) = FSB_g_kM(i,j)-FSB0;
%     end
%     par = par_0;
%     for j=ind(k_M >= par_0(5,1))
%         par(4,:) = [g(i) 0]; 
%         par(5,:) = [k_M(j) 0];
%         par(2,:) = [par_2(i-1,j-1) 1];
%         par(3,:) = [par_3(i-1,j-1) 1];
%         [par, ~, FSB_g_kM(i,j)] = nmregr('vBert', par, tL_f, tL_m); par_g_kM(i,:) = par(:,1)';
%         par_2(i,j) = par(2,1); par_3(i,j) = par(3,1); 
%         FSB_g_kM(i,j) = FSB_g_kM(i,j)-FSB0;
%     end
% end

% save('vBert_2D.mat', 'FSB_g_kM', 'X_g_kM', 'Y_g_kM', '-append')

%% Subfigures for fig. 13
load('vBert_2D.mat'); % loads all variabless stored in this file which are generated in the previously commented code. 

conf_c=.1:.2:.9; 
for i=1:length(conf_c)
  Fc_SB(i) = max(0,spline1(1-conf_c(i), flip(flip(surv_FSB,2),1)));  
end

figure()
[~,h] = contour(X_L_i_im, Y_L_i_im, FSB_L_i_im', [Fc_SB Fc_SB]);
xlabel('female L_i, cm')
ylabel('male L_i, cm')
hold on
plot(par_0(2,1), par_0(3,1), '.k', 'markersize',20)
colormap(color_lava([1:256]/300))
h.LineWidth = 2;
savefig('profiles_Li_im')
print -r0 -dpng  profiles_Li_im
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);
set(gca, 'FontSize', 15, 'Box', 'on')

figure()
[~,h] = contour(X_L_i_g, Y_L_i_g, FSB_L_i_g', [Fc_SB Fc_SB]);
xlabel('female L_i, cm')
ylabel('energy investment ratio of female g_f, -')
hold on
plot(par_0(2,1), par_0(4,1), '.k', 'markersize',20)
colormap(color_lava([1:256]/300))
h.LineWidth = 2;
savefig('profiles_Li_g')
print -r0 -dpng  profiles_Li_g
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);
set(gca, 'FontSize', 15, 'Box', 'on')

figure()
[~,h] = contour(X_L_i_kM, Y_L_i_kM, FSB_L_i_kM', [Fc_SB Fc_SB]);
xlabel('female L_i, cm')
ylabel('maintenance rate coeffient k_M, 1/d')
hold on
plot(par_0(2,1), par_0(4,1), '.k', 'markersize',20)
colormap(color_lava([1:256]/300))
h.LineWidth = 2;
savefig('profiles_Li_kM')
print -r0 -dpng  profiles_Li_kM
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);
set(gca, 'FontSize', 15, 'Box', 'on')

figure()
[~,h] = contour(X_g_kM, Y_g_kM, FSB_g_kM', [Fc_SB Fc_SB]);
xlabel('energy investment ratio of female g_f, -')
ylabel('maintenance rate coeffient k_M, 1/d')
hold on
plot(par_0(4,1), par_0(5,1), '.k', 'markersize',20)
colormap(color_lava([1:256]/300))
h.LineWidth = 2;
savefig('profiles_g_kM')
print -r0 -dpng  profiles_g_kM
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.75, 0, 0.25, 0.5]);
set(gca, 'FontSize', 15, 'Box', 'on')

end



