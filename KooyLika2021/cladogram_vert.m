%% cladogram_vert_new 2023/07/11
% reconstruction of vertebrate cladogram, see LikaAugu2021

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
    0 455 615 615 615 615 615 615 615 615 615 615 615 % mixini
    0 0 615 615 615 615 615 615 615 615 615 615 615 % holocephalaspidomorphi
  
    0  0  0 399 399 399 473 473 473 473 473 473 473 % Holocephali
    0  0  0   0 265 265 473 473 473 473 473 473 473 % Galeomorphi
    0  0  0   0   0 198 473 473 473 473 473 473 473 % Squalomorphi
    0  0  0   0   0   0 344 344 344 435 435 435 435 % Batoidea
    
    0  0  0   0   0   0   0 386 386 386 435 435 435 % Cladistii
    0  0  0   0   0   0   0   0 344 344 435 435 435 % Chondrostei
    0  0  0   0   0   0   0   0   0 315 435 435 435 % Holostei
    0  0  0   0   0   0   0   0   0   0 435 435 435 % Teleostei
    
    0  0  0   0   0   0   0   0   0   0   0 413 413 % Actinistia
    0  0  0   0   0   0   0   0   0   0   0   0 395 % Dipnoi
    
    0  0  0   0   0   0   0   0   0   0   0   0   0 % Tetrapoda
    ];
dist = dist + dist';
    
  legend = {... % type, size, linewidth, edge color and face color 
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Mixini'; ...
    {'o', 8, 3, [0 0 0], [0 1 1]}, 'Cephalapidosmorphi'; ...
    %
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Holocephali'; ...
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Galeomorphi'; ....
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Squalomorphi'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Batoidea'; ....
    %
    {'o', 8, 3, [1 0 1], [0 0 0]}, 'Cladistii'; ....
    {'o', 8, 3, [1 0 1], [0 0 1]}, 'Chondrostei'; ....
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Holostei'; ....
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Teleostei'; ....
    %
    {'o', 8, 3, [1 0 0], [0 0 0]}, 'Actinistia'; ....
    {'o', 8, 3, [1 0 0], [1 1 1]}, 'Dipnoi'; ....
    %
    {'o', 8, 3, [0 1 0], [0 1 0]}, 'Tetrapoda'; .... 
  };
  taxa = legend(:,2);

path = []; close all

% mds
[y, e] = cmdscale(dist,3); % eigenvectors, eigenvalues
[hfig, hleg]= plot3i(y, legend, 'mds for divergence of vertebrates');
saveas(hfig, [path, 'mds_Vertebrata.png'])
saveas(hleg, [path, 'legend_Vertebrata.png'])
% the Dipnoi and Tetrapoda have the same coordinates 

% cladogram 
cladogram = seqlinkage(dist, 'average', taxa); view(cladogram); % default method

