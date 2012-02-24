function plottwiss(filename)
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
	% S
	s=getcol(filename,'s');

	% X plots
	subplot(2,2,1);
	s1=plot(s,betax,'.-',s,alphax,'.-')
	addlabels('s','\beta_x, \alpha_x','X Twiss Parameters')
	subplot(2,2,2);
	s2=plot(s,etax,'.-',s,etaxp,'.-')
	addlabels('s','\eta_x, \eta''_x','X Dispersion')

	% Y plots
	subplot(2,2,3);
	s1=plot(s,betay,'.-',s,alphay,'.-')
	addlabels('s','\beta_y, \alpha_y','Y Twiss Parameters')
	subplot(2,2,4);
	s2=plot(s,etay,'.-',s,etayp,'.-')
	addlabels('s','\eta_y, \eta''_y','Y Dispersion')
end
