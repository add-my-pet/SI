%% shregr_AmP
% Plots observations and model predictions AmP-style

%%
function shregr_AmP (func, p, varargin)
  %  created: 2001/09/07 by Bas Kooijman
  
  %% Syntax
  % <../shregr_AmP.m *shregr_AmP*> (func, p, varargin)
  
  %% Description
  % Plots observations and model predictions like shregr, not now in AmP style
  %
  % Input
  %
  % * func: character string with name of user-defined function;
  %    see <nrregr.html *nrregr*>
  % * p: (r,k) matrix with parameter values in p(:,1) 
  % * xywi: (ni,k) matrix with
  %
  %     xywi(:,1) independent variable
  %     xywi(:,2) dependent variable (optional)
  %     The number of data matrices xyw1, xyw2, ... is optional but >0
  %     but must match the definition of 'func'
  
  %% Remarks
  % Plot options can be set with <shregr_options.html *shregr_options*>.
  % Input as in <nrregr.html *nrregr*>. 
  % The plot-range can set optionally in a vector of length 2, with the lower and upper boundaries. 
  % The columns >1 in the parameter matrix are ignored. 
  % If column 2 in the data matrix is not present, model predictions are plotted only. 
  % The colums >2 in the data matrices are ignored. 
  
  %% Example of use
  % Assuming that function_name, pars, and data xy are defined properly: 
  % shregr_AmP('function_name', pars, xy), or if the user-defined function codes for two data sets, 
  %  for instance shregr('function_name', pars, xy1, xy2). 

  i = 1; % initiate data set counter
  ci = num2str(i); % character string with value of i
  nxyw = nargin - 2; % number of data sets
  colors = plotColors(nxyw);
  while (i <= nxyw) % loop across data sets
    eval(['xyw', ci, ' = varargin{i};']); % assing unnamed arguments to xywi
    eval(['[n(', ci, ') k] = size(xyw', ci, ');']); % number of data points
    if i == 1
      listxyw = ['xyw', ci,',']; % initiate list xyw
      listX = ['X', ci,',']; % initiate list X
      listf = ['f', ci,',']; % initiate list f
      listg = ['g', ci,',']; % initiate list g
    else     
      listxyw = [listxyw, ' xyw', ci,',']; % append list xyw
      listX = [listX, ' X', ci,',']; % append list X
      listf = [listf, ' f', ci,',']; % append list f
      listg = [listg, ' g', ci,',']; % append list g
    end
    i = i + 1;
    ci = num2str(i); % character string with value of i
  end
  
  [i, nl] = size(listxyw); listxyw = listxyw(1:(nl-1)); % remove last ','
  [i, nl] = size(listX); listX = listX(1:(nl-1)); % remove last ','
  [i, nl] = size(listf); listf = listf(1:(nl-1)); % remove last ','
  [i, nl] = size(listg); listg = listg(1:(nl-1)); % remove last ','
  
  p = p(:,1); % remove other columns from parameter data
  
  global dataset Range all_in_one XTXT YTXT; % option settings
  
  %% set options if necessary
  if prod(size(dataset)) == 0 % select data sets to be plotted
    dataset = 1:nxyw;
  end

  if prod(size(all_in_one)) == 0 % all graphs in one
    all_in_one = 0;
  end
   
  if prod(size(Range)) == 0 % set plot ranges
    Range = zeros (nxyw, 2);
    for i = 1:nxyw
      ci = num2str(i);
      eval(['r0 = 0.9*min(xyw', ci, '(:,1));']);
      eval(['r1 = 1.1*max(xyw', ci, '(:,1));']);
      Range(i,:) = [r0, r1];
    end
  end
  
  [nr, i] = size(Range);
  if nr ~= nxyw % set plot ranges, because existing ones are invalid
    Range = zeros (nxyw, 2);
    for i = 1:nxyw
      ci = num2str(i);
      eval(['r0 = 0.9*min(xyw', ci, '(:,1));']);
      eval(['r1 = 1.1*max(xyw', ci, '(:,1));']);
      Range(i,:) = [r0, r1];
    end
  end
  
  for i = 1:nxyw % set plot labels
    ci = num2str(i);
    if prod(size(XTXT)) == 0
      XTXT = cell(nxyw,1);
    end
    if prod(size(YTXT)) == 0
      YTXT = cell(nxyw,1);
    end    
  end
    
  nS = max(size(dataset)); % set number of data sets to be plotted  

  for i = 1:nxyw  %% set independent variables
    eval(['X', num2str(i), ' = linspace(', ...
	  num2str(Range(i,1)), ', ', num2str(Range(i,2)), ', 100)'';']);
  end
  
  %% get dependent variables
  eval(['[', listf,'] = ', func, '(p,', listX,' );']);
  eval(['[', listg,'] = ', func, '(p,', listxyw,' );']);

  clf;
  %% gset nokey;
  hold on;

  % single plot mode
    for i = 1:nS % loop across data sets that must be plotted
      ci = num2str(dataset(i)); col = ['[', num2str(colors{i}),']'];
      eval(['plot(X', ci, '(:, 1), f', ci, ', ''LineWidth'', 2, ''Color'', ', col, ');']);
      eval(['[nr nc] = size(xyw', ci, ');']);
      if nc>1
        eval(['plot(xyw', ci, '(:,1), xyw', ci, '(:,2), ', '''.'', ''MarkerSize'', ', num2str(12), ',  ''Color'', ', col ');']);
%         for j = 1:n(dataset(i)) % connect data points with curves
% 	      eval(['plot([xyw', ci, '(j,[1 1])''],' ...
% 	        '[xyw', ci, '(j,2); g', ci, '(j)], ''m'');']);
%         end
      end
      if i == 1 % set labels
	    xlabel (char(XTXT{i}));
        ylabel (char(YTXT{i}));
      end  
    end

  end
