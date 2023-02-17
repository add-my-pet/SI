function KooyLika2021_SI(fig)
% Supporting Information for KooyLika2021
% Title: Multidimensional scaling for animal traits in the context of dynamic energy budget theory
% Authors: Kooijman, Lika, Augustine, Marn
% Journal: Conserv Physiol 9(1)
% DOI: 10.1093/conphys/coab086
% Date: 2023/02/17
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
% To run the code section for a figure, place the cursor in that code section and press "Run Section" in the toolbar of the Matlab Editor
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
   fig = 1:3;
end

for i=1:length(fig)
 
  switch fig(i)
    case 1 % fig 1 Caphalopoda
      mydata_mds_Cephalopoda
      
    case 2 % fig 1
      mydata_mds_Chondrichthyes
      
    case 3 % fig 1
      mydata_mds_Testudines

    case 4 % fig 2
      mydata_mds_Austrodyptornithes
      
    case 5 % fig 2
      mydata_mds_Carnivora

    case 6 % fig 3,4
      % reconstruction of vertebrate cladogram

      % data: MYA since divergence from http://www.timetree.org/
      % 615 Cyclostomata/Gnathostomata 
      % 473 Chondrichthyes/Osteichthyes 
      % 399 Holocephali/Elasmobranchii 
      % 435 Actinopterygii/Sarcopterygii 
      % 198 Squalomorphi/Batoidea 
      % 386 Cladistii/Actinopteri 
      % 265 Galeomorphi/Squalomorphi+Batoidea 
      % 344 Chondrostei/Neopterygii 
      % 315 Holostei/Teleostei 
      % 413 Actinistia/Rhipidistia 
      % 395 Dipnoi/Tetrapoda 

      dist = [ ... % distances in MYA since divergence
        0 615 615 615 615 615 615 615 615 615 615 615 % Cyclostomata
    
        0   0 399 399 399 473 473 473 473 473 473 473 % Holocephali
        0   0   0 199 265 473 473 473 473 473 473 473 % Galeomorphi
        0   0   0   0 265 473 473 473 473 473 473 473 % Squalomorphi
        0   0   0   0   0 344 344 344 435 435 435 435 % Batoidea
    
        0   0   0   0   0   0 386 386 386 435 435 435 % Cladistii
        0   0   0   0   0   0   0 344 344 435 435 435 % Chondrostei
        0   0   0   0   0   0   0   0 315 435 435 435 % Holostei
        0   0   0   0   0   0   0   0   0 435 435 435 % Teleostei
    
        0   0   0   0   0   0   0   0   0   0 413 413 % Actinistia
        0   0   0   0   0   0   0   0   0   0   0 395 % Dipnoi
    
        0   0   0   0   0   0   0   0   0   0   0   0 % Tetrapoda
      ];
      dist = dist + dist';
    
      legend = {... % type, size, linewidth, edge color and face color 
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
        %
        {'o', 8, 3, [0 0 1], [0 0 0]}, 'Holocephali'; ...
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Galeomorphi'; ....
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Squalomorphi'; ....
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Batoidea'; ....
        %
        {'o', 8, 3, [1 0 1], [0 0 0]}, 'Cladistii'; ....
        {'o', 8, 3, [1 0 1], [0 0 1]}, 'Chondrostei'; ....
        {'o', 8, 3, [1 0 1], [1 0 0]}, 'Holostei'; ....
        {'o', 8, 3, [1 0 1], [1 1 1]}, 'Teleostei'; ....
        %
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Actinistia'; ....
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Dipnoi'; ....
        %
        {'o', 8, 3, [0 1 0], [0 1 0]}, 'Tetrapoda'; .... 
      };
      taxa = legend(:,2);

      path = [];

      % mds
      [y, e] = cmdscale(dist,3); % eigenvectors, eigenvalues
      [hfigClad, hlegClad]= plot3i(y, legend, 'mds for divergence of vertebrates');

      figure(hfigClad)
      %print -r1200 -dpng mds_Vertebrata.png;
      % the Dipnoi and Tetrapoda have the same coordinates 

      figure(hlegClad)
      %print -r1200 -dpng legend_Vertebrata.png;

      % cladogram 
      cladogram = SEQlinkage(dist, 'average', taxa); view(cladogram); % default method

  end
end


function t = SEQlinkage(d, method, names) 
%SEQLINKAGE constructs a phylogenetic tree from pairwise distances.
%
%  TREE = SEQLINKAGE(DIST) computes a phylogenetic tree object from the
%  pairwise distances DIST between the species or products. The input DIST
%  is a matrix (or vector) such as is generated by SEQPDIST.  
%
%  TREE = SEQLINKAGE(DIST,METHOD) creates a phylogenetic tree object using
%  a specified distance method. The available methods are:
%
%     'single'            --- nearest distance (single linkage method)
%     'complete'          --- furthest distance (complete linkage method)
%     'average' (default) --- unweighted average distance (UPGMA) (also
%                             known as group average) 
%     'weighted'          --- weighted average distance (WPGMA) 
%     'centroid'          --- unweighted center of mass distance (UPGMC) 
%     'median'            --- weighted center of mass distance (WPGMC) 
%
%  TREE = SEQLINKAGE(DIST,METHOD,NAMES) passes a list of names to label the
%  leaf nodes (e.g. species or products) in the phylogenetic tree object.
%  NAMES can be a vector of structures with the fields 'Header' or 'Name'
%  or a cell array of strings. In both cases the number of elements
%  provided must comply with the number of samples used to generate the
%  pairwise distances in DIST. 
%
% Example:
%
%     % Load a multiple alignment of amino acids:
%     seqs = fastaread('pf00002.fa');
% 
%     % Measure the 'Jukes-Cantor' pairwise distances:
%     dist = seqpdist(seqs,'method','jukes-cantor','indels','pair');
% 
%     % Build the phylogenetic tree with the single linkage method and pass
%     % the names of the sequences:
%     tree = seqlinkage(dist,'single',seqs)
%     view(tree)
%
% See also PHYTREE, PHYTREE/PLOT, PHYTREE/VIEW, PHYTREEWRITE,
%   SEQNEIGHJOIN, SEQPDIST. 

% Copyright 2003-2005 The MathWorks, Inc.


% check the input distances
[m, n] = size(d);

if m==n && m>1 % transform to vector form
    D = zeros(m*(m-1)/2,1);
    k=1;
    for j = 1:m-1
        for i = j+1:m
            D(k) = d(i,j);
            k = k+1;
        end
    end
else
    D=d(:);
end

D=D'; % linkage uses row form
n = numel(D);
m = (1+sqrt(1+8*n))/2; % number of leaves
if m ~= fix(m)
    error(message('bioinfo:seqlinkage:BadSize'));
end

% Selects appropriate method
if nargin == 1 % set default switch to be 's' 
    method = 'av';
else
    okmethods = {'single','nearest',...
                 'complete','farthest',...
                 'average','upgma',...
                 'weighted','wpgma',...
                 'centroid','upgmc',...
                 'median','wpgmc'};
    methodkeys = {'si','si','co','co','av','av','we','we','ce','ce',...
                  'me','me','wa','wa'};     
    s = find(strncmpi(method, okmethods,numel(method))); 
    if isempty(s)
        error(message('bioinfo:seqlinkage:UnknownMethod', method));
    elseif length(s)>1
        error(message('bioinfo:seqlinkage:IncorrectMethod', method));
    else
        method = methodkeys{s};
    end
end

% detects the names
if nargin == 3 % names were supplied, check validity
    if iscell(names) || isfield(names,'Header') || isfield(names,'Name') || isfield(names,'LocusName')
        if isfield(names,'Header') % if struct put them in a cell
            names = {names(:).Header};
        elseif isfield(names,'Name')   % if struct put them in a cell
            names = {names(:).Name};
        elseif isfield(names,'LocusName')   % if struct put them in a cell
            names = {names(:).LocusName};
        end
        names = names(:);
        namesSupplied = true;
        if numel(names)~=m
            error(message('bioinfo:seqlinkage:IncorrectSize'))
        end
    else
        error(message('bioinfo:seqlinkage:IncorrectInputType'))
    end
else
    namesSupplied = false;
end

% call the stats linkage program
T = linkage(D,method);

% convert data to a phylogenetic tree object
if namesSupplied
    t = phytree(T,names);
else
    t = phytree(T);
end
