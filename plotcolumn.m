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
	if sdds.description.text=='FirstPointRef'
		first=2;
	else
		first=1;
	end
	switch class(colstr)
		case 'char'
			y=converttovector(sdds.column.(colstr));
			y=y(first:end);
			plot(y,formatstr);
			addlabels('Array Index',colstr,'');
			out={y};
		case 'cell'
			x=converttovector(sdds.column.(colstr{1}));
			y=converttovector(sdds.column.(colstr{2}));
			x=x(first:end);
			y=y(first:end);
			plot(x,y);
			addlabels(colstr{1},colstr{2},'');
			out={x,y};
	end

	if nargout~=0
		varargout=out;
	end
end
