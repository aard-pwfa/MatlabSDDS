function varargout=plotyycolumn(filename,colstr,formatstr)
	if nargin<3
		formatstr={'-','-'};
	end
	sdds = sddsload(filename);
	x=converttovector(sdds.column.(colstr{1}));
	y=converttovector(sdds.column.(colstr{2}));
	arrayind=1:size(x,1);
	[AX,H1,H2]=plotyy(arrayind,x,arrayind,y);
	set(get(AX(1),'Ylabel'),'String',colstr{1});
	set(get(AX(2),'Ylabel'),'String',colstr{2});
	set(H1,'LineStyle',formatstr{1});
	set(H2,'LineStyle',formatstr{2});
	out={x,y,AX,H1,H2};

	if nargout~=0
		varargout=out;
	end
end
