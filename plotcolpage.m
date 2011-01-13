function varargout=plotcolpage(filename,colname,colnum)
	sdds=sddsload(filename);
	numPages=sdds.pages;
	temp=converttovector(sdds.column.ElementName);
	disp(temp{colnum});
	x=zeros(numPages,1);
	for i=1:numPages
		temp=converttovector(sdds.column.(colname),i);
		x(i)=temp(colnum);
	end
	plot(x,'.-');
	varargout={x};
end
