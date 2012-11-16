function h=hist2dSDDS(filename,xl,yl,res,varargin)
%HIST2DSDDS(filename,xl,yl,res,...) Generates 2D histogram from SDDS data.
%	HIST2DSDDS(filename,xl,yl,res) plots a histogram of an SDDS particle file
%		with coordinates xl on the x axis and yl on the y axis.
%		(Options are particle coordinates x, y, xp, yp, dz, dp.)
%		The number of bins is given by res.
	if nargin==4
		pagenum=1;
	else
		pagenum=varargin{1};
	end
	switch nargin
		case 5
			nstd=20;
		case 6
			nstd=varargin{2};
		otherwise
			nstd=inf
	end
	if exist(filename,'dir')==7
		filename=[filename '/' sprintf('%3.3i',pagenum) '.out'];
		pagenum=1;
	end
	[x,xp,y,yp,t,p]=extractphasespace(filename,pagenum);
	c=299792458;
	dz=(t-mean(t))*c;
	dp=p/mean(p)-1;
	xs=eval(xl);
	ys=eval(yl);
	bool=(xs-mean(xs) > nstd*std(xs));
	xs(bool)=[];
	ys(bool)=[];
	hist2d(xs,ys,res);
	tl=[yl ' vs. ' xl];
	addlabels(xl,yl,tl);
end
