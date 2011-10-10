function out=emit(x,xp)
	xmean=mean(x);
	xpmean=mean(xp);
	sx2=sum((x-xmean).^2);
	sxp2=sum((xp-xpmean).^2);
	sxxp=sum((x-xmean).*(xp-xpmean));
	out=sqrt(sx2*sxp2-sxxp^2)/size(x,1);
end
