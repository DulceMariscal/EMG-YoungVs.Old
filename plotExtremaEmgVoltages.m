function plotExtremaEmgVoltages(n_muscles, muscleOrder,extremaMatrix,yTickIncrement,plot_title)
    
    fh = figure;    
    
    plot((1:n_muscles),extremaMatrix(1:n_muscles,:),'o');
    hold on
    plot((1:n_muscles)+.4,extremaMatrix(n_muscles+1:n_muscles*2,:),'d','LineWidth',3)
        
    title(plot_title)
    set(gca,'XTick',1:n_muscles,'XTickLabel',muscleOrder,'YScale','log','Ytick',min(min(extremaMatrix)):yTickIncrement:max(max(extremaMatrix)))
    axis tight;
    grid on
    


end

