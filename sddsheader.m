function [sdds] = sddsheader(filename)
	import SDDS.java.SDDS.*
	
	if nargin < 1
	    error('Not enough input arguments.')
	end
	
	sddsData = SDDSFile(filename);
	i = sddsData.readFile;
	if i == 0
	    error(char(sddsData.getErrors))
	end
	sdds.filename = sddsData.fileName;
	sdds.description.contents = sddsData.descriptionContents;
	if length(sdds.description.contents) == 0
	    sdds.description.contents = [];
	end
	sdds.description.text = sddsData.descriptionText;
	if length(sdds.description.text) == 0
	    sdds.description.text = [];
	end
	sdds.ascii = sddsData.asciiFile;
	sdds.parameter_names = char(sddsData.getParameterNames);
	sdds.array_names = char(sddsData.getArrayNames);
	sdds.column_names = char(sddsData.getColumnNames);
	sdds.pages = sddsData.pageCount;

	k = size(sdds.parameter_names,1);
	for j = 1:k
	    name = convertSDDSname(sdds.parameter_names(j,1:end));
	    type = sddsData.getParameterType(j-1);
	    eval(['sdds.parameter.',name,'.type = SDDSUtil.getTypeName(type);'])
	
	    units = sddsData.getParameterUnits(j-1);
	    if length(units) == 0
	        units = [];
	    end
	    eval(['sdds.parameter.',name,'.units = units;'])
	    
	    symbol = sddsData.getParameterSymbol(j-1);
	    if length(symbol) == 0
	        symbol = [];
	    end
	    eval(['sdds.parameter.',name,'.symbol = symbol;'])
	  
	    format_string = sddsData.getParameterFormatString(j-1);
	    if length(format_string) == 0
	        format_string = [];
	    end
	    eval(['sdds.parameter.',name,'.format_string = format_string;'])
	
	    description = sddsData.getParameterDescription(j-1);
	    if length(description) == 0
	        description = [];
	    end
	    eval(['sdds.parameter.',name,'.description = description;'])
	
	    if (type == SDDSUtil.SDDS_STRING) | (type == SDDSUtil.SDDS_CHARACTER)
	        values = char(sddsData.getParameterValue(j-1,1,0));
	        for i = 2:sdds.pages
	            values = char(values,sddsData.getParameterValue(j-1,i,0));
	        end
	        eval(['sdds.parameter.',name,'.data = values;'])
	    else
	        for i = 1:sdds.pages
	            eval(['sdds.parameter.',name,'.data(i) = sddsData.getParameterValue(j-1,i,0);'])
	        end
	    end
	end

end
