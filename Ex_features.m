% PST function
% Turki Haj Mohamad
% 4/5/2018
% _________________________________________________________________________
% input  --> signal (time series)
%        --> n_order (order of fitting)

% output --> xd (density x axis)
%        --> yd (estimated density y axis)
%        --> Y (approximated density)
%        --> features_orthg (features)
%        --> r the (Pearson's correlation coefficient) 
%        --> e (root mean square error) 

%__________________________________________________________________________
function [xd,yd,Y,r,e,features_orthg]=Ex_features(signal,n_order)
data = signal;
h = std(data)*(4/3/numel(data))^(1/5);
[yd,xd]=ksdensity(signal,'bandwidth',h);
  
% idx=find(yd<0.05);
%     xd1=removerows(xd',idx);
%     yd1=removerows(yd',idx);
[A, Y, r, e]=Fit_LegendreP(yd,n_order);

features_orthg=[A']; % beta
end
%__________________________________________________________________________




