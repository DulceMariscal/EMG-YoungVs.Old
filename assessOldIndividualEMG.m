clear; close all;

load controls.mat;

%muscleOrder={'TA','MG','SEMT','VL','RF'};
muscleOrder={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'HIP', 'ADM', 'TFL', 'GLU'};

n_muscles = length(muscleOrder);
n_subjects = 16;
extremaMatrixOld = NaN(n_subjects,n_muscles * 2,2);

useLateAdaptAsBaseline=false;

ep=defineEpochOld();
refEp = defineReferenceEpoch(useLateAdaptAsBaseline,ep);

newLabelPrefix = defineMuscleList(muscleOrder);

%ll=controls.adaptData{1}.data.getLabelsThatMatch('^Norm');

ll =controls.adaptData{1}.data.getLabelsThatMatch('^(s|f)[A-Z]+_s');

l2=regexprep(regexprep(ll,'^Norm',''),'_s','s');
controls=controls.renameParams(ll,l2);

for i = 1:n_subjects
    adaptDataSubject = controls.adaptData{1, i}; 

    fh=figure('Units','Normalized','OuterPosition',[0 0 1 1]);
    ph=tight_subplot(1,length(ep)+1,[.03 .005],.04,.04);
    flip=true;

    adaptDataSubject.plotCheckerboards(newLabelPrefix,refEp,fh,ph(1,1),[],flip); %First, plot reference epoch:   
    [~,~,labels,dataE{1},dataRef{1}]=adaptDataSubject.plotCheckerboards(newLabelPrefix,ep,fh,ph(1,2:end),refEp,flip);%Second, the rest:

    set(ph(:,1),'CLim',[-1 1]);
    set(ph(:,2:end),'YTickLabels',{},'CLim',[-1 1].*.5);
    set(ph,'FontSize',8)
    pos=get(ph(1,end),'Position');
    axes(ph(1,end))
    colorbar
    set(ph(1,end),'Position',pos);
    
    extremaMatrixOld(i,:,1) =  min(dataRef{1});
    extremaMatrixOld(i,:,2) =  max(dataRef{1});
    
end