function mydata_allo3(fig)

  if ~exist('fig','var')
   fig = 1:5;
  end

 
  n = length(select('Animalia'));
  
  shstat_options('default');
  shstat_options('x_transform', 'log10');
  shstat_options('y_transform', 'log10');

  nmregr_options('default');
  nmregr_options('report',1);
  nmregr_options('max_step_number', 500);
  
  %nrregr_options('default');
  %nrregr_options('max_step_size', 1e-7);

  for i=1:length(fig)
 
    close all
    switch fig(i)
      case 1 %% Chondrichthyes
        legend = {... % Chondrichthyes
          % Holocephali: edge black
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Chimaeriformes'; ...
          % Galeomorphi: edge blue
          {'o', 8, 3, [0 0 1], [0 0 0]}, 'Heterodontiformes'; .... 
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Orectolobiformes'; ....   
          {'o', 8, 3, [0 0 1], [1 0 1]}, 'Carcharhiniformes'; ....   
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Lamniformes'; ....   
          % Squalomorphi: edge magenta
          {'o', 8, 3, [1 0 1], [0 0 0]}, 'Squatiniformes'; ....   
          {'o', 8, 3, [1 0 1], [0 0 1]}, 'Pristiophoriformes'; ....   
          {'o', 8, 3, [1 0 1], [1 0 1]}, 'Squaliformes'; ....   
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Hexanchiformes'; ....   
          % Batoidea: edge red
          {'o', 8, 3, [1 0 0], [0 0 0]}, 'Rajiformes'; ....
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Rhinopristiformes'; ....
          {'o', 8, 3, [1 0 0], [1 0 1]}, 'Myliobatiformes'; ....
          {'o', 8, 3, [1 0 0], [1 1 1]}, 'Torpediniformes'; ....
        };

        WWbR = read_stat(select('Chondrichthyes'), {'Ww_i','Ww_b', 'R_i'}); n_data = size(WWbR,1);% source data
        logW_range = [log10(min(WWbR(:,1))), log10(max(WWbR(:,1)))]; % range of Ww_i
        WWb = WWbR(:,[1 2]); WR = WWbR(:,[1 3]); WRWbW = [WWbR(:,1), WWbR(:,2) .* WWbR(:,3) ./ WWbR(:,1)]; % 3 data sets

        xyw1 = [log10(WWb), ones(n_data,1)]; xyw2 = [log10(WR), ones(n_data,1)]; xyw3 = [log10(WRWbW), ones(n_data,1)];
        p = [-2;-1;.6;-.2]; info = 1;
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        if ~info
          fprintf('No convergence for Chondrichthyes\n');
        end
        ElogWb = p(1) + p(3) * logW_range; ElogR = p(2) + p(4) * logW_range; ElogRWbW = p(1) + p(2) + (p(3) + p(4) - 1) * logW_range; % expectations
        p_Chondrichthyes = 1e3*[10^p(1), p(3), 10^p(2), p(4), 10^p(1)*10^p(2), p(3) + p(4) - 1]

        %return
        
        sel_data = select_01('Chondrichthyes');
        data = NaN(n,2); 
        data(sel_data,:) = WWb;
  
        [hWwi_Wwb legend] = shstat(data, legend); 
        figure(hWwi_Wwb)
        plot(logW_range, ElogWb, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log weight at birth, g')
        print -r0 -dpng Wwi_Wwb_Chondrichthyes.png
        figure(hlegend)
        print -r0 -dpng legend_Chondrichthyes.png
    
        data(sel_data,:) = WR;
        hWwi_Ri = shstat(data, legend); 
        figure(hWwi_Ri)
        plot(logW_range, ElogR, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log ultimate reprod rate, #/d')
        print -r0 -dpng Wwi_Ri_Chondrichthyes.png

        data(sel_data,:) = WRWbW;
        hWwi_RiWW = shstat(data, legend); 
        figure(hWwi_RiWW)
        plot(logW_range, ElogRWbW, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
        print -r0 -dpng Wwi_RiWW_Chondrichthyes.png

      case 2 %% Actinopterygii
        legend = {... % Actinopterygii 
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Polypteriformes'; ...
          {'o', 8, 3, [0 0 0], [1 1 1]}, 'Acipenseriformes'; ...
          % 
          {'o', 8, 3, [0 0 1], [0 0 0]}, 'Holostei'; ....   
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Elopocephalai'; ....
          {'o', 8, 3, [0 0 1], [1 0 1]}, 'Osteoglossocephala'; ....
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Otomorpha'; ....     
          {'o', 8, 3, [0 0 1], [1 1 1]}, 'Lepidogalaxii'; ....  
          % 
          {'o', 8, 3, [1 0 1], [0 0 0]}, 'Protacanthopterygii'; ....
          {'o', 8, 3, [1 0 1], [0 0 1]}, 'Stomiati'; ....
          {'o', 8, 3, [1 0 1], [1 0 1]}, 'Aulopa'; ....
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Myctophata'; ....
          {'o', 8, 3, [1 0 1], [1 1 1]}, 'Lampridacea'; ....
          %
          {'o', 8, 3, [1 0 0], [0 0 0]}, 'Paracanthomorphacea'; ....
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Polymixiacea'; ....
          {'o', 8, 3, [1 0 0], [1 0 1]}, 'Berycimorphaceae'; ...
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Holocentrimorphaceae'; ...
          {'o', 8, 3, [1 0 0], [1 1 1]}, 'Percomorphaceae'; ...
        };

        WWbR = read_stat(select('Actinopterygii'), {'Ww_i','Ww_b', 'R_i'}); n_data = size(WWbR,1);% source data
        logW_range = [log10(min(WWbR(:,1))), log10(max(WWbR(:,1)))]; % range of Ww_i
        WWb = WWbR(:,[1 2]); WR = WWbR(:,[1 3]); WRWbW = [WWbR(:,1), WWbR(:,2) .* WWbR(:,3) ./ WWbR(:,1)]; % 3 data sets

        xyw1 = [log10(WWb), ones(n_data,1)]; xyw2 = [log10(WR), ones(n_data,1)]; xyw3 = [log10(WRWbW), ones(n_data,1)];
        p = [-3;-0.4;0;0.8]; info = 1;
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        if ~info
          fprintf('No convergence for Actinopterygii\n');
        end
        ElogWb = p(1) + p(3) * logW_range; ElogR = p(2) + p(4) * logW_range; ElogRWbW = p(1) + p(2) + (p(3) + p(4) - 1) * logW_range; % expectations
        p_Actinopterygii = 1e3*[10^p(1), p(3), 10^p(2), p(4), 10^p(1)*10^p(2), p(3) + p(4) - 1]

        %return
        
        sel_data = select_01('Actinopterygii');
        data = NaN(n,2); 
        data(sel_data,:) = WWb;
  
        [hWwi_Wwb hlegend] = shstat(data, legend); 
        figure(hWwi_Wwb)
        plot(logW_range, ElogWb, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log weight at birth, g')
        print -r0 -dpng Wwi_Wwb_Actinopterygii.png
        figure(hlegend)
        print -r0 -dpng legend_Actinopterygii.png
     
        data(sel_data,:) = WR;
        hWwi_Ri = shstat(data, legend); 
        figure(hWwi_Ri)
        plot(logW_range, ElogR, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log ultimate reprod rate, #/d')
        print -r0 -dpng Wwi_Ri_Actinopterygii.png

        data(sel_data,:) = WRWbW;
        hWwi_RiWW = shstat(data, legend); 
        figure(hWwi_RiWW)
        plot(logW_range, ElogRWbW, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
        print -r0 -dpng Wwi_RiWW_Actinopterygii.png

      case 3 %% Amphibia
        legend = {... % Amphibia
          % Gymnophiona: edge black
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Gymnophiona'; ...
          % Caudata: edge blue
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Cryptobranchoidea'; .... 
          {'o', 8, 3, [1 0 1], [0 0 0]}, 'Salamandroidea'; ....   
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Sirenoidea'; ....   
          % Anura: edge red
          {'o', 8, 3, [1 0 0], [0 0 0]}, 'Archaeobatrachia'; ....   
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Mesobatrachia'; ....   
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Neobatrachia'; ....   
        };

        WWbR = read_stat(select('Amphibia'), {'Ww_i','Ww_b', 'R_i'}); n_data = size(WWbR,1);% source data
        logW_range = [log10(min(WWbR(:,1))), log10(max(WWbR(:,1)))]; % range of Ww_i
        WWb = WWbR(:,[1 2]); WR = WWbR(:,[1 3]); WRWbW = [WWbR(:,1), WWbR(:,2) .* WWbR(:,3) ./ WWbR(:,1)]; % 3 data sets

        xyw1 = [log10(WWb), ones(n_data,1)]; xyw2 = [log10(WR), ones(n_data,1)]; xyw3 = [log10(WRWbW), ones(n_data,1)];
        p = [-2.4;-0.9;.5;.1]; info = 1;
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        if ~info
          fprintf('No convergence for Amphibia\n');
        end
        ElogWb = p(1) + p(3) * logW_range; ElogR = p(2) + p(4) * logW_range; ElogRWbW = p(1) + p(2) + (p(3) + p(4) - 1) * logW_range; % expectations
        p_Amphibia = 1e3*[10^p(1), p(3), 10^p(2), p(4), 10^p(1)*10^p(2), p(3) + p(4) - 1]

        %return
        
        sel_data = select_01('Amphibia');
        data = NaN(n,2); 
        data(sel_data,:) = WWb;
  
        [hWwi_Wwb hlegend] = shstat(data, legend); 
        figure(hWwi_Wwb)
        plot(logW_range, ElogWb, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log weight at birth, g')
        print -r0 -dpng Wwi_Wwb_Amphibia.png
        figure(hlegend)
        print -r0 -dpng legend_Amphibia.png
     
        data(sel_data,:) = WR;
        hWwi_Ri = shstat(data, legend); 
        figure(hWwi_Ri)
        plot(logW_range, ElogR, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log ultimate reprod rate, #/d')
        print -r0 -dpng Wwi_Ri_Amphibia.png

        data(sel_data,:) = WRWbW;
        hWwi_RiWW = shstat(data, legend); 
        figure(hWwi_RiWW)
        plot(logW_range, ElogRWbW, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
        print -r0 -dpng Wwi_RiWW_Amphibia.png

      case 4 %% Squamata
        legend = {... % Squamata
          % Gekkota: edge black
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Gekkota'; ...
          % Scinciformata: edge blue
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Scinciformata'; .... 
          % Laterata: edge magenta
          {'o', 8, 3, [1 0 1], [0 0 0]}, 'Teiformata'; ....   
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Lacertibaenia'; ....   
          % Toxifera: edge red
          {'o', 8, 3, [1 0 0], [0 0 0]}, 'Anguimorpha'; ....   
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Iguania'; ....   
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Serpentes'; ....   
        };

        WWbR = read_stat(select('Squamata'), {'Ww_i','Ww_b', 'R_i'}); n_data = size(WWbR,1);% source data
        logW_range = [log10(min(WWbR(:,1))), log10(max(WWbR(:,1)))]; % range of Ww_i
        WWb = WWbR(:,[1 2]); WR = WWbR(:,[1 3]); WRWbW = [WWbR(:,1), WWbR(:,2) .* WWbR(:,3) ./ WWbR(:,1)]; % 3 data sets

        xyw1 = [log10(WWb), ones(n_data,1)]; xyw2 = [log10(WR), ones(n_data,1)]; xyw3 = [log10(WRWbW), ones(n_data,1)];
        p = [-1.1;-1.7;.6;.2]; info = 1;
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        if ~info
          fprintf('No convergence for Squamata\n');
        end
        ElogWb = p(1) + p(3) * logW_range; ElogR = p(2) + p(4) * logW_range; ElogRWbW = p(1) + p(2) + (p(3) + p(4) - 1) * logW_range; % expectations
        p_Squamata = 1e3*[10^p(1), p(3), 10^p(2), p(4), 10^p(1)*10^p(2), p(3) + p(4) - 1]

        %return
        
        sel_data = select_01('Squamata');
        data = NaN(n,2); 
        data(sel_data,:) = WWb;
  
        [hWwi_Wwb hlegend] = shstat(data, legend); 
        figure(hWwi_Wwb)
        plot(logW_range, ElogWb, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log weight at birth, g')
        print -r0 -dpng Wwi_Wwb_Squamata.png
        figure(hlegend)
        print -r0 -dpng legend_Squamata.png

        data(sel_data,:) = WR;
        hWwi_Ri = shstat(data, legend); 
        figure(hWwi_Ri)
        plot(logW_range, ElogR, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log ultimate reprod rate, #/d')
        print -r0 -dpng Wwi_Ri_Squamata.png

        data(sel_data,:) = WRWbW;
        hWwi_RiWW = shstat(data, legend); 
        figure(hWwi_RiWW)
        plot(logW_range, ElogRWbW, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
        print -r0 -dpng Wwi_RiWW_Squamata.png

      case 5 %% Aves
        legend = {... % Aves
          % Crocodilia
          {'o', 8, 3, [0 0 0], [1 1 1]}, 'Crocodilia'; ...
          % 
          {'o', 8, 3, [0 0 1], [0 0 0]}, 'Paleognathae'; ...
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Galloanserae'; ....
          % Neoaves: edge magenta or red
          {'o', 8, 3, [1 0 1], [0 0 1]}, 'Mirandornithes'; ....
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Protelluraves'; ....
          % Passerea: edge red
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Ardeae'; ....
          {'o', 8, 3, [1 0 0], [1 0 1]}, 'Afroaves'; ....
          {'o', 8, 3, [1 0 0], [1 1 1]}, 'Australaves'; ....
        };

        WWbR = read_stat(select('Aves'), {'Ww_i','Ww_b', 'R_i'}); n_data = size(WWbR,1);% source data
        logW_range = [log10(min(WWbR(:,1))), log10(max(WWbR(:,1)))]; % range of Ww_i
        WWb = WWbR(:,[1 2]); WR = WWbR(:,[1 3]); WRWbW = [WWbR(:,1), WWbR(:,2) .* WWbR(:,3) ./ WWbR(:,1)]; % 3 data sets

        xyw1 = [log10(WWb), ones(n_data,1)]; xyw2 = [log10(WR), ones(n_data,1)]; xyw3 = [log10(WRWbW), ones(n_data,1)];
        p = [-0.8;-1.5;.8;-.2]; info = 1;
        % problem with NaN
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        if ~info
          fprintf('No convergence for Aves\n');
        end
        ElogWb = p(1) + p(3) * logW_range; ElogR = p(2) + p(4) * logW_range; ElogRWbW = p(1) + p(2) + (p(3) + p(4) - 1) * logW_range; % expectations
        p_Aves = 1e3*[10^p(1), p(3), 10^p(2), p(4), 10^p(1)*10^p(2), p(3) + p(4) - 1]

        %return
        
        sel_data = select_01('Aves');
        data = NaN(n,2); 
        data(sel_data,:) = WWb;
  
        [hWwi_Wwb hlegend] = shstat(data, legend); 
        figure(hWwi_Wwb)
        plot(logW_range, ElogWb, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log weight at birth, g')
        print -r0 -dpng Wwi_Wwb_Aves.png
        figure(hlegend)
        print -r0 -dpng legend_Aves.png
     
        data(sel_data,:) = WR;
        hWwi_Ri = shstat(data, legend); 
        figure(hWwi_Ri)
        plot(logW_range, ElogR, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log ultimate reprod rate, #/d')
        print -r0 -dpng Wwi_Ri_Aves.png

        data(sel_data,:) = WRWbW;
        hWwi_RiWW = shstat(data, legend); 
        figure(hWwi_RiWW)
        plot(logW_range, ElogRWbW, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
        print -r0 -dpng Wwi_RiWW_Aves.png

      case 6 %% Placentalia
        legend = {... % Placentalia
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Xenarthra'; ...
          {'o', 8, 3, [0 0 1], [1 0 1]}, 'Afrotheria'; ....
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Laurasiatheria'; ....
          {'o', 8, 3, [1 0 1], [1 0 1]}, 'Gliriformes'; ....
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Scandentia'; ....
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Dermoptera'; ....
          {'o', 8, 3, [1 0 0], [1 .5 .5]}, 'Primates'; ....
        };

        WWbR = read_stat(select('Placentalia'), {'Ww_i','Ww_b', 'R_i'}); n_data = size(WWbR,1);% source data
        logW_range = [log10(min(WWbR(:,1))), log10(max(WWbR(:,1)))]; % range of Ww_i
        WWb = WWbR(:,[1 2]); WR = WWbR(:,[1 3]); WRWbW = [WWbR(:,1), WWbR(:,2) .* WWbR(:,3) ./ WWbR(:,1)]; % 3 data sets

        xyw1 = [log10(WWb), ones(n_data,1)]; xyw2 = [log10(WR), ones(n_data,1)]; xyw3 = [log10(WRWbW), ones(n_data,1)];
        p = [-1.249;-1.1555;.946;-.2968]; info = 1;
        %[p, info] = nmregr('allo3', p, xyw1, xyw2, xyw3); % estimate pars
        if ~info
          fprintf('No convergence for Placentalia\n');
        end
        ElogWb = p(1) + p(3) * logW_range; ElogR = p(2) + p(4) * logW_range; ElogRWbW = p(1) + p(2) + (p(3) + p(4) - 1) * logW_range; % expectations
        p_Placentalia = 1e3*[10^p(1), p(3), 10^p(2), p(4), 10^p(1)*10^p(2), p(3) + p(4) - 1]

        %return
        
        sel_data = select_01('Placentalia');
        data = NaN(n,2); 
        data(sel_data,:) = WWb;
  
        [hWwi_Wwb hlegend] = shstat(data, legend); 
        figure(hWwi_Wwb)
        plot(logW_range, ElogWb, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log weight at birth, g')
        %print -r0 -dpng Wwi_Wwb_Placentalia.png
        figure(hlegend)
        %print -r0 -dpng legend_Placentalia.png
   
        data(sel_data,:) = WR;
        hWwi_Ri = shstat(data, legend); 
        figure(hWwi_Ri)
        plot(logW_range, ElogR, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log ultimate reprod rate, #/d')
        %print -r0 -dpng Wwi_Ri_Placentalia.png

        data(sel_data,:) = WRWbW;
        hWwi_RiWW = shstat(data, legend); 
        figure(hWwi_RiWW)
        plot(logW_range, ElogRWbW, 'k', 'linewidth', 2);
        xlabel('_{10}log ultimate weight, g')
        ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
        %print -r0 -dpng Wwi_RiWW_Placentalia.png
    end
  end
