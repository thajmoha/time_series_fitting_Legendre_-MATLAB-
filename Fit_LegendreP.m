% Fit_LegendreP
% Turki Haj Mohamad
% 4/5/2018
% _________________________________________________________________________
% input  --> signal (time series)
%        --> n_order (order of fitting)

% output --> A (coeffecients)
%        --> Y2 (approximated density)
%        --> r the (Pearson's correlation coefficient) 
%        --> e (root mean square error) 

%__________________________________________________________________________
function [A, Y2, r, e] = Fit_LegendreP(signal, n_order)

%%% compute the Legendre polynomial coefficients matrix coeff
% coeff(i,j) gives the polynomial coefficient for term x^{j-1} in P_{i-1}(x)
if n_order > 1
    coeff = zeros(n_order+1);
    coeff([1 n_order+3]) = 1; % set coefficients of P_0(x) and P_1(x)
    % now compute for higher order: nP_n(x) = (2n-1)xP_{n-1}(x) - (n-1)P_{n-2}(x)
    for ii = 3:n_order+1
        coeff(ii,:) = (2-1/(ii-1))*coeff(ii-1,[end 1:end-1]) - (1-1/(ii-1))*coeff(ii-2,:);
    end
else
    % simple case
    coeff = eye(n_order+1);
end

m = length(signal);
X = -1:2/(m-1):1; % Legendre polynomials are supported for |x|<=1
signal = signal(:); % make it a column
X = X(:);

%%% Evaluate the polynomials for every element in X
D = cumprod([ones(m,1) X(:,ones(1,n_order))], 2) * coeff.';

A = (D.'*D)\(D.'*signal); % inverting the normal equations matrix directly 

% fitting (regression) result
Y2 = D*A; 

%%% Compute some numerical indicators of how well the fitting is
% Pearson's correlation coefficient
a = signal-mean(signal);
b = Y2-mean(Y2);
r = a.'*b / sqrt((a.'*a)*(b.'*b)); 
% root mean square error (RMSE)
Z = signal-Y2; % residuals
e = sqrt(Z.'*Z/m); 
% e2 = norm(Z); % e = e2/sqrt(m);

end

