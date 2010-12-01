function [x,xp,y,yp,t,p]=extractphasespace(filename)
	sdds=sddsload(filename);
	x=converttovector(sdds.column.x);
	xp=converttovector(sdds.column.xp);
	y=converttovector(sdds.column.y);
	yp=converttovector(sdds.column.yp);
	t=converttovector(sdds.column.t);
	p=converttovector(sdds.column.p);
end
