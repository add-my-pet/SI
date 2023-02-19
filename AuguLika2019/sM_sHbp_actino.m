%% log10 s_M - log10 s_Hbp for Actinopterygii

close all

shstat_options('default');


[Hfig Hleg] = shstat({'s_M', 's_Hbp'}, legend_Acti, ['Actinopterygii ', datestr(datenum(date),'yyyy/mm/dd')]);
close(Hleg); Hleg = shlegend(legend_actino, [], [], 'Actinopterygii');
set(gca, 'FontSize', 15, 'Box', 'on')

figure(Hfig) 
xlabel('_{10}log acceleration factor s_M, -')      
ylabel('_{10}log maturity ratio s_H^{bp}, -')

%saveas(Hfig, 'logsM_logsH_actino.png')
%saveas(Hleg, 'legend_logsM_logsH_actino.png')

