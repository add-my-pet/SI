  legend_Aves = {...
    {'^', 4, 2, [1 0 1], [1 1 1]}, 'Galliformes'; ....
    {'^', 4, 2, [0 0 1], [1 1 1]}, 'Anseriformes'; ....
    {'^', 4, 2, [1 0 0], [1 1 1]}, 'Paleognathae'; ....
    {'^', 4, 2, [0 1 0], [1 1 1]}, 'Neognathae'; ....
  };
 close all
 shstat_options('default');

 
 Wp = read_allStat({'Ww_i','p_Ti','c_T'}); Ww = Wp(:,1)/1e3; pT = Wp(:,2)/24/3600./Wp(:,3);
 hfig = shstat([Ww, pT], legend_Aves);
 figure(hfig)
 plot([-4;5],[-3;9*3/4-3],'-k') % slope 3/4 ref line
 plot([-3;2.5],[-2.7;5.5*0.82-2.7],'-k','linewidth',2) % slope 0.82 
 xlim([-4 5]); ylim([-4 5]);
 xlabel('log_{10} body mass (kg)')
 ylabel('log_{10} heat-generation rate (W)')
 title('Aves, 20 C')