%% LikaAugu2021_trait_tree 2021/07/12
% reconstruction of vertebrate tree from traits

close all

species = select('Vertebrata');
% traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'; 'v'; 'kap'; 'E_Hb'; 'E_Hp'};
traits = {'a_m'; 'a_p'; 'a_b'; 'L_i'; 'L_p'; 'L_b'; 'E_m'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'; 'v'; 'kap'; 'E_Hb'; 'E_Hp'};
% traits = {'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'};
taxa = {'Cyclostomata'
        'Holocephali'
        'Galeomorphi'
        'Squalomorphi'
        'Batoidea'
        'Cladistii'
        'Chondrostei'
        'Holostei'
        'Teleostei'
        'Actinistia'
        'Dipnoi'
        'Tetrapoda'};    
    
  legend = {... % type, size, linewidth, edge color and face color 
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
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

dist_spec = dist_traits(species, traits);
dist_taxa = dist_char(dist_spec, taxa);
dist = dist_taxa; n = size(dist,1); for i=1:n; dist(i,i) = 0; end;

% cmds
[y, e] = cmdscale(dist,3); % configuration matrix, eigenvalues
Hfig = plot3i(y, legend, 'mds for divergence of vertebrates');

cladogram = seqlinkage(dist_taxa, 'average', taxa); view(cladogram);
%save('cladogram_vert', 'cladogram')
