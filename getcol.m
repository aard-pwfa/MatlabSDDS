function varargout=getcol(filename,colname)
	sdds=sddsload(filename);
	
	if strcmp(sdds.description.text,'FirstPointRef')
		first=2;
	else
		first=1;
	end
	switch class(colname)
		case 'char'
			out=converttovector(sdds.column.(colname));
			out={out(first:end)};
		case 'cell'
			colsize=size(colname,2)
			out=cell(colsize,1);
			for i=1:colsize
				out{i}=converttovector(sdds.column.(colname{i}));
				out{i}=out{i}(first:end);
			end
	end
	varargout=out;
end
