function Kooy2023_SI(fig)
% Supporting Information for Kooy2023
% Title: Ways to reduce or avoid juvenile-driven cycles in IBM's
% Authors: Kooijman and others
% Journal: Ecol. Mod
% DOI: 
% Date: 2023/12/03
% 
% Matlab scripts to generate the figures in the publication
%
% To run the scripts you need
% 1) Matlab (the student or Home version will suffice)
% 2) Download AmPdata from http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/
%    Goto AmPdata in dropdown "COLLECTION", unpack the zip-file, save the 2 .mat-files in a directory, set the path in Matlab to this directory.
% 3) Copy DEBtool from http://www.github.com/add-my-pet/DEBtool_M/ in a directory, set the path in Matlab to this directory.
% 4) Copy AmPtool from http://www.github.com/add-my-pet/AmPtool/ in a directory, set the path in Matlab to this directory.
%
% Set Path in Matlab is in the toolbar of the Command Window of Matlab if full-screen
% Load this script-file in the Matlab Editor
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2022_SI(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

close all

if ~exist('fig','var')
   fig = 1:2;
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

for i=1:length(fig)
 
 switch fig(i)
   case 1 %  Fig 1: juvenile-driven cycles from DEB2023
    
    % run std in IBM and EBT
    txN_IBM = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);
    txN_EBT = EBT(my_pet,[],tJX,[],V_X,h,t_max,numPar);
    
    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN_IBM(:,1),txN_IBM(:,2),'r',  txN_EBT(:,1),txN_EBT(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_ref.png')
 
    figure % numbers
    plot(txN_IBM(:,1),txN_IBM(:,3),'r', txN_EBT(:,1),txN_EBT(:,3),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_ref.png')
 
    figure % biomass
    plot(txN_IBM(:,1),txN_IBM(:,7),'r', txN_EBT(:,1),txN_EBT(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_ref.png')
 
    hleg = shllegend({{'-',2,[1 0 0]},'IBM';{'-',2,[0 0 1]},'EBT'});
    %saveas (hleg, 'legend_ref.png')
    
  case 2 % Fig 2: effects of thinning
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % thinning
    h(end) = 1; % apply thinning
    txN_thin = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);
   
    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN(:,1),txN(:,2),'r',  txN_thin(:,1),txN_thin(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    saveas (gca, 't_x_thin.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_thin(:,1),txN_thin(:,3),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    saveas (gca, 't_N_thin.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,7),'r', txN_thin(:,1),txN_thin(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    saveas (gca, 't_W_thin.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no thinning';{'-',2,[0 0 1]},'thinning'});
    %saveas (hleg, 'legend_ref.png')

  case 3 % Fig 3: effects of scatter in E_Hp and p_M
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % scatter
    metaPar.model = 'stdrnd';
    data = {metaData, metaPar, par, txtPar};
    txN_rnd = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);
   
    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN(:,1),txN(:,2),'r',  txN_rnd(:,1),txN_rnd(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_rnd.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_rnd(:,1),txN_rnd(:,3),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_rnd.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,7),'r', txN_rnd(:,1),txN_rnd(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_rnd.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no scatter';{'-',2,[0 0 1]},'scatter'});
    %saveas (hleg, 'legend_ref.png')

  case 4 % Fig 4: effects of immigration
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % immigration
    metaPar.model = 'stdmigr';
    % h = [.1 1e-35 5e-4 5e-4 0]; % 1/d, hazard rates [h_X, h_B0b, h_Bbp, h_Bpi, thin]
    par.h_migr = 0.1; h(4) = 0.1;
    data = {metaData, metaPar, par, txtPar};
    txN_migr = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN(:,1),txN(:,2),'r', txN_migr(:,1),txN_migr(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_migr.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_migr(:,1),txN_migr(:,3),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_migr.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,7),'r', txN_migr(:,1),txN_migr(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_migr.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no migration';{'-',2,[0 0 1]},'migration'});
    %saveas (hleg, 'legend_ref.png')

  case 5 % Fig 5: effects of oscillating input
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % tJX spline
    JX = 2*0.001; % mol/d, food input into reactor; 2 times the previous value, because input is zero for half of the time
    %tJX = [0 JX; 20 0; 40 JX; 60 0; 80 JX; 100 0; 120 JX; 140 0; 160 JX; 180 0];
    % switching instantaneously between input JX and zero after time interval dt
    dt = 3; n = ceil(t_max/dt); t = (0:n)*dt; t = [t;t]; t=t(:); t(1)=[]; 
    n=1+ceil(n/2); JX = [JX*ones(2,n);zeros(2,n)]; JX=JX(:); JX(end)=[]; tJX = [t,JX(1:length(t))]; 
    txN_osc = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);
   
    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN(:,1),txN(:,2),'r',  txN_osc(:,1),txN_osc(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    saveas (gca, 't_x_osc.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_osc(:,1),txN_osc(:,3),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    saveas (gca, 't_N_osc.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,7),'r', txN_osc(:,1),txN_osc(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    saveas (gca, 't_W_osc.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no oscillation';{'-',2,[0 0 1]},'oscillation'});
    %saveas (hleg, 'legend_osc.png')

  case 6 % Fig 6: effects of socialisation
    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % socialisation
    metaPar.model = 'stdsoc';
    par.k_Y = 20;  % 1/d, 1/duration of an interaction
    par.F_Y = 5; % L/d, encounter frequency
    data = {metaData, metaPar, par, txtPar};
    txN_soc = IBM(data,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN(:,1),txN(:,2),'r', txN_soc(:,1),txN_soc(:,2),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('scaled food density X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_soc.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txN_soc(:,1),txN_soc(:,3),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_soc.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,7),'r', txN_soc(:,1),txN_soc(:,7),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_soc.png')

    hleg = shllegend({{'-',2,[1 0 0]},'no socialisation';{'-',2,[0 0 1]},'socialisation'});
    %saveas (hleg, 'legend_ref.png')

  case 7 % Fig xx: effects of 2 types of food
    % t_max = 5 * t_max;

    % run std as ref
    txN = IBM(my_pet,[],tJX,[],V_X,h,[],t_max,tickRate,1);

    % set extra pars
    h211 = [.1 .05 1e-35 5e-4 5e-4 0]; % 1/d, hazard rates [h_X1, h_X2, h_B0b, h_Bbp, h_Bpi, thin]
    tJX1 = 0.001; tJX2 = 0.0005; % mol/d, food input into reactor
    par.mu_X1 = 525000; % J, chemical potential of food 1
    par.mu_X2 = 525000; % J, chemical potential of food 2
    par.kap_X1 = 0.8;   % -, digestion efficiency for food 1
    par.kap_X2 = 0.2;   % -, digestion efficiency for food 2
    X1_0 = 0; X2_0 = 0; % Mol, initial densities of food 1, 2

    % run std211
    data = {metaData, metaPar, par, txtPar};
    txxN_211 = IBM211(data,[],tJX1,tJX2,X1_0,X2_0,V_X,h211,[],t_max,tickRate,1);

    % plot
    title_txt = [strrep(my_pet,'_',' '), ' @ ', datestr(date,26)];

    figure % food
    plot(txN(:,1),txN(:,2),'r',  ...
        txxN_211(:,1),txxN_211(:,2),'b', ...
        txxN_211(:,1),txxN_211(:,3),'k','linewidth',2)
    xlabel('time, d'); ylabel('scaled food densities X/K, -'); title(title_txt); 
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_x_211.png')
 
    figure % numbers
    plot(txN(:,1),txN(:,3),'r', txxN_211(:,1),txxN_211(:,4),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('# of individuals, -'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_N_211.png')
 
    figure % biomass
    plot(txN(:,1),txN(:,7),'r', txxN_211(:,1),txxN_211(:,8),'b', 'linewidth',2)
    xlabel('time, d'); ylabel('total biomass, g'); title(title_txt)
    set(gca, 'FontSize', 15, 'Box', 'on'); 
    %saveas (gca, 't_W_211.png')

    hleg = shllegend({{'-',2,[1 0 0]},'1 food type';
                      {'-',2,[0 0 1]},'2 types, hight qual.';
                      {'-',2,[0 0 0]},'2 types, low qual.'});
    %saveas (hleg, 'legend_ref.png')
   
 end
end