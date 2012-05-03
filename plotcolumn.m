function varargout=plotcolumn(filename,colstr,formatstr)
	% No format specified: mark dots on graph
	if nargin<3
		formatstr='.-';
	end

	% If page is specified:
	% plotcolumn({"filename",page}, ...)
	if strcmp(class(filename),'cell')
		page=filename{2};
		filename=filename{1};
	else
		page=1;
	end

	% Don't really remember what this is for...
	sdds = sddsload(filename);
	if strcmp(sdds.description.text,'FirstPointRef')
		first=2;
	else
		first=1;
	end

	% Plot as a function of index:
	%	plotcolumn(filename, "colstr", ...)
	% Plot versus two cols:
	%	plotcolumn(filename, {"colstr","colstr"}, ...)
	switch class(colstr)
		% Plot as a function of index
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
		% Plot two columns
		case 'cell'
			% disp('hi');
			x=converttovector(sdds.column.(colstr{1}),page);
			y=converttovector(sdds.column.(colstr{2}),page);
			x=x(first:end);
			y=y(first:end);
			plot(x,y,formatstr);
			addlabels(colstr{1},colstr{2},'');
			out={x,y};
	end

	if nargout~=0
		varargout=out;
	end
end
