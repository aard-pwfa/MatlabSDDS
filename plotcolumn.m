function varargout=plotcolumn(filename,colstr,formatstr)
	if nargin<3
		switch class(colstr)
			case 'char'
				formatstr='-';
			case 'cell'
				formatstr={'-','-'};
		end
	end
	sdds = sddsload(filename);
	switch class(colstr)
		case 'char'
			y=converttovector(sdds.column.(colstr));
			plot(y,formatstr);
			addlabels('Array Index',colstr,'');
			out={y};
		case 'cell'
			x=converttovector(sdds.column.(colstr{1}));
			y=converttovector(sdds.column.(colstr{2}));
			plot(x,y);
			addlabels(colstr{1},colstr{2},'');
			out={x,y};
	end

	if nargout~=0
		varargout=out;
	end
end
