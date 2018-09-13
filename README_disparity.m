%% data structure

load('dataset_disparity.mat')
data

% data = 
% 
%   struct with fields:
% 
%     sensitivity: [8×2×61 double]
%     frequencies: [0.2352 0.3276 0.4563 0.6355 0.8851 1.2328 1.7171 2.3915]
%      
% the sensitivty field is the disparity sensitivity in arcmin-1, 
% the 3 dimensions are:
% - 8 frequencies tested
% - 2 repetitions
% - 61 subjects
% 
% the frequency field are the corrugation frequencies tested for each condition


%% example plot of the disparity sensitivity over the population

figure('Name','Disparity sensitivty')
hold on
plot(data.frequencies,mean(mean(data.sensitivity,3),2),'k')
set(gca,'XScale','log','YScale','log')
axis square 
grid on
xlabel('Spatial frequency (c/d)')
ylabel('Disparity sensitivity (arcmin^{-1})')

