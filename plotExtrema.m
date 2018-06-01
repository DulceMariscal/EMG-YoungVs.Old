clear; close all;

% load('extremaMatrixYoung.mat')
% load('extremaMatrixOld.mat')
load('extremaMatrixOldAllMuscles.mat')

[min_M, max_M, ratio_M] = getExtremaMatrix(extremaMatrixOldAllMuscles);

muscleOrder={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'HIP', 'ADM', 'TFL', 'GLU'};
n_muscles = length(muscleOrder);


plotExtremaEmgVoltages(n_muscles,muscleOrder,min_M,10^-6,'Min EMG Voltages for Old Subjects : All Muscles')
plotExtremaEmgVoltages(n_muscles,muscleOrder,max_M,10^-5,'Max EMG Voltages for Old Subjects : All Muscles')
plotExtremaEmgVoltages(n_muscles,muscleOrder,ratio_M,5,'Ratio of Max/Min EMG Voltages For Old Subjects : All 15 Muscles')


% figure;
% plot([1:5]+.2,ratioY(1:5,:),'o','MarkerEdgeColor','b');
% hold on
% plot([1:5]+.4,ratioY(6:10,:),'d','MarkerEdgeColor','b');
% hold on 
% plot([1:5]+.6,ratioO(1:5,:),'o','MarkerEdgeColor','r');
% hold on 
% plot([1:5]+.8,ratioO(6:10,:),'d','MarkerEdgeColor','red');
% 
% title('Ratio of Max to Min EMG Voltages')
% legend('blue = young','red = old', 'circle = fast leg', 'diamond = slow leg');
% set(gca,'XTick',1:5,'XTickLabel',{'TA','MG','SEMT','VL','RF'},'YScale','log','Ytick',(0:5:60))
% axis([.8 6 1 100]);
% grid on;
