function h=hist2dSDDS(filename,xs,ys,res,varargin)
	if nargin==4
		pagenum=1;
	else
		pagenum=varargin{1};
	end
	[x,xp,y,yp,t,p]=extractphasespace(filename,pagenum);
	c=299792458;
	dz=(t-mean(t))*c;
	dp=p/mean(p)-1;
	xs=eval(xs);
	ys=eval(ys);
	bool=(xs-mean(xs) > 20*std(xs));
	xs(bool)=[];
	ys(bool)=[];
	hist2d(xs,ys,res);
end
