function varargout=scatplot(filename,xcol,ycol,varargin)
%SCATPLOT Create scatter plot.

	if nargin <= 3
		pagenum=1;
       		format='bo';
	elseif nargin == 4
		pagenum=varargin{1};
		% For when the third argument is a format.
		if ~isnumeric(pagenum)
			format=pagenum;
			pagenum=1;
		else
			format='.';
		end
	elseif nargin == 5
		pagenum=varagin{1};
		format=varargin{2};
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

	sdds=loadpage(filename,pagenum);
	x=converttovector(sdds.column.(xcol));
	y=converttovector(sdds.column.(ycol));
	
	x=correct_p_dt(xcol,x,sdds);
	y=correct_p_dt(ycol,y,sdds);

	if nargout==2
		varargout={x,y};
	else
		plot(x,y,format)
	end
	% plot(x,y)
end

function x=correct_p_dt(xstr,x,sdds)
	switch lower(xstr)
		case 'dt'
			x=(x-mean(x))*299792458;
		case 'p'
			x=(x-mean(x))/sdds.parameter.pCentral.data;
	end
end
