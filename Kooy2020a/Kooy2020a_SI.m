function Kooy2020a_SI(fig)
% Supporting Information for Kooy2020a
% Title: The comparative energetics of the petrels and penguins
% Authors: Kooijman
% Journal: Ecological Modelling 427: 109052
% DOI:10.1016/j.ecolmodel.2020.109052
% Date: 2023/02/20
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
%
% To run the code (here for section 3), open this file in the Matlab Editor and type in the Matlab window: Kooy2020a_SI(3)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_allStat; the first call to these functions loads the allStat.mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "saveas" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend (e.g. legend_RSED), see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

legend_austro = {... % define legend
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Procellariidae'; ....
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Diomedeidae'; ....
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Oceanitidae'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Hydrobatidae'; ....
    {'o', 8, 3, [0 0 1], [1 1 1]}, 'Oceanitidae'; ....
    {'o', 8, 3, [1 0 0], [0 0 0]}, 'Aptenodytes'; ....
    {'o', 8, 3, [1 0 0], [0 0 1]}, 'Spheniscus'; ....
    {'o', 8, 3, [1 0 0], [1 0 1]}, 'Eudyptula'; ....
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Eudyptes'; ....
    {'o', 8, 3, [1 0 0], [1 1 1]}, 'Pygoscelis'; ....
    {'.',12, 3, [1 0 0], [0 0 0]}, 'Aequornithes'; ....
    {'.',12, 3, [1 0 1], [0 0 0]}, 'Aequorlitornithes'; ....
    {'.', 8, 3, [0 0 0], [0 0 0]}, 'Aves'; ....
  };

if ~exist('fig','var')
   fig = 1:7;
end

for i=1:length(fig)
 
  switch fig(i)
    case 1 % Fig 2A


      close all
      shstat_options('default');
      dWWRc = read_allStat('dWm', 'W_dWm', 'R_i', 'c_T','Ww_i'); c_T = dWWRc(:,4); rm = dWWRc(:,1) ./ dWWRc(:,2) ./ c_T; R_i = dWWRc(:,3) ./ c_T; Ww_i = dWWRc(:,5);
      sgr = read_popStat('f1.thin0.f.r') ./ c_T; 
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [rm, sgr]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log spec growth at max growth, 1/d')      
      ylabel('_{10}log sgr, 1/d')
      
      figure(Hfig) 
      plot([-4; -1.25], [-4; -1.25], 'k', 'Linewidth', 2)
      xlim([-4 -1.25]);
      ylim([-4 -1.25]);


      %saveas(Hfig, 'rm-sgr.png')
      %saveas(Hleg, 'legend_rm-sgr.png')
      
      
    case 2 % Fig 2B
 
      close all
      shstat_options('default');
      Wac = read_allStat({'Ww_i', 'a_p', 'c_T'}); Ww_i = Wac(:,1); a_p = Wac(:,2) .* Wac(:,3); 
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, a_p]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log age at puberty, d')
      
      %saveas(Hfig, 'Wwi-ap.png')
      %saveas(Hleg, 'legend_Wwi-ap.png')
      
    case 3 % Fig 3A

      close all
      shstat_options('default');
      WEm = read_allStat({'Ww_i', 'E_m'}); Ww_i = WEm(:,1); E_m = WEm(:,2); 
      
      title = ['f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, E_m]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log reserve capacity, J/cm^3')
      
      %saveas(Hfig, 'Wwi-Em.png')
      %saveas(Hleg, 'legend_Wwi-Em.png')
      
    case 4 % Fig 3B

      close all
      shstat_options('default');
      Wac = read_allStat({'Ww_i', 'a_m', 'c_T'}); Ww_i = Wac(:,1); a_m = Wac(:,2) ./ Wac(:,3); 
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, a_m]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log mean life span, d')
      
      %saveas(Hfig, 'Wwi-am.png')
      %saveas(Hleg, 'legend_Wwi-am.png')
      
      
      case 5 % Fig 4A,B

      close all
      shstat_options('default');
      WWac = read_allStat({'Ww_i', 'Ww_b', 'a_b', 'c_T'}); Ww_i = WWac(:,1); Ww_b = WWac(:,2); a_b = WWac(:,3) .* WWac(:,4); 
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, a_b]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log age at birth, d')
      
      %saveas(Hfig, 'Wwi-ab.png')

      title = ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, Ww_b]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log wet weight at birth, d')

      %saveas(Hfig, 'Wwi-Wwb.png')
      
    case 6 % Fig 5A,B

      close all
      shstat_options('default');
      WRpc = read_allStat({'Ww_i', 'R_i', 'p_Ri', 'c_T'}); Ww_i = WRpc(:,1); R_i = WRpc(:,2) ./ WRpc(:,4); p_Ri = WRpc(:,3) ./ WRpc(:,4); 
      
      title = ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, R_i]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log reproduction rate, 1/d')
      
      %saveas(Hfig, 'Wwi-Ri.png')

      title = []; % ['T_{ref}, f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];
      data = [Ww_i, p_Ri]; [Hfig, Hleg] = shstat(data, legend_austro, title); 
    
      figure(Hfig) 
      xlabel('_{10}log ultimate wet weight, g')      
      ylabel('_{10}log allocation to reproduction, J/d')

      %saveas(Hfig, 'Wwi-pRi.png')


    case 7 % Fig 6A,B

      close all
      shstat_options('default');
      shstat_options('x_transform', 'none');
      shstat_options('y_label', 'on');
      title = []; % ['f = 1, ', datestr(datenum(date),'yyyy/mm/dd')];

      llegend_aequ = {...
        {'-', 2, [0 0 1]}, 'Procellariiformes'; ....
        {'-', 2, [1 0 0]}, 'Sphenisciformes'; ....
        {':', 2, [1 0 0]}, 'Aequornithes'; ....
        {':', 2, [1 0 1]}, 'Aequorlitornithes'; ....
        {':', 2, [0 0 0]}, 'Aves'; ....
      };
      
      [Hfig, Hleg] = shstat({'s_s'}, llegend_aequ, title);     
      figure(Hfig)
      xlabel('supply stress, s_s')
          
      %saveas(Hfig, 'ss.png')
      %saveas(Hleg, 'legend_ss.png')

      shstat_options('x_transform', 'log10');
      title = [datestr(datenum(date),'yyyy/mm/dd')];
      [HFig, HLeg] = shstat({'s_Hbp'}, llegend_aequ, title);     
      figure(HFig)
      xlabel('_{10} log maturity ratio, s_H^{bp}')
          
      %saveas(HFig, 'sHbp.png')
      %saveas(HLeg, 'legend_sHbp.png')
  end
end
