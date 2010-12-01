function y=plotparam(filename,x,y,pagenum,format)
	if nargin <= 3
		pagenum=1;
       		format='bo';
	elseif nargin == 4
		if ~isnumeric(pagenum)
			pagenum=eval(pagenum);
		end
		format='bo';
	elseif nargin == 5
		if ischar(pagenum) 
			if ischar(format)
				pagenum=eval(pagenum);
			else
				temp=pagenum;
				pagenum=format;
				format=temp;
			end
		end
	end

	sdds=sddsload(filename);
	x=converttovector(filename.parameter.(x),pagenum);
	y=converttovector(filename.parameter.(y),pagenum);
	plot(x,y,'bo')
end

