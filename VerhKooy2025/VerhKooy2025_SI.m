function VerhKooy2025_SI(fig)
% Supporting Information for VerhKooy2025
% Title: Aerobic scope in the context of the supply-demand spectrum
% Authors: Verhille, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2025/07/02
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
% To run the code for a figure: type in the Matlab window e.g. VerhKooy2025_SI(1)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html
%
% Example of use
% VerhKooy2025_SI(1)

close all
if ~exist('fig','var')
   fig = 1:31;
end

 legend = { ... % % colors from legend_vert
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; 
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Aves'; 
   {'o', 8, 3, [1 .5 .5], [0 0 0]}, 'Masupialia'
   {'o', 8, 3, [1 .5 .5], [1 .5 .5]}, 'Placentalia'
 };
 Hlegend = shlegend(legend);
 saveas(Hlegend,'legend_PMR_SMR.png')

     act = { ... % Actinopterygii, mass(g), temp(C), SMR(mg O2/h.kg), PMR(mg O2/h.kg), MMR(mg O2/h.kg) 
       [  0.45 24   463 717 1066], 'FuDong2022', 'Danio_rerio'
       [  7    25   203 581 1300], 'FuDong2022', 'Zacco_platypus'
       [  7.72 25   220 470  680], 'FuDong2022', 'Carassius_auratus'
       [ 10.49 15   120 259  490], 'FuDong2022', 'Carassius_auratus'
       [  9.68 25   237 629 1100], 'FuDong2022', 'Carassius_auratus'
       [  7.42 25   191 296 1034], 'FuDong2022', 'Ctenopharyngodon_idella'
       [ 19.52 25   115 201  780], 'FuDong2022', 'Procypris_rabaudi'
       [  8.27 15    86 133  547], 'FuDong2022', 'Parabramis_pekinensis'
       [  4.62 25   290 500 1260], 'FuDong2022', 'Parabramis_pekinensis'
       [  7.94 15   113 252  629], 'FuDong2022', 'Cyprinus_carpio'
       [  7.56 25   256 464 1140], 'FuDong2022', 'Cyprinus_carpio'
       [  4.62 25   220 350 1100], 'FuDong2022', 'Mylopharyngodon_piceus'
       [  7.72 15   103 209  510], 'FuDong2022', 'Spinibarbus_sinensis'
       [  7.71 25   160 283 1190], 'FuDong2022', 'Spinibarbus_sinensis'
       [ 22.45 15    54 149  245], 'FuDong2022', 'Silurus_meridionalis'
       [ 12.89 25   114 510  761], 'FuDong2022', 'Silurus_meridionalis'
       [ 30    23    98 222  351], 'FuDong2022', 'Silurus_asotus'
       [  6.65 25   235 341 1020], 'FuDong2022', 'Tachysurus_vachellii'
       [520     9    48 109  490], 'FuDong2022', 'Oncorhynchus_tshawytscha'
       [  6    15   189 591  787], 'FuDong2022', 'Oncorhynchus_mykiss'
       [364    22.5 100 160  350], 'FuDong2022', 'Dicentrarchus_labrax'
       [105    17   130 190  381], 'FuDong2022', 'Pagrus_auratus'
       [107    21   163 250  468], 'FuDong2022', 'Pagrus_auratus'
       [ 30    17   104 195  686], 'FuDong2022', 'Aldrichetta_forsteri'
       [ 29    21   124 210  799], 'FuDong2022', 'Aldrichetta_forsteri'
       [706    26   200 800 1364], 'FuDong2022', 'Coryphaena_hippurus'
       [135.5  26    90 443  352], 'FuDong2022', 'Pterois_volitans'
       [135.5  32   166 491  346], 'FuDong2022', 'Pterois_volitans'
     };
    prt_tab({act(:,[3 2]), cell2mat(act(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,mg O2/h.kg', 'PMR,mg O2/h.kg', 'MMR,mg O2/h.kg'}, 'Actinop')

    ave = { ...  % Aves ; m(g) Tb(C) BMR(ml O2/min) PMR (ml O2/min); x means not in AmP
       [  36.0 39.7  1.28   7.91], 'HindBaud1993', 'Melopsittacus_undulatus' % BundHopl1999 give AS 21
       [  89.4 40.0  NaN   12.79], 'HindBaud1993', 'Platycercus_elegans' % actually Platycercus_eximius
       [  42.1 40.5  1.20   6.57], 'HindBaud1993', 'Synoicus_chinensis' 
       [ 161.0 41.3  4.41  20.48], 'HindBaud1993', 'Coturnix_japonica' 
       [ 850.3 37.4  9.19  52.08], 'HindBaud1993', 'Porphyrio_martinica' 
      %[ 944.1 39.7 12.23  61.51], 'HindBaud1993', 'Anas_castanea' %x
       [ 302.0 41.7  4.34  28.24], 'HindBaud1993', 'Columba_livia' 
       [1080.0 38.5 13.31  57.42], 'HindBaud1993', 'Eudyptula_minor' 
       [  11.3 41.0  0.68   4.03], 'HindBaud1993', 'Taeniopygia_guttata' 
       [21800  39.0 103.6   3728], 'BundHopl1999', 'Rhea_americana' % 2.85 ml O2/s.kg, AS 36
       [ 2800  41.0  24.1 299.60], 'BracElSa1985', 'Gallus_gallus_WL' % 8.6, 107 ml CO2/min.kg
    };     
    prt_tab({ave(:,[3 2]), cell2mat(ave(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,mg O2/h.kg', 'PMR,mg O2/h.kg'}, 'Aves')

    mar = { ... % Marsupialia & Prototheria; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); x means not in AmP
     [ 1112.5 30.8 10.87  49.86], 'HindBaud1993', 'Ornithorhynchus_anatinus' 
     [ 3293.0 30.8  7.76  47.05], 'HindBaud1993', 'Tachyglossus_aculeatus' 
     [   15.6 35.0  0.48   2.38], 'HindBaud1993', 'Sminthopsis_crassicaudata' 
     [   16.7 32.7  0.35   2.38], 'HindBaud1993', 'Sminthopsis_macroura'
     [  119.5 35.3  1.52  19.36], 'HindBaud1993', 'Dasyuroides_byrnei'
    %[  532.3 33.7  3.20  29.85], 'HindBaud1993', 'Dasyurus_hallucatus' %x
     [ 1054.0 35.1  6.28  69.60], 'HindBaud1993', 'Dasyurus_viverrinus' 
     [  717.2 33.9  3.71  43.43], 'HindBaud1993', 'Isoodon_obesulus'
     [  837.3 35.2  7.01  48.76], 'HindBaud1993', 'Perameles_gunnii'
     [  122.0 34.9  1.40   8.24], 'HindBaud1993', 'Petaurus_breviceps' 
     [  965.7 37.2  9.39  70.07], 'HindBaud1993', 'Bettongia_penicillata'
     [ 1027.8 35.8  8.72  65.90], 'HindBaud1993', 'Potorous_tridactylus' 
     [ 1385.0 35.6 10.69 100.10], 'HindBaud1993', 'Bettongia_gaimardi' 
     [ 2026.5 35.8 13.85  74.65], 'HindBaud1993', 'Trichosurus_vulpecula'
    };
    %  
    pla = {... % Placentalia; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); %x means not in AmP
     [   38.8 36.2  0.83   3.48], 'HindBaud1993', 'Notomys_alexis'
    %[  165.7 36.2  2.05  11.51], 'HindBaud1993', 'Rattus_colletti' %x
     [  181.2 38.0  4.47  21.90],     'Lech1978', 'Rattus_norvegicus' 
     [  212.3 35.9  2.71  14.85], 'HindBaud1993', 'Conilurus_penicillatus' 
    %[  247.8 36.0  2.43  14.48], 'HindBaud1993', 'Rattus_villosissimus' %x
    %[  819.0 34.6  9.51  44.27], 'HindBaud1993', 'Uromys_caudimaculatus' %x
     [ 1242.0 38.3 14.56  63.58], 'HindBaud1993', 'Oryctolagus_cuniculus'
     [   28.0 37.0  1.28   6.30],     'Lech1978', 'Myodes_rutilus'
     [    6.9 36.0  0.24   1.41],     'Lech1978', 'Baiomys_taylori'
     [   34   37.0  0.88   5.30],     'Lech1978', 'Mus_musculus'
     [  113   38.0  2.47  11.20],     'Lech1978', 'Mesocricetus_auratus'
     [   48   38.0  0.93   5.34],     'Lech1978', 'Calomys_callosus'
     [    3.3 39.0  0.15   1.60],     'Lech1978', 'Sorex_cinereus'
     [32000   39.5 152.5   9792], 'LindHoka1991', 'Antilocapra_americana' % 5.1 ml O2/s.kg = 9792 ml O2/min; Bish1999 AS = 64.2; BMR = 9792/64.2 ml O2/min
     [70000   37.0 268.3   3733], 'WillSton2005', 'Homo_sapiens' % 0.23, 3.2 ml O2/h.g
     };               
    prt_tab({[mar(:,[3 2]);pla(:,[3 2])], [cell2mat(mar(:,1));cell2mat(pla(:,1))]},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min'}, 'Mammalia')
         
for i=1:length(fig)
 
  switch fig(i)
    case 1 % FuDong2022,HindBaud1993

    
    data = cell2mat(act(:,1)); PMR_SMR_act = data(:,4)./data(:,3);
    ss_act = read_stat(act(:,3),'s_s');
    Hfig = figure;
      plot(ss_act, PMR_SMR_act, '.b', 'MarkerSize',20)
      xlabel('supply stress s_s, -')
      ylabel('PMR/SMR, -')
      
    hold on
    data = cell2mat(mar(:,1)); PMR_SMR_mar = data(:,4)./data(:,3);
    ss_mar = read_stat(mar(:,3),'s_s');
    plot(ss_mar, PMR_SMR_mar, 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[0 0 0])
    %
    data = cell2mat(pla(:,1)); PMR_SMR_pla = data(:,4)./data(:,3);
    ss_pla = read_stat(pla(:,3),'s_s');
    plot(ss_pla, PMR_SMR_pla,'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])
    %
    data = cell2mat(ave(:,1)); PMR_SMR_ave = data(:,4)./data(:,3);
    ss_ave = read_stat(ave(:,3),'s_s');
    plot(ss_ave, PMR_SMR_ave, '.r', 'MarkerSize',20)

    % set species names behind markers in plot figure
    h = datacursormode(Hfig); entries_txt = [act(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
    data = [[ss_act;ss_ave;ss_mar;ss_pla],[PMR_SMR_act;PMR_SMR_ave;PMR_SMR_mar;PMR_SMR_pla]];
    for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
    h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
    datacursormode on % mouse click on plot
    
    prt_tab({entries_txt, data},{'species', 's_s', 'PMR/SMR'}, 'Vertebrates')
    
    saveas(gcf,'ss_AS.png')
    
        
  end
end
   
% References
% 
% @article{Bish1999,
%   title = {The maximum oxygen consumption and aerobic scope of birds and mammals: getting to the heart of the matter},
%   journal = {Proc. R. Soc. Lond. B},
%   volume = {266},
%   year = {1999},
%   pages = {2275-2281},
%   author = {Bishop, C. M.}
% }
% 
% @article{BracElSa1985,
%   title = {Comparison of running energetics in males and femlae domestic fowl},
%   journal = {Proc. R. Soc. Lond. B},
%   volume = {117},
%   year = {1985},
%   pages = {349-355},
%   author = {Brackenbury, J. H. and El-Sayed, M. S.}
% }
% 
% @article{FuDong2022,
%   title = {Aerobic scope in fishes with different lifestyles and across habitats: Trade-offs among hypoxia tolerance, swimming performance and digestion},
%   journal = {Comp. Biochem. Physiol. A},
%   volume = {272},
%   year = {2022},
%   pages = {111277},
%   author = {Fu, Shi-Jian and Dong, Yun-Wei and Killen, Shaun S.}
% }
%
% @article{HindBaud1993,
%   title = {Maximum metabolism and the aerobic factorial scope of endotherms},
%   journal = {J. Exp. Biol.},
%   volume = {182},
%   year = {1993},
%   pages = {41-56},
%   author = {Bishop, C. M.}
% }
% 
% @article{Lech1978,
%   title = {The scaling of maximal oxygen consumption and pulmonary dimensions in small mammals},
%   journal = {Resp. Physiol.},
%   volume = {34},
%   year = {1978},
%   pages = {29-44},
%   author = {Lechner, A. J.}
% }
% 
% @article{LindHoka1991,
%   title = {Running energetics in the pronghorn antilope},
%   journal = {Nature},
%   volume = {353},
%   year = {1991},
%   pages = {748-750},
%   author = {Lindstedt, S. L. and Hokanson, J. F. and Wells, D. J. abd Swain, S. D. and Hoppeler, H. and Navarro, V.}
% }
% 
% @book{WillSton2005,
%   title = {Environmental physiology of animals},
%   publisher = {Blackwell Publishing},
%   year = {2005},
%   author = {Willmer, P. W. and Stone, G. and Johnston, I.}
% }
