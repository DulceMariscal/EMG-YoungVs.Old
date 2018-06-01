clear all
close all
clc

load group_age.mat;
group_age{1}=group_age{1}.renameConditions({'gradual adaptation','OG post'},{'Adaptation','Washout'});


%% Get normalized parameters:
%Define parameters we care about:
mOrder={'TA','MG','SEMT','VL','RF'};
nMusc=length(mOrder);
type='s';
labelPrefix=fliplr([strcat('f',mOrder) strcat('s',mOrder)]); %To display
labelPrefixLong= strcat(labelPrefix,['_' type]); %Actual names

%Renaming normalized parameters, for convenience:
for k=1:length(group_age)
    ll=group_age{k}.adaptData{1}.data.getLabelsThatMatch('^Norm');
    l2=regexprep(regexprep(ll,'^Norm',''),'_s','s');
    group_age{k}=group_age{k}.renameParams(ll,l2);
end
newLabelPrefix=fliplr(strcat(labelPrefix,'s'));

eE=1;
eL=1;

ep_Y=defineEpochs({'BASE','eA','lA','eP','eRA'},{'TM base','Adaptation','Adaptation','Washout','readaptation'},[-40 15 -40 15 15],[eE eE eE eE eE],[eL eL eL eL eL],'nanmean');
baseEp_Y=defineEpochs({'Base'},{'TM base'}',[-40],[eE],[eL],'nanmean');

ep_O=defineEpochs({'BASE','eA','lA','eP','eSE'},{'TM base','Adaptation','Adaptation','Washout','Short exposure'},[-40 15 -40 15 10],[eE eE eE eE eE],[eL eL eL eL eL],'nanmean');
baseEp_O=defineEpochs({'Base'},{'TM base'}',[-40],[eE],[eL],'nanmean');

%extract data for stroke and controls separately
padWithNaNFlag=true;

[YdataEMG,labels]=group_age{1}.getPrefixedEpochData(newLabelPrefix,ep_Y,padWithNaNFlag);
[YBB,labels]=group_age{1}.getPrefixedEpochData(newLabelPrefix,baseEp_Y,padWithNaNFlag);
YdataEMG=YdataEMG-YBB; %Removing base

[OdataEMG,labels]=group_age{2}.getPrefixedEpochData(newLabelPrefix,ep_O,padWithNaNFlag);
[OBB,labels]=group_age{2}.getPrefixedEpochData(newLabelPrefix,baseEp_O,padWithNaNFlag);
OdataEMG=OdataEMG-OBB; %Removing base

%Flipping EMG:
YdataEMG=reshape(flipEMGdata(reshape(YdataEMG,size(labels,1),size(labels,2),size(YdataEMG,2),size(YdataEMG,3)),1,2),numel(labels),size(YdataEMG,2),size(YdataEMG,3));
OdataEMG=reshape(flipEMGdata(reshape(OdataEMG,size(labels,1),size(labels,2),size(OdataEMG,2),size(OdataEMG,3)),1,2),numel(labels),size(OdataEMG,2),size(OdataEMG,3));

%% Get all the eA, lA, eP vectors
shortNames_Y={'lB','eA','lA','eP','eRA'};
longNames_Y={'BASE','eA','lA','eP','eRA'};
for i=1:length(shortNames_Y)
    aux=squeeze(YdataEMG(:,strcmp(ep_Y.Properties.ObsNames,longNames_Y{i}),:));
    eval([shortNames_Y{i} '_Y=aux;']);
end
clear aux

shortNames_O={'lB','eA','lA','eP','eSE'};
longNames_O={'BASE','eA','lA','eP','eSE'};
for i=1:length(shortNames_O)
    aux=squeeze(OdataEMG(:,strcmp(ep_O.Properties.ObsNames,longNames_O{i}),:));
    eval([shortNames_O{i} '_O=aux;']);   
end

clear aux

%compute eAT
eAT_Y=fftshift(eA_Y,1);
eAT_O=fftshift(eA_O,1);

eRAT_Y = fftshift(eRA_Y,1);
eSET_O = fftshift(eSE_O,1);
%% Do group analysis:
rob='off';

ttY=table(-mean(eA_Y,2), mean(eAT_Y,2), -mean(lA_Y,2), mean(eP_Y,2)-mean(lA_Y,2),-mean(eRA_Y,2), mean(eRAT_Y,2),'VariableNames',{'eA','eAT','lA','eP_lA','eRA','eRAT'});
ttO=table(-mean(eA_O,2), mean(eAT_O,2), -mean(lA_O,2), mean(eP_O,2)-mean(lA_O,2),-mean(eSE_O,2), mean(eSET_O,2),'VariableNames',{'eA','eAT','lA','eP_lA','eSE','eSET'});

CmodelFit1a=fitlm(ttY,'eP_lA~ eRA+eRAT-1','RobustOpts',rob)
Clearn1a=CmodelFit1a.Coefficients.Estimate;
Clearn1aCI=CmodelFit1a.coefCI;
%Cr21a=uncenteredRsquared(CmodelFit1a);
%Cr21a=Cr21a.uncentered;
%disp(['Uncentered R^2=' num2str(Cr21a,3)])

SmodelFit1a=fitlm(ttO,'eP_lA~eA+eAT+lA-1','RobustOpts',rob)
Slearn1a=SmodelFit1a.Coefficients.Estimate;
Slearn1aCI=SmodelFit1a.coefCI;













%Sr21a=uncenteredRsquared(SmodelFit1a);
%Sr21a=Sr21a.uncentered;
%disp(['Uncentered R^2=' num2str(Sr21a,3)])

% %% Individual models::
% rob='off'; %These models can't be fit robustly (doesn't converge)
% %First: repeat the model(s) above on each subject:
% clear CmodelFitAll* ClearnAll* SmodelFitAll* SlearnAll* 
% 
% for i=1:size(eA_Y,2)
%     ttAll=table(-eA_Y(:,i), eAT_Y(:,i), -lA_Y(:,i), eP_Y(:,i)-lA_Y(:,i),'VariableNames',{'eA','eAT','lA','eP_lA'});
%     CmodelFitAll1a{i}=fitlm(ttAll,'eP_lA~eAT-1','RobustOpts',rob);
%     ClearnAll1a(i,:)=CmodelFitAll1a{i}.Coefficients.Estimate;
%     aux=uncenteredRsquared(CmodelFitAll1a{i});
%     Cr2All1a(i)=aux.uncentered;    
% end

% for i=1:size(eA_O,2)
%     ttAll=table(-eA_O(:,i), eAT_O(:,i), -lA_O(:,i), eP_O(:,i)-lA_O(:,i),'VariableNames',{'eA','eAT','lA','eP_lA'});
%     SmodelFitAll1a{i}=fitlm(ttAll,'eP_lA~eAT-1','RobustOpts',rob);
%     SlearnAll1a(i,:)=SmodelFitAll1a{i}.Coefficients.Estimate;
%     aux=uncenteredRsquared(SmodelFitAll1a{i});
%     Sr2All1a(i)=aux.uncentered;    
% end

%Magnitude analysis
% eAMagnC=NaN(15,1);
% ePMagnC=NaN(15,1);
% eAMagnC=NaN(15,1);
% ePMagnC=NaN(15,1);
% 
% for i=1:size(eA_Y,2)
%     eAMagnC(i,1)=norm(eA_Y(:,i));
%     ePMagnC(i,1)=norm([eP_Y(:,i)-lA_Y(:,i)]);
% end
% for i=1:size(eA_O,2)
%     eAMagnS(i,1)=norm(eA_O(:,i));
%     ePMagnS(i,1)=norm([eP_O(:,i)-lA_O(:,i)]);
% end
% 
% load([matDataDir,'bioData'])
% clear ageC ageS;
% for c=1:length(group_age{1}.adaptData)
%     ageC(c,1)=group_age{1}.adaptData{c}.getSubjectAgeAtExperimentDate;
%     ageS(c,1)=group_age{2}.adaptData{c}.getSubjectAgeAtExperimentDate;
%     genderC{c}=group_age{1}.adaptData{c}.subData.sex;
%     genderS{c}=group_age{2}.adaptData{c}.subData.sex;
%     affSide{c}=group_age{2}.adaptData{c}.subData.affectedSide;
% end
% 
% 
% FMselect=FM([1:6,8:16]);
% velSselect=velsS([1:6,8:16]);
% velCselect=velsC([1:6,8:16]);
% 
% tALL=table;
% tALL.group=cell(30,1);tALL.aff=cell(30,1);tALL.sens=NaN(30,1);
% tALL.group(1:15,1)={'control'};
% tALL.group(16:30,1)={'stroke'};
% tALL.group=nominal(tALL.group);
% tALL.gender=[genderC';genderS'];
% tALL.age=[ageC; ageS];
% tALL.aff(16:30)=affSide';
% tALL.vel=[velCselect';velSselect'];
% tALL.FM=[repmat(34,15,1);FMselect'];
% tALL.BM=[ClearnAll1a;SlearnAll1a];
% tALL.sens(16:30)=[3.61 3.61 2.83 2.83 6.65 3.61 3.61 6.65 2.83 6.65 4.56 3.61 3.61 3.61 6.65]';
% tALL.eAMagn=[eAMagnC;eAMagnS];
% tALL.ePMagn=[ePMagnC;ePMagnS];
% 
% 
% save([matDataDir,'RegressionResults.mat'],'Clearn1a','Clearn1aCI','Slearn1a','Slearn1aCI','tALL');
% 
% 
% % 
% % figure
% % set(gcf,'Color',[1 1 1])
% % x=[1,2];
% % subplot(2,3,1)
% % hold on
% % bar(x,[Clearn1a Slearn1a],'FaceColor',[0.5 0.5 0.5])
% % errorbar(x,[Clearn1a Slearn1a],[diff(Clearn1aCI)/2 diff(Slearn1aCI)/2],'Color','k','LineWidth',2,'LineStyle','none')
% % set(gca,'XLim',[0.5 2.5],'YLim',[0 1],'XTick',[1 2],'XTickLabel',{''},'FontSize',16)
% % ylabel('\beta_M group regression')
% % title('ADAPTATION OF FEEDBACK RESPONSES')
% % 
% % subplot(2,3,4)
% % hold on
% % bar(x,nanmean([ClearnAll1a SlearnAll1a]),'FaceColor',[0.5 0.5 0.5])
% % errorbar(x,nanmean([ClearnAll1a SlearnAll1a]),nanstd([ClearnAll1a SlearnAll1a])./sqrt(15),'Color','k','LineWidth',2,'LineStyle','none')
% % set(gca,'XLim',[0.5 2.5],'YLim',[0 1],'XTick',[1 2],'XTickLabel',{'CONTROL','STROKE'},'FontSize',16)
% % ylabel('\beta_M individual regressions')
% % 
% 
% 


