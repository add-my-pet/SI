function Kooy2024_SI(fig)
% Supporting Information for Kooy2024
% Title: Ways to reduce or avoid juvenile-driven cycles in IBM's
% Authors: Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2023/12/03
% 
% Matlab scripts to generate the figures in the publication
%
% To run the scripts you need
% 1) Matlab (the student or Home version will suffice)
% 2) Copy DEBtool from http://www.github.com/add-my-pet/DEBtool_M/ in a directory, set the path in Matlab to this directory.
% 3) Download NetLogo from https://ccl.northwestern.edu/netlogo/ (I used version 6.2.0), and set a path to it
% 4) Download Java from https://www.java.com/nl/download/ie_manual.jsp and set a path to it
% 5) Download a C-compiler and set a path to it; the EBT code is already included in DEBtool_M/popDyn/EBTtool.
%    I used MinGW from https://ics.uci.edu/~pattis/common/handouts/mingweclipse/mingw.html
% The various IBM models are in DEBtool_M/popDyn/IBMnlogo
%
% Set Path in Matlab is in the toolbar of the Command Window of Matlab if full-screen.
% The code changes directories and returns to the original after successfull completion.
% If it got stuck, however, you need to return to the original directory yourself.
% For this reason I advice to start the Matlab session with "WD=pwd;" to later use "cd(WD)" to return, if necessary.
% Load this file in the Matlab Editor
% To run the code for a figure: type in the Matlab window e.g. Kooy2024_SI(2)
%
% Remark:
% This file assumes that you run NetLogo under Matlab (the last input in the call to IBM is 1).
% Although IBM allows to run the code directly under NetLogo, a few simple changes are required in this file.
%
% Example of use:
% Kooy2024_SI(3)

    close all

    if ~exist('fig','var')
      fig = 1;
    end

    % Set reactor pars
    my_pet = 'Daphnia_magna'; % a random species from the AmP collection
    tJX = 0.001; % mol/d, food input into reactor
    V_X = 1; % L, volume of reactor
    h = [.1 1e-35 5e-4 5e-4 0]; 
      % 1/d, hazard rates [h_X, h_B0b, h_Bbp, h_Bpi, thin]
    t_max = 180; % d, max run time
    tickRate = 24;
    numPar = [];

    path = [set_path2server, 'add_my_pet/entries/', my_pet, '/']; results = ['results_', my_pet, '.mat']; 
    if ismac || isunix
      system(['wget -O results.mat ', path, results]);
    else
      system(['powershell wget -O results.mat ', path, results]);
    end
    load('results', 'metaData', 'metaPar', 'par', 'txtPar');
    close all
 
 switch fig % IBM std, only for checking code
   case 0 % juvenile-driven cycles from DEB2023
    
    % run std
    txN_IBM = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);
    
    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN_IBM(:,1),txN_IBM(:,2),'r', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_IBM.png')
 
    figure % numbers
    plot(txN_IBM(:,1),txN_IBM(:,3),'r', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_IBM.png')
 
    figure % biomass
    plot(txN_IBM(:,1),txN_IBM(:,7),'r', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_IBM.png')
     
   case 1 %  Fig 1: ref, IBM compared with EBT

     metaPar.model = 'stdadlt'; % like std, but adults are also counted separately
     data = {metaData, metaPar, par, txtPar};

     % run std in IBM and EBT
     txN_IBM = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);
     txN_EBT = EBT(my_pet,[],tJX,[],V_X,h,t_max,numPar);
    
     % plot
     title_txt = 'IBM {\it vs} EBT';

     figure % food
     plot(txN_IBM(:,1),txN_IBM(:,2),'r',  txN_EBT(:,1),txN_EBT(:,2),'b', 'linewidth',2)
     xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
     set(gca, 'FontSize', 15, 'Box', 'on'); 
     %saveas (gca, 't_x_ref.png')
 
     figure % numbers
     plot(txN_IBM(:,1),txN_IBM(:,3),'r', txN_IBM(:,1),txN_IBM(:,4),'m', txN_EBT(:,1),txN_EBT(:,3),'b', 'linewidth',2)
     xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
     set(gca, 'FontSize', 15, 'Box', 'on'); 
     %saveas (gca, 't_N_ref.png')
 
     figure % biomass
     plot(txN_IBM(:,1),txN_IBM(:,8),'r', txN_EBT(:,1),txN_EBT(:,7),'b', 'linewidth',2) % mass in here in col 8
     xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
     set(gca, 'FontSize', 15, 'Box', 'on'); 
     %saveas (gca, 't_W_ref.png')
 
     hleg = shllegend({{'-',2,[1 0 0]},'IBM';{'-',2,[0 0 1]},'EBT'});
     %saveas (hleg, 'legend_ref.png')
    
  case 2 % Fig 2: thin, effects of thinning
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % thinning
    h(end) = 1; % apply thinning
    txN_thin = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);
   
    % plot
    title_txt = 'thinning';

    figure % food
    plot(txN(:,1),txN(:,2),'r',  txN_thin(:,1),txN_thin(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_thin.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_thin(:,1),txN_thin(:,3),'b', txN_thin(:,1),txN_thin(:,4),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_thin.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txN_thin(:,1),txN_thin(:,8),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_thin.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no thinning';{'-',2,[0 0 1]},'thinning'});
    %saveas (hleg, 'legend_ref.png')

  case 3 % Fig 3: rdn, effects of scatter in E_Hp and p_M
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % scatter
    metaPar.model = 'stdrnd';
    data = {metaData, metaPar, par, txtPar};
    txN_rnd = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);
   
    % plot
    title_txt = 'scatter in E_H^p, [p_M]';

    figure % food
    plot(txN(:,1),txN(:,2),'r',  txN_rnd(:,1),txN_rnd(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_rnd.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_rnd(:,1),txN_rnd(:,3),'b', txN_rnd(:,1),txN_rnd(:,4),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_rnd.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txN_rnd(:,1),txN_rnd(:,8),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_rnd.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no scatter';{'-',2,[0 0 1]},'scatter'});
    %saveas (hleg, 'legend_ref.png')

  case 4 % Fig 4: migr, effects of immigration
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % immigration
    metaPar.model = 'stdmigr';
    % h = [.1 1e-35 5e-4 5e-4 0]; % 1/d, hazard rates [h_X, h_B0b, h_Bbp, h_Bpi, thin]
    par.h_migr = 0.1; h(4) = 0.1;
    data = {metaData, metaPar, par, txtPar};
    txN_migr = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % plot
    title_txt = 'immigration';

    figure % food
    plot(txN(:,1),txN(:,2),'r', txN_migr(:,1),txN_migr(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_migr.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_migr(:,1),txN_migr(:,3),'b', txN_migr(:,1),txN_migr(:,4),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_migr.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txN_migr(:,1),txN_migr(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_migr.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no migration';{'-',2,[0 0 1]},'migration'});
    %saveas (hleg, 'legend_ref.png')

  case 5 % Fig 5: osc, effects of oscillating input      
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % tJX spline
    JX = 2*0.001; % mol/d, food input into reactor; 2 times the previous value, because input is zero for half of the time
    % switching instantaneously between input JX and zero after time interval dt
    dt = 3; n = ceil(t_max/dt); t = (0:n)*dt; t = [t;t]; t=t(:); t(1)=[]; 
    n=1+ceil(n/2); JX = [JX*ones(2,n);zeros(2,n)]; JX=JX(:); JX(end)=[]; tJX = [t,JX(1:length(t))]; 
    txN_osc = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);
   
    % plot
    title_txt = 'pulsed food input';

    figure % food
    plot(txN(:,1),txN(:,2),'r',  txN_osc(:,1),txN_osc(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_osc.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_osc(:,1),txN_osc(:,3),'b', txN_osc(:,1),txN_osc(:,4),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_osc.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txN_osc(:,1),txN_osc(:,8),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_osc.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no oscillation';{'-',2,[0 0 1]},'oscillation'});
    %saveas (hleg, 'legend_osc.png')

  case 6 % Fig 6: slp, effects of sleep
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % sleep; check with case 9 that k_Y is low enough to avoid that 
    %   e can become larger than e without sleep for low f
    metaPar.model = 'stdslp';
    par.k_Y = 90; % mol/d^2.cm^3, 1/duration of sleep at max respiration density
    par.F_Y = 10; % L/d, sleep frequency
    data = {metaData, metaPar, par, txtPar};
    txN_slp = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % plot
    title_txt = 'sleep';

    figure % food
    plot(txN(:,1),txN(:,2),'r', txN_slp(:,1),txN_slp(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_slp.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_slp(:,1),txN_slp(:,3),'b', txN_slp(:,1),txN_slp(:,4),'c',  'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_slp.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txN_slp(:,1),txN_slp(:,8),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_slp.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no sleep';{'-',2,[0 0 1]},'sleep'});
    %saveas (hleg, 'legend_ref.png')

  case 7 % Fig 7: soc, effects of socialisation
    %t_max = 5 * t_max;  
      
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % socialisation
    metaPar.model = 'stdsoc';
    par.k_Y = 80;  % 1/d, 1/duration of an interaction
    par.F_Y = 8; % L/d, encounter frequency
    data = {metaData, metaPar, par, txtPar};
    txN_soc = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % plot
    title_txt = 'socialisation';

    figure % food
    plot(txN(:,1),txN(:,2),'r', txN_soc(:,1),txN_soc(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_soc.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_soc(:,1),txN_soc(:,3),'b', txN_soc(:,1),txN_soc(:,4),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_soc.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txN_soc(:,1),txN_soc(:,8),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_soc.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no socialisation';{'-',2,[0 0 1]},'socialisation'});
    %saveas (hleg, 'legend_ref.png')

  case 8 % Fig 8: 211, effects of 2 types of food with preference
    % t_max = 5 * t_max;

    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % set extra pars
    metaPar.model = 'std211';
    h211 = [.1 .1 1e-35 5e-4 5e-4 0]; % 1/d, hazard rates [h_X1, h_X2, h_B0b, h_Bbp, h_Bpi, thin]
    tJX1 = 0.0005; tJX2 = 0.001; % mol/d, food input into reactor
    par.mu_X1 = par.mu_X;   % J, chemical potential of food 1
    par.mu_X2 = par.mu_X;   % J, chemical potential of food 2
    par.kap_X1 = 0.9;       % -, digestion efficiency for food 1
    par.kap_X2 = 0.4;       % -, digestion efficiency for food 2
    X1_0 = 0; X2_0 = 0; % Mol, initial densities of food 1, 2

    % run std211
    data = {metaData, metaPar, par, txtPar};
    txxN_211 = IBM211(data,[],tJX1,tJX2,X1_0,X2_0,V_X,h211,[],t_max,tickRate,1);

    % plot
    title_txt = '2 food types';

    figure % food
    plot(txN(:,1),txN(:,2),'r',  ...
        txxN_211(:,1),txxN_211(:,2),'b', ...
        txxN_211(:,1),txxN_211(:,3),'k','linewidth',2)
    xlabel('time, d'); ylabel('scaled food densities X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_211.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txxN_211(:,1),txxN_211(:,4),'b', txxN_211(:,1),txxN_211(:,5),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_211.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,8),'r', txxN_211(:,1),txxN_211(:,9),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_211.png')

    hleg = shllegend({{'-',2,[1 0 0]},'1 food type';
                      {'-',2,[0 0 1]},'2 types, high quality';
                      {'-',2,[0 0 0]},'2 types, low quality'});
    %saveas (hleg, 'legend_ref.png')
   
  case 9 % sleeping at ind level; selected copy-paste from stdslp.nlogo to test Java code

    vars_pull(par); vars_pull(parscomp_st(par)); 
    k_Y = 90; % mol/d^2.cm^3, 1/duration of sleep at max respiration density
    F_Y = 10; % L/d, sleep frequency
    J_XAm = p_Am/ kap_X/ mu_X; % mol/d.cm^2, spec food intake
    J_EAm = p_Am/ mu_E; % mol/d.cm^2, spec assim rate
    f = 0.99; % -, scaled func response
    t = linspace(0,50,100); % d, time
    L_b = L_m * get_lb([g k v_Hb], f); % cm, struc length at birth
    [t, HeL] = ode45(@get_dHeL, t, [E_Hb, 0.9*f, L_b], [], f, K, J_EAm, F_m, F_Y, k_Y, E_Hp, p_Am, p_M, g, v, kap, kap_R, k_J, kap_X, mu_X, mu_E);
    
    figure % reserve density
    plot(t,f*ones(100,1),'r', t,HeL(:,2),'b', 'linewidth',2)
    xlabel('time since birth, d'); ylabel('scaled reserve density, e');
    set(gca, 'FontSize', 15, 'Box', 'on'); 

    figure % struc length
    plot(t, f*L_m-(f*L_m-L_b)*exp(-t*k_M/3/(1+f/g)),'r', t,HeL(:,3),'b', 'linewidth',2)
    xlabel('time since birth, d'); ylabel('structural length, L');
    set(gca, 'FontSize', 15, 'Box', 'on'); 

  case 10 % HuisWeis1999: paradox of the plankton
    % the units of resource and algal densities are unclear
 
    % parameters all from HuisWeis1999
    r = ones(6,1); % 1/d, max growth rate
    D = 0.25; % 1/d, dilution rate
    m = D * ones(6,1); % 1/d, mortality rates
    S = [6 10 14]'; % resource supply densities
    K = [1.00 0.90 0.30 1.04 0.34 0.77  % half saturation coeff
         0.30 1.00 0.90 0.71 1.02 0.76
         0.90 0.30 1.00 0.46 0.34 1.07];
    C = [0.04 0.07 0.04 0.10 0.03 0.02 % resource per biomass
         0.08 0.08 0.10 0.10 0.05 0.17
         0.14 0.10 0.10 0.16 0.06 0.14];
  
    R0 = S; % initial resource density
    N0 = [0.11 0.12 0.13 0 0 0]'; % algal density at t=0
    RN0 = [R0; N0];
 
    % trajectories
    [t0, RN01] = ode45(@get_RN, [0;1000], RN0, [], D, S, r, K, C, m); 
    RN1 = RN01(end,:); RN1(7) = 0.1;
    [t1, RN12] = ode45(@get_RN, [1000;2000], RN1, [], D, S, r, K, C, m);
    RN2 = RN12(end,:); RN2(8) = 0.1;
    [t2, RN23] = ode45(@get_RN, [2000;5000], RN2, [], D, S, r, K, C, m);
    RN3 = RN23(end,:); RN3(9) = 0.1;
    [t3, RN34] = ode45(@get_RN, [5000;15000], RN3, [], D, S, r, K, C, m);
    t = [t0;t1;t2;t3]; RN = [RN01;RN12;RN23;RN34];  N = RN(:,4:9);
    %
    [t0, RN01] = ode45(@get_RN_SU, [0;1000], RN0, [], D, S, r, K, C, m); 
    RN1 = RN01(end,:); RN1(7) = 0.1;
    [t1, RN12] = ode45(@get_RN_SU, [1000;2000], RN1, [], D, S, r, K, C, m);
    RN2 = RN12(end,:); RN2(8) = 0.1;
    [t2, RN23] = ode45(@get_RN_SU, [2000;5000], RN2, [], D, S, r, K, C, m);
    RN3 = RN23(end,:); RN3(9) = 0.1;
    [t3, RN34] = ode45(@get_RN_SU, [5000;15000], RN3, [], D, S, r, K, C, m);
    t_SU = [t0;t1;t2;t3]; RN = [RN01;RN12;RN23;RN34];  N_SU = RN(:,4:9);
    %
    Rmumu = get_mu(linspace(1e-3,10,100)', 1e8, 1, r, K); % get spec growth rate

    % plotting
    figure % as in HuisWeis1999
    plot(t,N(:,1),'r', t,N(:,2),'g', t,N(:,3),'y', t,N(:,4),'b', t,N(:,5),'m', t,N(:,6),'c')
    xlabel('time, d'); ylabel('species abundance');
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_HuisWeis1999.png')
    %
    figure % SU equivalent
    plot(t_SU,N_SU(:,1),'r', t_SU,N_SU(:,2),'g', t_SU,N_SU(:,3),'y', t_SU,N_SU(:,4),'b', t_SU,N_SU(:,5),'m', t_SU,N_SU(:,6),'c', 'linewidth',2)
    xlabel('time, d'); ylabel('species abundance');
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_SU.png')
    % 
    figure % spec growth rate as function of resource R1, R2 = 1e8; R3 = 1
    plot(Rmumu(:,1),Rmumu(:,2),'r', Rmumu(:,1),Rmumu(:,3),'b', 'linewidth',2)
    xlabel('resource 1'); ylabel('spec growth rate, 1/d');
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 'R_mu.png')
  end    
end
 
% subfunctions
function dHeL = get_dHeL (t, HeL, f, K, J_EAm, F_m, F_Y, k_Y, E_Hp, p_Am, p_M, g, v, kap, kap_R, k_J, kap_X, mu_X, mu_E)
    persistent L_p
    E_H = HeL(1); e = HeL(2); L = HeL(3); 
    
    L_m = kap * p_Am/ p_M; % cm, max struc length
    E_m = p_Am/ v; % J/cm^3, max reserve density 
    X = K/ (1.000001 - f);
    % f = X/ (K + X); -, scaled functional response

    r = v * (e / L - 1 / L_m) / (e + g) ; % 1/d, positive spec growth rate
    p_C = e * E_m * L * L * L * (v / L - r) ; % J/d, reserve mobilisation rate
    dE_H = (1 - kap) * p_C - k_J * E_H ; % J/d, change in maturation

    p_A = p_M * f * L_m / kap / L; % J/d.cm^3, vol-spec assim rate
    if E_H < E_Hp
      L_p = L; 
      p_D = p_M * (1 + (1 - kap) / kap * e * (g * L_m / L + 1) / (g + e)) ; % J/d.cm^3, vol-spec dissipation rate
    else
      p_D = p_M * (1 + (1 - kap) / kap * (kap_R * (L_p / L) ^ 3 + (1 - kap_R) * e * (g * L_m / L + 1) / (g + e))) ; % J/d.cm^3, vol-spec dispation rate
    end
    p_G = p_M * (e * L_m / L - 1) / (e / g + 1) ; % J/d.cm^3, vol-spec growth rate
    J_O = (0.0198 * p_A + 0.1977 * p_D + 0.0012 * p_G) ; % mol/d.cm^3, vol-spec O2 consumption rate
    %k_E = J_XAm * L * L ; % dissociation rate of E with SU
    k_E = J_EAm * L * L ; % dissociation rate of E with SU
    b_X = mu_X/ mu_E * kap_X * X * F_m * L * L ; % association rate of X with SU
    b_Y = F_Y ; % association rate of sleep with SU
    k_YO = k_Y / J_O ; % dissociation rate of sleep with SU
    th_X = 1 / (1 + k_E / b_X + b_Y * k_E / b_X / k_YO + b_Y / (k_E + k_YO) * (1 + k_E / k_YO + k_E / b_X + k_E * b_Y / k_YO / b_X));
    % J_X =  th_X * (k_E + b_Y * k_E / (k_E + k_YO)) ; % Mol/d, food consumption
    de = (th_X * (1 + b_Y / (k_E + k_YO)) - e) * v / L ; % 1/d, change in scaled reserve density
 
    dL = L * r / 3 ; % cm/d, change in structural length
    
    dHeL = [dE_H; de; dL];
end

function dRN = get_RN(t, RN, D, S, r, K, C, m)
  nR = size(K,1); % number of resources
  nN = size(K,2); % number of species
  R = RN(1:nR); N = RN(nR+(1:nN)); 

  mu = min(R*r'./(K+R(:,ones(1,nN))),[], 1)'; % 1/d
  dR = D * (S - R) - C * (mu .* N);
  dN = N .* (mu - m);
  dRN = [dR; dN];
end

function dRN = get_RN_SU(t, RN, D, S, r, K, C, m)
  nR = size(K,1); % number of resources = 3
  nN = size(K,2); % number of species
  R = RN(1:nR); N = RN(nR+(1:nN)); 

  x = R(:,ones(1,nN)) ./ K; % scaled resources
  mu = r./(1+sum(1./x,1)'- 1./sum(x([1 2],:),1)'- 1./sum(x([1 3],:),1)'- 1./sum(x([2 3],:),1)'+ 1./sum(x,1)');
  dR = D * (S - R) - C * (mu .* N);
  dN = N .* (mu - m);
  dRN = [dR; dN];
end

function Rmumu = get_mu(R1, R2, R3, r, K)
  nR = size(K,1); % number of resources = 3
  nN = size(K,2); % number of species

  n = length(R1); mu_SU = zeros(n,nN); mu_Lieb = zeros(n,nN);
  for i=1:n
    R = [R1(i); R2; R3]; % resources
    x = R(:,ones(1,nN)) ./ K; % scaled resources
    mu_SU(i,:) = r./(1+sum(1./x,1)'- 1./sum(x([1 2],:),1)'- 1./sum(x([1 3],:),1)'- 1./sum(x([2 3],:),1)'+ 1./sum(x,1)');
    mu_Lieb(i,:) = min(R*r'./(K+R(:,ones(1,nN))),[], 1)'; % scaled resources
  end
  Rmumu = [R1,mu_Lieb(:,1), mu_SU(:,1)];
end 

function [txxNL23W, info] = IBM211(species, tT, tJX1, tJX2, X1_0, X2_0, V_X, h, t_R, t_max, tickRate, runNetLogo)
% created 2023/12/12 by Bas Kooijman

%% Syntax
% txNL23W = <../IBM211.m *IBM211*> (species, tT, tJX1, tJX1, X1_0, X2_0, V_X, h, t_R, t_max, tickRate, runNetLogo) 
% h: optional vector with dilution and background hazards for each stage (depending on the model) and boolean for thinning
%     Default value for the std model: [h_X1, h_X2, h_B0b, h_Bbp, h_Bpi, thin] = [0 0 0 0 0 0]

%% Description
% Like IBM, but for 2 types of food and only for the std model; juveniles only consume type 1, adults types 1 & 2 

WD = cdIBMnlogo;

model = 'stdpref'; % only works for the std model

% make sure that results of previous runs are removed (NetLogo deletes existing txNL23W.txt file)
if exist('spline_TC.txt', 'file')==2
  delete('spline_TC.txt');
end
if exist('spline_JX1.txt', 'file')==2
  delete('spline_JX1.txt');
end
if exist('spline_JX2.txt', 'file')==2
  delete('spline_JX2.txt');
end
if exist('eaLE.txt', 'file')==2
  delete('eaLE.txt');
end

if ~exist ('runNetLogo', 'var') || isempty(runNetLogo)
  runNetLogo = true;
end

if ~exist ('t_R', 'var') || isempty(t_R)
  t_R = 0;
end

if ~exist ('tickRate', 'var') || isempty(tickRate)
  tickRate = 24;
end

% get core parameters (2 possible routes for getting pars), species and model
if iscell(species) 
  metaData = species{1}; metaPar = species{2}; par = species{3};  txtPar = species{4}; 
  species = metaData.species; info = 1;
  datePrintNm = ['date: ',datestr(date, 'yyyy/mm/dd')];
else  % use allStat.mat as parameter source 
  [par, metaPar, txtPar, metaData, info] = allStat2par(species);
  if info == 0
    fprintf('Species not recognized\n');
    txxNL23W = []; return
  end
  datePrintNm = ['allStat version: ', datestr(date_allStat, 'yyyy/mm/dd')];
end
par.reprodCode = metaData.ecoCode.reprod{1};
par.genderCode = metaData.ecoCode.gender{1};
model = metaPar.model;

% unpack par and compute compound pars
vars_pull(par); vars_pull(parscomp_st(par)); 

% time to be simulated
if ~exist('t_max','var') || isempty(t_max)
  t_max = 150*365; % -, total simulation time
end

% temperature
if ~exist('tT','var') || isempty(tT) 
  T = metaData.T_typical; tT = [0 T; t_max*1.1 T];
elseif size(tT,2) == 2 && tT(1,1) == 0 && ~(tT(end,1) < t_max)
  tT = [tT; t_max*1.1 tT(end,2)];
elseif size(tT,1) == 1
  T = tT; tT = [0 T; t_max*1.1 T];   
end

% volume of reactor
if ~exist('V_X','var') || isempty(V_X)
  V_X = 1e2 * L_m^3; % cm^3, volume of reactor
end

% supply food 
if ~exist('tJX1','var') || isempty(tJX1)
  J_X1 = 75 * J_X_Am * L_m^2 ;
  tJX1 = [0 J_X1; t_max*1.1 J_X1]; 
elseif size(tJX1,2) == 1
  tJX1 = [0 tJX1; t_max*1.1 tJX1]; 
end
if tJX1(1,1) > 0
  tJX1 = [0 tJX1(1,2); tJX1];
end
if tJX1(end,1) <= t_max
  tJX1 = [tJX1; t_max*1.1 tJX1(end,2)];    
end
%
if ~exist('tJX2','var') || isempty(tJX2)
  J_X2 = 75 * J_X_Am * L_m^2 ; % J_X_Am is kept fixed
  tJX2 = [0 J_X2; t_max*1.1 J_X2]; 
elseif size(tJX2,2) == 1
  tJX2 = [0 tJX2; t_max*1.1 tJX2]; 
end
if tJX2(1,1) > 0
  tJX2 = [0 tJX2(1,2); tJX2];
end
if tJX2(end,1) <= t_max
  tJX2 = [tJX2; t_max*1.1 tJX2(end,2)];    
end

% initial food density
if ~exist('X1_0','var') || isempty(X1_0)
  X1_0 = 0; % -, X1 at t=0
end
%
if ~exist('X2_0','var') || isempty(X2_0)
  X2_0 = 0; % -, X2 at t=0
end

% account for male production
if strcmp(reprodCode(1), 'O') && strcmp(genderCode(1), 'D')
  par.fProb = 0.5;  % probability of embryo to be female
else
  par.fProb = 0.999; % probability of embryo to be female   
end

% rejuvenation parameters
if ~isfield('par', 'k_JX')
  k_JX = k_J/ 100; par.k_JX = k_JX;
end
if ~isfield('par', 'h_J')
  h_J = 1e-4; par.h_J = h_J;
end

% hazard rates, thinning
if ~exist('h','var') || isempty(h)
  h_X1 = 0.1; h_X2 = 0.1; thin = 0; 
else
  h_X1 = h(1); h_X2 = h(2); thin = h(end);
end
par.h_X1 = h_X1; par.h_X2 = h_X2; par.thin = thin; 

    if ~exist('h','var') || isempty(h)
      h_B0b = 1e-35; h_Bbp = 1e-35; h_Bpi = 1e-35; 
    else
      h_B0b = h(3); h_Bbp = h(4); h_Bpi = h(5);       
    end
    par.h_B0b = h_B0b; par.h_Bbp = h_Bbp; par.h_Bpi = h_Bpi; 

% get trajectories
txxNL23W = get_IBMnlogo_std211(model, par, tT, tJX1, tJX2, X1_0, X2_0, V_X, t_R, t_max, tickRate, runNetLogo);

cd(WD);

if runNetLogo

%% plotting
close all
title_txt = [strrep(species, '_', ' '), ' ', datePrintNm];
%
figure(1)
plot(txxNL23W(:,1), txxNL23W(:,2), 'k', txxNL23W(:,1), txxNL23W(:,3), 'b','Linewidth', 2)
title(title_txt);
xlabel('time, d');
ylabel('scaled food densities X1/K, X2/K, -');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(2)
plot(txxNL23W(:,1), txxNL23W(:,4), 'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('# of individuals, #/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(3)
plot(txxNL23W(:,1), txxNL23W(:,5),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total structural length, cm/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(4)
plot(txxNL23W(:,1), txxNL23W(:,6),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total structural surface area, cm^2/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(5)
plot(txxNL23W(:,1), txxNL23W(:,7),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total structural volume, cm^3/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(6)
plot(txxNL23W(:,1), txxNL23W(:,8),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total wet weight, g/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(7)
plot(txxNL23W(:,1), txxNL23W(:,8)./txxNL23W(:,4), 'k', 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('mean wet weight per individual, g');
set(gca, 'FontSize', 15, 'Box', 'on')

else % runNetLogo=0: Netlogo is run from its gui
  fprintf('Load DEBtool_M/popDyn/IBMnlogo/%s.nlogo into Netlogo (dropdown "File>Open"), edit and press "go"\n',model);
end

%% report_my_pet.html

fileName = ['report_', species, '.html']; metaPar.model = 'std';
prt_report_my_pet({par, metaPar, txtPar, metaData}, [], [], [], [], fileName);
web(fileName,'-browser') % open html in systems browser

%%  IBMnlogo_my_pet.html

fileName = ['IBMnlogo_', species, '.html'];
oid = fopen(fileName, 'w+'); % open file for writing, delete existing content

fprintf(oid, '<!DOCTYPE html>\n');
fprintf(oid, '<HTML>\n');
fprintf(oid, '<HEAD>\n');
fprintf(oid, '  <TITLE>IBM %s</TITLE>\n', strrep(species, '_', ' '));
fprintf(oid, '  <style>\n');
fprintf(oid, '    .newspaper {\n');
fprintf(oid, '      column-count: 3;\n');
fprintf(oid, '      height: 500px;\n');
fprintf(oid, '    }\n\n');

fprintf(oid, '    div.temp {\n');
fprintf(oid, '      width: 100%%;\n');
fprintf(oid, '    }\n\n');

fprintf(oid, '    div.par {\n');
fprintf(oid, '      width: 100%%;\n');
fprintf(oid, '      padding-bottom: 100px;\n');
fprintf(oid, '    }\n\n');

fprintf(oid, '    .head {\n');
fprintf(oid, '      background-color: #FFE7C6\n');                  % pink header background
fprintf(oid, '    }\n\n');

fprintf(oid, '    #par {\n');
fprintf(oid, '      border-style: solid hidden solid hidden;\n');   % border top & bottom only
fprintf(oid, '    }\n\n');

fprintf(oid, '    tr:nth-child(even){background-color: #f2f2f2}\n');% grey on even rows
fprintf(oid, '  </style>\n');
fprintf(oid, '</HEAD>\n\n');
fprintf(oid, '<BODY>\n\n');

fprintf(oid, '  <div>\n');
fprintf(oid, '  <h1>%s</h1>\n', strrep(species, '_', ' '));
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  <div class="newspaper">\n');
fprintf(oid, '  <div class="par">\n');

% Table with DEB parameters

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"><TH>symbol</TH> <TH>units</TH> <TH>value</TH>  <TH>description</TH> </TR>\n');
fprintf(oid, '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%s</TD> <TD>%s</TD></TR>\n', 'model', '-', model, 'model type');
fprintf(oid, '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%s</TD> <TD>%s</TD></TR>\n', 'reprodCode', '-', reprodCode, 'ecoCode reprod');
fprintf(oid, '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%s</TD> <TD>%s</TD></TR>\n\n', 'genderCode', '-', genderCode, 'ecoCode gender');

       str = '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%3.4g</TD> <TD>%s</TD></TR>\n';
fprintf(oid, str, 'k_JX', '1/d', k_JX, 'rejuvenation rate');
fprintf(oid, str, 'h_J', '1/d', h_J, 'hazard rate for rejuvenation');
fprintf(oid, str, 'h_X1', '1/d', h_X1, 'hazard rate for food 1 from reactor');
fprintf(oid, str, 'h_X2', '1/d', h_X2, 'hazard rate for food 2 from reactor');
fprintf(oid, str, 'thin', '-', thin, 'boolean for thinning');
switch model
  case {'std','stf','sbp','abp'}
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbp', '1/d', h_Bbp, 'background hazard rate from b to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'stx'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbx', '1/d', h_Bbx, 'background hazard rate from b to x');
      fprintf(oid, str, 'h_Bxp', '1/d', h_Bxp, 'background hazard rate from x to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'ssj'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbs', '1/d', h_Bbs, 'background hazard rate from b to s');
      fprintf(oid, str, 'h_Bsp', '1/d', h_Bsp, 'background hazard rate from s to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'abj'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbj', '1/d', h_Bbj, 'background hazard rate from b to j');
      fprintf(oid, str, 'h_Bjp', '1/d', h_Bjp, 'background hazard rate from j to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'asj'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbs', '1/d', h_Bbs, 'background hazard rate from b to s');
      fprintf(oid, str, 'h_Bsj', '1/d', h_Bsj, 'background hazard rate from s to j');
      fprintf(oid, str, 'h_Bjp', '1/d', h_Bjp, 'background hazard rate from j to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
end
fprintf(oid, str, 'X1_0', 'mol/L', X1_0, 'initial food 1 density');
fprintf(oid, str, 'X2_0', 'mol/L', X2_0, 'initial food 2 density');
fprintf(oid, str, 'V_X', 'L', V_X, 'volume of reactor');
fprintf(oid, str, 't_max', '-', t_max, 'maximum integration time');

fprintf(oid, '  </TABLE>\n'); % close prdData table
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  <div class="par">\n');

% Table with knots for temperature

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"> <TH>Knots for<br>temperature</TH> <TH>units<br>&deg;C</TH> </TR>\n');
n_T = size(tT,1);
if n_T == 1
    tT = [0 tT; 1 tT]; n_T = 2;
end
for i=1:n_T
  fprintf(oid, '    <TR><TD>%3.4g</TD> <TD>%3.4g</TD></TR>\n', tT(i,1), K2C(tT(i,2)));
end
fprintf(oid, '  </TABLE>\n');
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  <div class="par">\n');

% Table with knots for food 1 input

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"> <TH>Knots for<br>food 1 supply</TH> <TH>units<br>mol/d</TH> </TR>\n');
n_JX1 = size(tJX1,1);
if n_JX1 == 1
  tJX1 = [0 tJX1; 1 tJX1]; n_JX1 = 2;
end
for i=1:n_JX1
  fprintf(oid, '    <TR><TD>%3.4g</TD> <TD>%3.4g</TD></TR>\n', tJX1(i,1), tJX1(i,2));
end
fprintf(oid, '  </TABLE>\n');
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  </TABLE>\n'); % close numPar table
fprintf(oid, '  </div>\n\n');
fprintf(oid, '  </div>\n\n'); % end div newspaper

fprintf(oid, '</BODY>\n');
fprintf(oid, '</HTML>\n');

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"> <TH>Knots for<br>food 2 supply</TH> <TH>units<br>mol/d</TH> </TR>\n');
n_JX2 = size(tJX2,1);
if n_JX2 == 1
  tJX2 = [0 tJX2; 1 tJX2]; n_JX2 = 2;
end
for i=1:n_JX2
  fprintf(oid, '    <TR><TD>%3.4g</TD> <TD>%3.4g</TD></TR>\n', tJX2(i,1), tJX2(i,2));
end
fprintf(oid, '  </TABLE>\n');
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  </TABLE>\n'); % close numPar table
fprintf(oid, '  </div>\n\n');
fprintf(oid, '  </div>\n\n'); % end div newspaper

fprintf(oid, '</BODY>\n');
fprintf(oid, '</HTML>\n');

fclose(oid);

web(fileName,'-browser') % open html in systems browser

end
