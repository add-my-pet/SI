% Supporting Files for MarnKooy2022
% Publication title: The comparative energetics of the turtles and crocodiles
% Authors (Year): Marn N, Kooijman SALM (2022)  
% Journal: Ecology and Evolution 12(6): e8996; doi: 10.1002/ece3.8996

% uses open source package DEBtool_M  https://github.com/add-my-pet/DEBtool_M 
% and AmPtool https://github.com/add-my-pet/AmPtool

% generates Figure 6 of the main article; toggle between lines 46/47 to reduce computing time; (out)comment saveas(..., '*.png') commands to save (or not) the figures

% Multi-dimensional scaling
% created by Marn Nov 2021, last modified Feb 2023

 traits = {'v'; 'E_m'; 's_Hbp'; 'p_M'; 's_s'; 'R_i'; 'p_Am'; 'Ww_i'; 'a_b'; 'a_p'; 'a_m'; 'E_0'}; % use anything from allStat
  species = [select('Testudines');select('Crocodilia');select('Lepidosauria');select('Pterosauria');...
      select('Saurischia');select('Ornithischia');select('Tyrannosauridae')];
  legend = { ... % Turtles
    % Land turtles (tortoises) 	
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Testudinidae'
   % Sea turtles
   {'o', 8, 3, [0 0 1], [0.55 0.55 0.55]}, 'Chelonioidea'
   % Other turtles
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Testudines' 
   % Crocodilia
   {'x', 5, 4, [1 0 0], [1 0 0]}, 'Deinosuchus'; ... % extinct terror crocodile
   {'^', 8, 3, [1 0 0], [1 0 0]}, 'Crocodilia'; ...
   % other Reptilia (some extinct)
   {'x', 4, 4, [0 0 0], [0 0 0]}, 'Lepidosauria'; ...
   {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Pterosauria'; ...
   {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Saurischia'; ...
   {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Ornithischia'; ...
   {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Tyrannosauridae'; ...
 };
 
               
% first compute distance-matrix and pass it to cmdscale
[dist, val] = dist_traits(species, traits); % distances between species based on traits
[y,e]=cmdscale(dist); % configuration matrix, eigenvalues
n_traits= length(traits); 
if n_traits <= length(species)
    E = e(n_traits)/e(1);
    fprintf(['With ', num2str(n_traits), ' traits the, ', num2str(n_traits), '-th eigenvalue as fraction of the first one is ', num2str(E), '\n'])
end
%return
tic
% make sure that the number of rows of data matches the number of entries
data = NaN(length(select),3); data(select_01(species),:) = y(:,1:3); 
save('data_MDS_traits.mat', 'data')
% load data_MDS_traits.mat % loads data to bypass making it
toc

% plot with legend in second figure
shstat_options('default');
shstat_options('x_transform', 'none');
shstat_options('y_transform', 'none');
shstat_options('z_transform', 'none');
[Hfig, Hleg] = shstat(data, legend, ['Reptiles', ' ', num2str(length(species)), ' @ ', datestr(date,26)]);

% fig(Hleg)
% title(lizards);
%saveas (Hleg, 'SquamataLegend.png')

 % connect the points for subclades
  connect_subclade(Hfig, y(:,1:3), 'Diapsida', 'Testudinidae',{':', 1, [0 0 1]});
  connect_subclade(Hfig, y(:,1:3), 'Diapsida', 'Chelonioidea');

%saveas (Hfig, 'SquamataMds.png')

figure % plot eigenvalues
n_e = length(e); n_t = length(traits);
if n_t < n_e
    plot(1:n_t, e(1:n_t), '*b', n_t+1:n_e, e(n_t+1:n_e), '*r')
else
    plot(1:n_e, e, '*b')
end
xlabel('rank');
ylabel('eigenvalue');
title('MDS eigenvalues for reptiles');
set(gca, 'FontSize', 15, 'Box', 'on');
saveas (gca, 'SquamataEigen.png')

c =NaN(2,size(val,2));
for i=1: size(val,2)
    c(1,i) = corr(y(:,1), val(:,i));
    c(2,i) = corr(y(:,2), val(:,i));
end

