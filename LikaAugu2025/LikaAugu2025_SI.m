function LikaAugu2025_SI(fig)
% Supporting Information for LikaAugu2025
% Title: Relax-hurry spectra in animal kingdom
% Authors: Lika, Augustine, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2025/12/07
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2025_SI(2)
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
   fig = 1:31;
end

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
  
 for i=1:length(fig)
 
   switch fig(i)
     case 1 %  Aves
       nm = select('Aves'); n = length(nm); 
       climate = read_eco(nm, 'climate');
       data = read_stat(nm,{'Ww_i', 'p_M', 'J_Oi', 'c_T'}); 
       Ww_i = data(:,1); p_M = data(:,2); jO_i = data(:,3)./data(:,4)./Ww_i;
       
       %figure Wwi-pM Aves climate
       color = climate2color(climate);
       leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
       plot2i([log10(Ww_i), log10(p_M)], leg, ['Aves @ ',datestr(datenum(date),'yyyy/mm/dd')]);
       xlabel('_{10}log ultimate weight W_w^\infty, g')
       ylabel('_{10}log spec somatic maint [p_M], J/d.cm^3')
       set(gca, 'FontSize', 15, 'Box', 'on')
       saveas(gcf,'Wwi_pM_Aves.png')
       
       %figure Wwi-jOi Aves climate
       color = climate2color(climate);
       leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
       plot2i([log10(Ww_i), log10(jO_i)], leg, ['Aves @ ',datestr(datenum(date),'yyyy/mm/dd')]);
       xlabel('_{10}log ultimate weight W_w^\infty, g')
       ylabel('_{10}log spec respiration at 20 C, j_O^\infty, mol/d.g')
       set(gca, 'FontSize', 15, 'Box', 'on')
       saveas(gcf,'Wwi_jOi_Aves.png')
       
     case 2 %  Mammalia
       nm = select('Mammalia'); n = length(nm); 
       climate = read_eco(nm, 'climate'); 
       data = read_stat(nm,{'Ww_i', 'p_M', 'J_Oi', 'c_T'}); 
       Ww_i = data(:,1); p_M = data(:,2); jO_i = data(:,3)./data(:,4)./Ww_i;
       
       %figure Wwi-pM Mammalia climate
       color = climate2color(climate);
       leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
       plot2i([log10(Ww_i), log10(p_M)], leg, ['Mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')]);
       xlabel('_{10}log ultimate weight W_w^\infty, g')
       ylabel('_{10}log spec somatic maint [p_M], J/d.cm^3')
       set(gca, 'FontSize', 15, 'Box', 'on')
       saveas(gcf,'Wwi_pM_Mamm.png')
       
       %figure Wwi-jOi Mammalia climate
       color = climate2color(climate);
       leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
       plot2i([log10(Ww_i), log10(jO_i)], leg, ['Mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')]);
       xlabel('_{10}log ultimate weight W_w^\infty, g')
       ylabel('_{10}log spec respiration at 20 C, j_O^\infty, mol/d.g')
       set(gca, 'FontSize', 15, 'Box', 'on')
       saveas(gcf,'Wwi_jOi_Mamm.png')

    end
 end
end

function color = climate2color(climate)
   n = length(climate); color = NaN(n,3);
   for i = 1:n
     A = any(contains(climate{i},'A')); 
     B = any(contains(climate{i},'B')); 
     C = any(contains(climate{i},'C')); 
     D = any(contains(climate{i},'D')); 
     E = any(contains(climate{i},'E')); 
     val = (0.1*A + 0.3*B + 0.5*C + 0.7*D + 0.9*E)/ (A + B + C + D + E);
     color(i,:) = color_lava(val); 
   end
    
end
