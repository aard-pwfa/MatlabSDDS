function varargout=getColIndAcrossPg(filename,colname,index)
	sdds=sddsload(filename);
	pages=sdds.pages;
	out=zeros(pages,1);
	for i=1:pages
		temp=converttovector(sdds.column.(colname),i);
		out(i)=temp(index);
	end
	varargout={out};
end
