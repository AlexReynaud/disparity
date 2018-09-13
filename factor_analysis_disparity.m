

%% data loading

load('dataset_disparity.mat')

% average two repetitions
sensitivitym=squeeze(mean(data.sensitivity,2));



%% svd decomposition


[u,s,v]=svd(sensitivitym');

% calculate percentage explained variance
explained = diag(s)/sum(diag(s));

% take opposite values for display purpose
v=-v;



%% factors rotation (requires stats toolobox)

% number of factors to use
numFactors=2;

% rotate factors
B=rotatefactors(v(:,1:numFactors));


%% compute regression coefficients and regressed sensitivitity

% calculate regression coefficients with the Moore-Penrose pseudo-inverse
coeffs=(pinv(B)*sensitivitym)';

% compute regressed sensitivities
regsens=(coeffs*B')';




%% display factors, explained variance and rotated factors

figure('Position',[100 100 800 300])

% color table for display
ctab=[  0         0    1.0000;...
    0    0.5000         0;...
    1.0000         0         0;...
    0    0.7500    0.7500;...
    0.7500         0    0.7500;...
    0.7500    0.7500         0;...
    0.2500    0.2500    0.2500;...
    1 .5 0]


% 1st panel

subplot(1,3,1)
hold on

% plot raw factors
for i=1:length(data.frequencies)
    plot(data.frequencies,v(:,i),'LineWidth',2,'Color',ctab(i,:))
end

% display options
grid on
set(gca,'XScale','log')
axis square
set(gca,'Box','on')
set(gca,'XTick',[ .1:.1:1 2 ])
set(gca,'XTickLabel',{[],[],'.3',[],'.5',[],[],[],[],'1','2'})
set(gca,'FontSize',10);
xlabel('Frequency (c/d)')
ylim([-1 1])


% 2nd panel

subplot(1,3,2)
hold on

% plot percentage explained variance
for i=1:length(data.frequencies)
    bar(i,explained(i),'Facecolor',ctab(i,:),'Edgecolor',ctab(i,:));
end

% display options
set(gca,'XTick',1:8)
set(gca,'FontSize',10);
xlabel('Components')
xlim([0 9])
box on
ylim([0 1])
axis square


% 3rd panel
subplot(1,3,3)
hold on

% plot rotated factors
for i=1:numFactors
    plot(data.frequencies,B(:,i),'LineWidth',2,'Color',ctab(i,:))
end

% display options
set(gca,'XScale','log')
axis square
set(gca,'Box','on')
set(gca,'XTick',[ .1:.1:1 2 ])
set(gca,'XTickLabel',{[],[],'.3',[],'.5',[],[],[],[],'1','2'})
set(gca,'FontSize',10);
xlabel('Frequency (c/d)')
ylim([-1 1])
grid on





%% display regressions and coefficients

figure('Position',[100 100 550 300])


% 1st panel

subplot(1,2,1)

% plot regressed sensitivities
for s=1:size(sensitivitym,2)
    hold on
    plot(data.frequencies,regsens(:,s)','Linewidth',.5)
end


% display options
axis square
grid on
set(gca,'XScale','log');
set(gca,'YScale','log');
ylim([.08 6])
xlim([.235 2.39])
set(gca,'Box','on')
set(gca,'XTick',[ .1:.1:1 2 ])
set(gca,'XTickLabel',{[],[],'.3',[],'.5',[],[],[],[],'1','2'})
set(gca,'FontSize',10);
xlabel('Frequency (c/d)')
ylabel('Stereo Sensitivity (arcmin^{-1})');


% 2nd panel

subplot(1,2,2)

% plot identity
plot([0.081 6],[0.081 6],'k:')

% plot coefficients
for s=1:size(sensitivitym,2)
    hold on
    plot(coeffs(s,1),coeffs(s,2),'+','Markersize',9,'Linewidth',2)
end

% display options
xlim([.08 6])
ylim([.08 6])
set(gca,'XScale','log')
set(gca,'YScale','log')
grid on
hold on
axis square
set(gca,'FontSize',10);
xlabel('Factor 1')
ylabel('Factor 2');


