function scatplot(filename,xcol,ycol,pagenum,format)
	if nargin <= 3
		pagenum=1;
       		format='bo';
	elseif nargin == 4
		% For when the third argument is a format.
		if ~isnumeric(pagenum)
			format=pagenum;
			pagenum=1;
		end
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
	x=converttovector(sdds.column.(xcol),pagenum);
	y=converttovector(sdds.column.(ycol),pagenum);
	x=correct_p_dt(xcol,x,sdds);
	y=correct_p_dt(ycol,y,sdds);
	plot(x,y,format)
end

function x=correct_p_dt(xstr,x,sdds)
	switch lower(xstr)
		case 'dt'
			x=(x-mean(x))*299792458;
		case 'p'
			x=(x-mean(x))/sdds.parameter.pCentral.data;
	end
end
