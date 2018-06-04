function plotExtremaEmgVoltages(n_muscles, muscleOrder,extremaMatrix,numberOfIncrements,plot_title,scale)
    
    if(nargin < 6 || isempty(scale))
        lower_bound = min(min(extremaMatrix));
        upper_bound = max(max(extremaMatrix));
        scale = [lower_bound upper_bound];      
    end
    
    yTickIncrement = (scale(2) - scale(1))/numberOfIncrements;
    
    fh = figure;        
    plot((1:n_muscles),extremaMatrix(1:n_muscles,:),'o');
    hold on
    plot((1:n_muscles)+.2,extremaMatrix(n_muscles+1:n_muscles*2,:),'d','LineWidth',3)   
    title(plot_title)
    set(gca,'XTick',1:n_muscles,'XTickLabel',muscleOrder,'YScale','log','Ytick',scale(1):yTickIncrement:scale(2),'ylim',scale)
    ytickformat('%.2e');
    grid on
    
    saveas(fh,['./Figures/' plot_title '.png'])


end

