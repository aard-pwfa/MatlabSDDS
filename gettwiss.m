function varargout=gettwiss(filename,ind)
	% X
	betax=getcol(filename,'betax');
	alphax=getcol(filename,'alphax');
	etax=getcol(filename,'etax');
	etaxp=getcol(filename,'etaxp');
	% Y
	betay=getcol(filename,'betay');
	alphay=getcol(filename,'alphay');
	etay=getcol(filename,'etay');
	etayp=getcol(filename,'etayp');
	varargout={betax,alphax,etax,etaxp,betay,alphay,etay,etayp};

end
