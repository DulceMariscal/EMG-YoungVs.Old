function labellist = getLabel(normalizedTMFullAbrupt)
    labellist = normalizedTMFullAbrupt.adaptData{1}.data.getLabelsThatMatch('^(s|f)[A-Z]+_s');
    
end