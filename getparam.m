function varargout=getparam(filename,paramname)
	[stat,result]=unix(['sddsprintout ' filename ' -param=''' paramname ''' | grep = | sed ''s/.*=\s*\(.*\)/\1/''']);
	temp = str2num(result);
	if isequal(size(temp),[0 0])
		varargout={result};
	else
		varargout={temp};
	end
end
