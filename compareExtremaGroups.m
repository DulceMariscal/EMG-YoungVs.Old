clear; close all;

% load('extremaMatrixOld.mat')
% load('extremaMatrixOldAllMuscles.mat')
load('/Users/samirsherlekar/Desktop/emg/Data/extremaMatrixYoungFastBaseline.mat');
load('/Users/samirsherlekar/Desktop/emg/Data/extremaMatrixYoung.mat')
 
[min_M2, max_M2, ratio_M2] = getExtremaMatrix(extremaMatrixYoungFastBaseline);
[min_M, max_M, ratio_M] = getExtremaMatrix(extremaMatrixYoung);

%muscleOrder={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'HIP', 'ADM', 'TFL', 'GLU'};
muscleOrder={'TA','MG','SEMT','VL','RF'};
n_muscles = length(muscleOrder);


%plotExtremaEmgVoltages(n_muscles,muscleOrder,min_M,10^-6,'Min EMG Voltages for Old Subjects : All Muscles')
%plotExtremaEmgVoltages(n_muscles,muscleOrder,max_M,10^-5,'Max EMG Voltages for Old Subjects : All Muscles')
%plotExtremaEmgVoltages(n_muscles,muscleOrder,ratio_M,5,'Ratio of Max/Min EMG Voltages For Old Subjects : All 15 Muscles')

%plotExtremaEmgVoltages(n_muscles,muscleOrder,min_M,10,'Min EMG Voltages For Young Subjects : Fast Baseline', [10e-7 1e-5])
%plotExtremaEmgVoltages(n_muscles,muscleOrder,min_M2,10,'Min EMG Voltages For Young Subjects : Baseline', [10e-7 1e-5])

%plotExtremaEmgVoltages(n_muscles,muscleOrder,max_M,10,'Max EMG Voltages For Young Subjects : Fast Baseline', [3e-6 1e-4])
%plotExtremaEmgVoltages(n_muscles,muscleOrder,max_M2,10,'Max EMG Voltages For Young Subjects : Baseline',[3e-6 1e-4])


plotExtremaRatioEmgVoltages(ratio_M,ratio_M2)


%plotExtremaRatioEmgVoltages(min_M,min_M2)
%plotExtremaRatioEmgVoltages(max_M,max_M2)