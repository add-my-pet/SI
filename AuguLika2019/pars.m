    clear all
    close all
    
    shstat_options('y_label', 'on');

    figure(1) % E_Hb, E_Hp
    EHb = read_allStat('E_Hb'); 
    EHb_med = median(EHb); EHb_min = min(EHb); EHb_max = max(EHb); EHb_m = mean(EHb); EHb_v = var(EHb);
    EHb_x = 10.^linspace(log10(EHb_min),log10(EHb_max),500); 
    AB = wblfit(EHb, 0.05); % gives MLEs and 100(1-ALPHA)% CI
    A = AB(1); B = AB(2); S = 1-wblcdf(EHb,A,B);
    fprintf(['pars wbl for EHb: ', num2str(A), ' , ', num2str(B),'\n'])
    S = 1-wblcdf(EHb_x,A,B);
    plot(log10(EHb_x), S, '-', 'color', [0.75 0.75 1], 'linewidth', 8)
    hold on
    fprintf(['mean and variance for EHb: ', num2str(EHb_m), ' , ', num2str(EHb_v),'\n'])
    surv_EHb = surv(EHb);
    shstat_options('x_transform', 'log10')
    Hfig = shstat(EHb, {'b', 'b'}, [], 1);
    set(gca, 'FontSize', 15, 'Box', 'on')
    %xlabel('_{10}log E_H^b, J') 
    %saveas(gca, 'EHb.png')
    %
    EHp = read_allStat('E_Hp'); 
    EHp_med = median(EHp); EHp_min = min(EHp); EHp_max = max(EHp); EHp_m = mean(EHp); EHp_v = var(EHp);
    surv_EHp = surv(EHp); 
    EHp_x = 10.^linspace(log10(EHp_min),log10(EHp_max),500); 
    AB = wblfit(EHp, 0.05); % gives MLEs and 100(1-ALPHA)% CI
    A = AB(1); B = AB(2); S = 1-wblcdf(EHp,A,B);
    fprintf(['pars wbl for EHp: ', num2str(A), ' , ', num2str(B),'\n'])
    S = 1-wblcdf(EHp_x,A,B);
    plot(log10(EHp_x), S, '-', 'color', [1 0.75 0.75], 'linewidth', 8)
    hold on
    fprintf(['mean and variance for EHp: ', num2str(EHp_m), ' , ', num2str(EHp_v),'\n'])
    surv_EHp = surv(EHp); 
    Hfig = shstat(EHp, {'r', 'r'}, [], 1);
    set(gca, 'FontSize', 15, 'Box', 'on')
    xlabel('_{10}log E_H^b, E_H^p, J') 
    saveas(gca, 'EHbp.png')

    figure(2) % s_H, s_HL
    shstat_options('x_transform', 'none');
    sH = log10(EHb ./ EHp); 
    sH_med = median(sH); sH_min = min(sH); sH_max = max(sH); sH_m = mean(sH); sH_v = var(sH);
    sH_x = linspace(sH_min,sH_max,500); 
    AB = wblfit(10.^sH, 0.05); % gives MLEs and 100(1-ALPHA)% CI
    A = AB(1); B = AB(2); S = 1-wblcdf(EHb,A,B);
    fprintf(['pars wbl for 10^sH: ', num2str(A), ' , ', num2str(B),'\n'])
    S = 1-wblcdf(10.^sH_x,A,B);
    plot(sH_x, S, '-', 'color', [0.75 0.75 1], 'linewidth', 8)
    [Hfig Hleg] = shstat(sH,  {'b', 'b'}, [], 2);
    %xlabel('s_H^{bp}, -') 
    %saveas(gca, 'sH.png')
    %
    LL = read_allStat('L_b','L_p'); sHL = sH + 3*log10(LL(:,2)./LL(:,1));
    sHL_med = median(sHL); sHL_min = min(sHL); sHL_max = max(sHL); sHL_m = mean(sHL); sHL_v = var(sHL);
    sHL_x = linspace(sHL_min,sHL_max,500); 
    AB = wblfit(10.^sHL, 0.05); % gives MLEs and 100(1-ALPHA)% CI
    A = AB(1); B = AB(2); S = 1-wblcdf(sHL,A,B);
    fprintf(['pars wbl for 10^sHL: ', num2str(A), ' , ', num2str(B),'\n'])
    S = 1-wblcdf(10.^sHL_x,A,B);
    plot(sHL_x, S, '-', 'color', [1 0.75 0.75], 'linewidth', 8)
    [Hfig Hleg] = shstat(sHL,  {'r', 'r'}, [], 2);
    set(gca, 'FontSize', 15, 'Box', 'on')
    xlabel('_{10}log s_H^{bp}, s_{HL}^{bp}, -') 
    saveas(gca, 'sHL.png')


