function plotExtremaRatioEmgVoltages(ratio1, ratio2)
    figure;
    plot([1:5],ratio1(1:5,:),'o','MarkerEdgeColor','b');
    hold on
    plot([1:5]+.2,ratio1(6:10,:),'d','MarkerEdgeColor','b');
    hold on 
    plot([1:5]+.4,ratio2(1:5,:),'o','MarkerEdgeColor','r');
    hold on 
    plot([1:5]+.6,ratio2(6:10,:),'d','MarkerEdgeColor','red');
    
    title('Ratio of Max to Min EMG Voltages Fast vs. Baseline')
    legend('blue = baseline','red = fast baseline', 'circle = fast leg', 'diamond = slow leg');
    set(gca,'XTick',1:5,'XTickLabel',{'TA','MG','SEMT','VL','RF'},'YScale','log','Ytick',(0:5:60))
    axis([.8 6 0 60]);
    grid on;


end

