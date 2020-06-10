% main run PST
% Turki Haj Mohamad
% 4/5/2018
%% Initialization
clear ; close all; clc
%% ================= Loading Data ====================
t =0:.01:30;
signal = sin(t)'; % raw signal

figure
subplot(211)
plot(t,signal,'k')
grid on 
xlabel('time'),ylabel('signal')

%% ============== PST ========================
n_order = 30  ; % choose the order of fitting 

[xd,yd,Y,r,e,features_orthg]=Ex_features(signal,n_order);

disp('_________________')
disp('In this example:') 
disp('yd is the kernel density')
disp('Y is the approximated density')
disp('r is the Pearson''s correlation coefficient')
disp('e is the root mean square error')
disp('features_orthg is the coeffecients of orthogonal basis and the features in our approach')

subplot(212)
plot(xd,yd,'b','linewidth',1.2)
hold on 
plot(xd,Y,'-.r','linewidth',1.2)
grid on 
xlabel('signal'),ylabel('density')
legend('Estimated','Aproximated')