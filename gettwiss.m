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
	if nargout > 0
		varargout={betax(ind),alphax(ind),etax(ind),etaxp(ind),betay(ind),alphay(ind),etay(ind),etayp(ind)};
	else
		disp(['beta_x	= ' num2str(betax(ind))])
		disp(['alpha_x	= ' num2str(alphax(ind))])
		disp(['eta_x	= ' num2str(etax(ind))])
		disp(['etap_x	= ' num2str(etaxp(ind))])
		disp(['beta_y	= ' num2str(betay(ind))])
		disp(['alpha_y	= ' num2str(alphay(ind))])
		disp(['eta_y	= ' num2str(etay(ind))])
		disp(['etap_y	= ' num2str(etayp(ind))])
	end
end
