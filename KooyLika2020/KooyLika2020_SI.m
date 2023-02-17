function KooyLika2020_SI(fig)
% Supporting Information for KooyLika2020
% Title: The energetic basis of population growth in animal kingdom
% Authors: Kooijman, Lika, Augustine, Marn, Kooi
% Journal: Ecological Modelling 428, 109055
% DOI: 10.1016/j.ecolmodel.2020.109055
% Date: 2023/02/11
% 
% Matlab scripts to generate the figures in the publication
%
% To run the scripts you need
% 1) Matlab (the student version will suffice)
% 2) Download AmPdata from http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/
%    Goto AmPdata in dropdown "COLLECTION", unpack the zip-file, save the 2 .mat-files in a directory, set the path in Matlab to this directory.
% 3) Copy DEBtool from http://www.github.com/add-my-pet/DEBtool_M/ in a directory, set the path in Matlab to this directory.
% 4) Copy AmPtool from http://www.github.com/add-my-pet/AmPtool/ in a directory, set the path in Matlab to this directory.
%
% Set Path in Matlab is in the toolbar of the Command Window of Matlab if full-screen
% Load this script-file in the Matlab Editor
% To run the code for a figure: type in the Matlab window e.g. KooyLika2020_SI(4)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "saveas" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend (here legend_RSED), see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

close all

if ~exist('fig','var')
   fig = 1:12;
end

for i=1:length(fig)
 
  switch fig(i)
    case 1 % Fig 1A
      [Rac, nm] = read_allStat('R_i', 'a_p', 'c_T'); c_T = Rac(:,3); t_p = Rac(:,2) .* c_T; R_i = Rac(:,1) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; sgr0 = sgr0(~isnan(sgr0)); % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; sgr1 = sgr1(~isnan(sgr1)); % sgr with thinning
      
      % ceiling for sgr0 given R_i and t_p
      char_eq = @(rho, rho_p) 1 + exp(- rho * rho_p) - exp(rho); % see DEB3 eq (9.22): exp(-r*a_p) = exp(r/R) - 1 
      n = length(R_i); r_max = NaN(n,1);
      for i = 1:n
        r =  R_i(i) * t_p(i);
        if char_eq(1e-9, r) > 0 && char_eq(1, r) < 0
          rho_max = nmfzero(@(rho) char_eq(rho, r), 1); 
          r_max(i) = rho_max * R_i(i); % 1/d, pop growth rate for eternal surivival and ultimate reproduction rate since puberty
        end
      end
      R_i = R_i(~isnan(R_i)); r_max = r_max(~isnan(r_max));

      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      shstat_options('default');
      shstat_options('y_label', 'on'); % if 'off' (default), no `survivor function' shown on yaxis
      Hfig1A = shstat(R_i, {'r', 'r'});  % output handle for adding items to same figure and set colors
      shstat(r_max, {'m', 'm'}, '', Hfig1A);
      shstat(sgr0, {'b', 'b'}, title, Hfig1A);
      shstat(sgr1, {'k', 'k'}, title, Hfig1A);
      xlabel('_{10}log rate, 1/d')      
      xlim([-5 10])
      
      %saveas(Hfig1A, 'Ri-rm-sgr.png')

    case 2 % Fig 1B 
      shstat_options('default');
      c_T = read_allStat('c_T'); 
      r0 = read_popStat('f1.thin0.f.r') ./ c_T; 
      r1 = read_popStat('f1.thin1.f.r') ./ c_T; 
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      [Hfig1B, Hleg1B] = shstat([r0, r1], legend_RSED, title); 
    
      figure(Hfig) 
      plot([-6.5; 0.5], [-6.5; 0.5], 'k', 'Linewidth', 2)
      xlim([-6.5 0.5]);
      ylim([-6.5 0.5]);

      ylabel('_{10}log r_N with thinning, 1/d')      
      xlabel('_{10}log r_N without thinning, 1/d')
      
      %saveas(Hfig1B, 'sgr0-sgr1.png')
      %saveas(Hleg1B, 'legend_sgr0-sgr1.png')

    case 3 % Fig 2A 
      shstat_options('default');
      WRc = read_allStat({'Ww_i', 'R_i', 'c_T'}); Ww_i = WRc(:,1); c_T = WRc(:,3); R_i = WRc(:,2) ./ c_T; 
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      data = [Ww_i, sgr]; [Hfig2A, Hleg2A] = shstat(data, legend_RSED, title); 
    
      figure(Hfig2A) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log r_N, 1/d')
      
      x_LH = [-8; 10]; xlim(x_LH); ylim([-6; 1]);
      [slope y_LH] = pca2(data, x_LH, [true; true]);
      plot(x_LH, y_LH, 'k', 'Linewidth', 2)
      slope

      %saveas(Hfig2A, 'Wwi-sgr.png')
      %saveas(Hleg2A, 'legend_Wwi-sgr.png')

    case 4 % Fig 2B
      shstat_options('default');
      LRc = read_allStat({'L_i', 'R_i', 'c_T'}); L_i = LRc(:,1); c_T = LRc(:,3); R_i = LRc(:,2) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      data = [L_i, sgr]; [Hfig2B, Hleg2B] = shstat(data, legend_RSED, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate struct length, cm')      
      ylabel('_{10}log r_N, 1/d')
      
      x_LH = [-3; 3]; xlim(x_LH); ylim([-6; 1]);
      [slope, y_LH] = pca2(data, x_LH, [true; true]);
      plot(x_LH, y_LH, 'k', 'Linewidth', 2)
      slope

      %saveas(Hfig2B, 'Li-sgr.png')
      %saveas(Hleg2B, 'legend_Li-sgr.png')
      
    case 5 % Fig 3A 
      shstat_options('default');
      WJc = read_allStat({'Ww_i', 'J_Oi', 'c_T'}); Ww_i = WJc(:,1); c_T = WJc(:,3); j_Oi = WJc(:,2) ./ c_T ./Ww_i; 
       
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      data = [Ww_i, j_Oi]; [Hfig2A, Hleg3A] = shstat(data, legend_RSED, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log spec O_2 consumption, mol/d.g')
      
      x_LH = [-8; 10]; xlim(x_LH); ylim([-7; 1]);
      [slope y_LH] = pca2(data, x_LH, [true; true]);
      plot(x_LH, y_LH, 'k', 'Linewidth', 2)
      slope

      %saveas(Hfig3A, 'Wwi-jOi.png')
      %saveas(Hleg3A, 'legend_Wwi-jOi.png')

    case 6 % Fig 3B
      shstat_options('default');
      dWWRc = read_allStat('dWm', 'W_dWm', 'R_i', 'c_T'); cT = dWWRc(:,4); rm = dWWRc(:,1) ./ dWWRc(:,2) ./ c_T; R_i = dWWRc(:,3) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      data = [rm, sgr]; [Hfig3B, Hleg3B] = shstat(data, legend_RSED, title); 
    
      figure(Hfig3B) 
      xlabel('_{10}log spec growth at max growth of structure, 1/d')      
      ylabel('_{10}log r_N, 1/d')
      
      figure(Hfig3B) 
      plot([-5.5; 0.5], [-5.5; 0.5], 'k', 'Linewidth', 2)
      xlim([-5.5 0.5]);
      ylim([-5.5 0.5]);

      %saveas(Hfig3B, 'rm-sgr.png')
      %saveas(Hleg3B, 'legend_rm-sgr.png')

   case 7 % Fig 4A
      shstat_options('default');
      pRc = read_allStat('p_M', 'R_i', 'c_T'); c_T = pRc(:,3); p_M = pRc(:,1); R_i = pRc(:,2) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      data = [p_M, sgr]; [Hfig4A, Hleg4A] = shstat(data, legend_RSED, title); 
    
      figure(Hfig) 
      xlabel('_{10}log [p_M], J/d.cm^3')      
      ylabel('_{10}log r_N, 1/d')
      
      x_LH = [-1; 5.5]; xlim(x_LH); ylim([-6; 0.5]);
      [slope y_LH] = pca2(data, x_LH, [false; true]);
      plot(x_LH, y_LH, 'k', 'Linewidth', 2)
      slope

      %saveas(Hfig4A, 'pM-sgr.png')
      %saveas(Hleg4A, 'legend_pM-sgr.png')

    case 8 % Fig 4B 
      shstat_options('default');
      pHL = read_allStat('p_M', 'E_Hp', 'L_i'); p_M = pHL(:,1); E_Hp = pHL(:,2) ./ pHL(:,3) .^3;
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      data = [p_M, E_Hp]; [Hfig4B, Hleg4B] = shstat(data, legend_RSED, title); 
    
      figure(Hfig) 
      xlabel('_{10}log [p_M], J/d.cm^3')      
      ylabel('_{10}log [E_H^p], J/cm^3')
      
      x_LH = [-0.5; 5]; xlim(x_LH); ylim([-6; 8]);
      [slope y_LH] = pca2(data, x_LH, [true; true]);
      plot(x_LH, y_LH, 'k', 'Linewidth', 2)
      slope

      %saveas(Hfig4B, 'pM-EHp.png')
      %saveas(Hleg4B, 'legend_pM-EHp.png')

    case 9 % Fig 5A 
      shstat_options('default');
      shstat_options('x_transform','none');
      Rc = read_allStat('R_i', 'c_T'); c_T = Rc(:,2); R_i = Rc(:,1) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      f0 = read_popStat('f0.thin0.f.f');
      
      title = ['T_{ref}, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      data = [f0, sgr]; 
      [Hfig5A, Hleg5A] = shstat(data, legend_mamm, title); 
    
      figure(Hfig) 
      xlabel('f at r_N = 0, -')      
      ylabel('_{10}log r_N at f = 1, 1/d')
      
      %saveas(Hfig5A, 'f0-sgr.png')
      %saveas(Hleg5A, 'legend_f0-sgr.png')

    case 10 % Fig 5B
      shstat_options('default');
      sRc = read_allStat('s_Hbp', 'R_i', 'c_T'); s_Hbp = sRc(:,1); c_T = sRc(:,3); R_i = sRc(:,2) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      data = [s_Hbp, sgr]; 
      [Hfig5B, Hleg5B] = shstat(data, legend_mamm, title); 
    
      figure(Hfig) 
      xlabel('_{10}log s_H^{bp}, -')      
      ylabel('_{10}log r_N, 1/d')
      xlim([-11 0]);
      
      %saveas(Hfig5B, 'sHbp-sgr.png')
      %saveas(Hleg5B, 'legend_sHbp-sgr.png')

    case 11 % Fig 6A 
      shstat_options('default');
      shstat_options('x_transform','none');
      Rkc = read_allStat('R_i', 'kap', 'c_T'); c_T = Rkc(:,3); kap = Rkc(:,2); R_i = Rkc(:,1) ./ c_T; 
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      data = [kap, sgr]; 
      [Hfig6A, Hleg6A] = shstat(data, legend_RSED, title); 
    
      figure(Hfig6A) 
      xlabel('\kappa, -')      
      ylabel('_{10}log r_N, 1/d')
      
      %saveas(Hfig, 'kap-sgr.png')
      %saveas(Hleg, 'legend_kap-sgr.png')

    case 12 % Fig 6B
      shstat_options('default');
      sRc = read_allStat('s_s', 'R_i', 'c_T'); c_T = sRc(:,3); s_s = sRc(:,1); R_i = sRc(:,2) ./ c_T;
      sgr0 = read_popStat('f1.thin0.f.r') ./ c_T; % sgr without thinning
      sgr1 = read_popStat('f1.thin1.f.r') ./ c_T; % sgr with thinning
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date_allStat),'yyyy/mm/dd')];
      sel = (R_i > 1); sgr = sgr0;  sgr(sel) = sgr1(sel);
      data = [s_s, sgr]; data(s_s > 4/27,:) = NaN; % Alaskozetes_antarcticus gives problems due to deviating T_ref
      [Hfig6B, Hleg6B] = shstat(data, legend_vert, title); 
    
      figure(Hfig) 
      xlabel('_{10}log supply stress s_s, -')      
      ylabel('_{10}log r_N, 1/d')
      
      %saveas(Hfig6B, 'ss-sgr.png')
      %saveas(Hleg6B, 'legend_ss-sgr.png')
  end
end


