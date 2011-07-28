function varargout=plotcolumn(filename,colstr,formatstr)
	if nargin<3
		formatstr='-';
	end
	if strcmp(class(filename),'cell')
		page=filename{2};
		filename=filename{1};
	else
		page=1;
	end

	sdds = sddsload(filename);
	if strcmp(sdds.description.text,'FirstPointRef')
		first=2;
	else
		first=1;
	end
	switch class(colstr)
		case 'char'
			figure;
			hold on;
			out=[];
			for i=1:size(page,2)
				y=converttovector(sdds.column.(colstr),page(i));
				y=y(first:end);
				plot(y,formatstr);
				addlabels('Array Index',colstr,'');
				out={[out y]};
			end
		case 'cell'
			disp('hi');
			x=converttovector(sdds.column.(colstr{1}),page);
			y=converttovector(sdds.column.(colstr{2}),page);
			x=x(first:end);
			y=y(first:end);
			class(x)
			class(formatstr)
			plot(x,y,formatstr);
			addlabels(colstr{1},colstr{2},'');
			out={x,y};
	end

	if nargout~=0
		varargout=out;
	end
end
