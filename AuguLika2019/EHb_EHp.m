   clear all
    close all
    
    shstat_options('x_transform', 'log10');
    shstat_options('y_transform', 'log10');
    shstat_options('x_label', 'on');
    shstat_options('y_label', 'on');

    figure(1) % E_Hb, E_Hp
    [Hfig Hleg] = shstat({'E_Hb','E_Hp'}, legend_RSED, '(A) maturity', 1);
    set(gca, 'FontSize', 15, 'Box', 'on')
    figure(Hfig)
    set(gca, 'FontSize', 15, 'Box', 'on')
    xlabel('maturity at birth, _{10}log E_H^b, J')
    ylabel('maturity at puberty, _{10}log E_H^p, J')
    saveas(gca, 'EHb_EHp.png')
    saveas(Hleg, 'legend_EHb_EHp.png')

    figure(3) % E_Hb/Lb^3, E_Hp/Lp^3
    vars = read_allStat('L_b','L_p','E_Hb','E_Hp');
    eHb = vars(:,3)./vars(:,1).^3; eHp = vars(:,4)./vars(:,2).^3;
    [Hfig Hleg] = shstat([eHb, eHp], legend_RSED, '(B) maturity density', 3);
    close(Hleg)
    figure(Hfig)
    set(gca, 'FontSize', 15, 'Box', 'on')
    xlabel('maturity density at birth E_H^b/ L_b^3, J/cm^3')
    ylabel('maturity density at puberty E_H^p/ L_p^3, J/cm^3')
    saveas(gca, 'EHLb_EHLp.png')
    
    figure(4) % E_Hb/z^3, E_Hp/z^3
    vars = read_allStat('z','s_M','E_Hb','E_Hp');
    eHb = vars(:,3)./(vars(:,1) .* vars(:,2)).^3; eHp = vars(:,4)./(vars(:,1) .* vars(:,2)).^3;
    [Hfig Hleg] = shstat([eHb, eHp], legend_RSED, '(C) maturity per ultimate volume', 4);
    close(Hleg)
    figure(Hfig)
    set(gca, 'FontSize', 15, 'Box', 'on')
    xlabel('maturity density at birth E_H^b/ L_\infty^3, J/cm^3')
    ylabel('maturity density at puberty E_H^p/ L_\infty^3, J/cm^3')
    saveas(gca, 'EHbz_EHpz.png')