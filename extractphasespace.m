function varargout=extractphasespace(filename,varargin)
	if nargin==1
		varargin={1};
	end
	sdds = sddsloadinc(filename,varargin{1});
	x    = converttovector(sdds.column.x);
	xp   = converttovector(sdds.column.xp);
	y    = converttovector(sdds.column.y);
	yp   = converttovector(sdds.column.yp);
	t    = converttovector(sdds.column.t);
	if nargout==8
		dt   = converttovector(sdds.column.dt);
	end
	p    = converttovector(sdds.column.p);
	pID  = converttovector(sdds.column.particleID);

	switch nargout
		case 0
			varargout = {size(x),1};
		case 4
			varargout = {x, xp, y, yp};
		case 6
			varargout = {x, xp, y, yp, t, p};
		case 7
			varargout = {x, xp, y, yp, t, p, pID};
		case 8
			varargout = {x, xp, y, yp, t, dt, p, pID};
		case 1
			c=299792458;
			dtm=t-mean(t);
			varargout={dtm*c};
	end
end
