function varargout=coreEmittance(filename,fraction)
	display('This calculation expects a corresponding .twi file with the last Twiss entry corresponding to the particle dump!');
	sdds=sddsload(filename);
	unix(['sddsanalyzebeam ' filename ' ' filename '.ana']);

	[x,xp,y,yp,t,p,pID]=extractphasespace(filename);
	partlist=[pID, x, xp, y, yp, t, p];
	% size(partlist)
	numParts=size(pID,1)
	targetParts=round(numParts*fraction)
	

	% Loads emittance from analyzed particle file
	ex     = getcol([filename '.ana'],'ex');
	ey     = getcol([filename '.ana'],'ey');
	% =========================================================
	% =========================================================
	% 		Pick a twiss loading method here.
	% =========================================================
	% =========================================================
	% ---------------------------------------------------------
	% Loads twiss parameters from .twi file.
	% ---------------------------------------------------------
	betax  = getcol([filename '.twi'],'betax');
	betay  = getcol([filename '.twi'],'betay');
	alphax = getcol([filename '.twi'],'alphax');
	alphay = getcol([filename '.twi'],'alphay');
	betax  = betax(end);
	betay  = betay(end);
	alphax  = alphax(end);
	alphay  = alphay(end);
	% ---------------------------------------------------------
	% Loads twiss pparameters from analyzed particle file.
	% ---------------------------------------------------------
	% betax  = getcol('momentumscan.out.ana','betax');
	% betay  = getcol('momentumscan.out.ana','betay');
	% alphax = getcol('momentumscan.out.ana','alphax');
	% alphay = getcol('momentumscan.out.ana','alphay');
	% =========================================================
	% =========================================================
	% Calculates gamma from alpha, beta.
	gammax = (1+alphax^2)/betax;
	gammay = (1+alphay^2)/betay;
	twiss = struct('ex',ex,'ey',ey,'betax',betax,'betay',betay,'alphax',alphax,'alphay',alphay,'gammax',gammax,'gammay',gammay);

	csparamx = [betax, alphax, gammax,ex];
	csparamy = [betay, alphay, gammay,ey];
	
	% Since each particle is summed over, the contribution
	% of each particle to the 4-D emittance is calc. first.
	% The requested fraction with the smallest contributions
        % are kept.
	begfrac=0;
	endfrac=10;
	midfrac=mean([begfrac,endfrac]);
	midpt=-1;
	xarea=gammax*x.^2+2*alphax.*x.*xp+betax.*xp.^2;
	yarea=gammay*y.^2+2*alphay.*y.*yp+betay.*yp.^2;
	emit4d=xarea/ex+yarea/ey;

	partlist = [partlist, xarea, yarea, emit4d];
	
	psorted=sortrows(partlist,10);
	
	pcut=psorted(1:round(numParts*fraction),:);
	ex=emit(pcut(:,2),pcut(:,3))

	todump=psorted(targetParts+1:end,:);
	dumpparts(todump,sdds,'rejected.out');
	dumpparts(pcut,sdds,'saved.out');
	varargout={psorted(round(numParts*fraction),:),twiss};
	unix('sddsanalyzebeam saved.out saved.out.ana');
	unix(['sddsprintout ' filename '.ana -col=ecn*'])
	unix('sddsprintout saved.out.ana -col=ecn*')
end

function varargout=numInEllipse(partlist,frac,ex,ey)
	bx=partlist(:,8)<frac*ex;
	by=partlist(:,9)<frac*ey;
	% sum(by)
	bool=bx&by;
	tot=sum(bool);

	if nargout==2
		varargout={tot,bool};
	else
		varargout={tot};
	end
end

function dumpparts(todump,sdds,filename)
	sdds.column.x.page1          = todump(:,2);
	sdds.column.xp.page1         = todump(:,3);
	sdds.column.y.page1          = todump(:,4);
	sdds.column.yp.page1         = todump(:,5);
	sdds.column.t.page1          = todump(:,6);
	sdds.column.p.page1          = todump(:,7);
	sdds.column.particleID.page1 = todump(:,1);
	sdds.ascii=1;
	sddssave(sdds,filename);

end

function varargout=sigfrac(partlist,frac)

	x  = partlist(:,2);
	xp = partlist(:,3);
	y  = partlist(:,4);
	yp = partlist(:,5);
	t  = partlist(:,6);
	p  = partlist(:,7);

	xc  = x  - mean(x);
	xpc = xp - mean(xp);
	yc  = y  - mean(y);
	ypc = yp - mean(yp);
	tc  = t  - mean(t);
	pc  = p  - mean(p);

	sigx  = std(xc);
	sigxp = std(xpc);
	sigy  = std(yc);
	sigyp = std(ypc);
	sigt  = std(tc);
	sigp  = std(pc);

	bx  = abs(xc)  < frac*sigx;
	bxp = abs(xpc) < frac*sigxp;
	by  = abs(yc)  < frac*sigy;
	byp = abs(ypc) < frac*sigyp;
	bt  = abs(tc)  < frac*sigt;
	bp  = abs(pc)  < frac*sigp;
	
	bool=bx|bxp|by|byp|bt|bp;
	tot=sum(bool);

	if nargout==2
		varargout={tot,bool}
	else
		varargout={tot};
	end
end
