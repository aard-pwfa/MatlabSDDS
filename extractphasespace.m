function varargout=extractphasespace(filename)
	sdds = sddsload(filename);
	x    = converttovector(sdds.column.x);
	xp   = converttovector(sdds.column.xp);
	y    = converttovector(sdds.column.y);
	yp   = converttovector(sdds.column.yp);
	t    = converttovector(sdds.column.t);
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
	end
end
