function refEp = defineReferenceEpoch(useLateAdapBase,ep)
    if useLateAdapBase
        refEp=ep(strcmp(ep.Properties.ObsNames,'LateA'),:); %ref Epoch = lateAdap
    else       
        refEp=ep(strcmp(ep.Properties.ObsNames,'Base'),:); %ref Epoch = baseline
    end
    refEp.Properties.ObsNames{1}=['Ref: ' refEp.Properties.ObsNames{1}];
end