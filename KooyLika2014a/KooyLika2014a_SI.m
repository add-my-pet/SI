function KooyLika2014a_SI(fig)
% Supporting Information for KooyLika2014
% Title: Comparative energetics of the 5 fish classes on the basis of dynamic energy budgets.
% Authors: Kooijman, Lika
% Journal: J. Sea Res. 94 (2014): 19-28
% DOI: 10.1016/j.seares.2014.01.015
% Date: 2023/02/26
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
% To run the code for a figure: type in the Matlab window e.g. KooyLika2014a_SI(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all

  legend = {...
    {'o', 8, 3, [0 0 0], [0 0 1]}, 'Cyclostomata'; ...
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Chondrichthyes'; ....
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; ....
    {'o', 8, 3, [1 0 0], [1 0 1]}, 'Latimeria'; ....
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Dipnoi'; ....
    {'.', 8, 3, [1 0 0], [0 0 0]}, 'Vertebrata'; ....
    {'.', 8, 3, [0 0 0], [0 0 0]}, 'Animalia'; ....
  };

  if ~exist('fig','var')
    fig = 1:20;
  end

  close all
  
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
  
  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1a: Li-pAm   
      case 2 % fig 1b: Li-v
      case 3 % fig 1c: Li-kap
          
      case 4 % fig 1d: Li-pM  
      case 5 % fig 1e: Li-kJ   
      case 6 % fig 1f: Li-EG
          
      case 7 % fig 1g: Li-EHb
      case 8 % fig 1h: Li-EHj
      case 9 % fig 1i: Li-EHp
          
      case 10 % fig 1j: Li-ha 
          
      case 11 % fig 2a: surv kap
      case 12 % fig 2b: surv sR
 
      case 13 % fig 3a: Li-EHp/EHb
      case 14 % fig 3b: Li-pJp/Li^3
      case 15 % fig 3c: Li-ME0
          
      case 16 % fig 3d: Li-pJp/Li^3 
      case 17 % fig 3e: Li-Ri  
      case 18 % fig 3f: Li-rm
          
      case 19 % fig 3g: Li-EHb
      case 20 % fig 3h: Li-EHj
      case 21 % fig 3i: Li-EHp
          
      case 22 % fig 3k: Li-ha 
      case 23 % fig 3l: Li-ha 
      case 24 % fig 3m: Li-ha 
          
      case 25 % fig 4a: pM-rB
      case 26 % fig 4b: pM-pR/Li^3

      case 27 % fig 5: Wdm-JO/Wd

      case 28 % fig 6: surv EHp/EHb

    end
  end

end