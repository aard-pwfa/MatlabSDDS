function sdds=loadpage(filename,varargin)
	sdds=sddsheader(filename);
	if sdds.pages>1
		if nargin==1
			page=1;
		else
			page=varargin{1};
		end
		pageStr=int2str(page);
		unix(['sddssplit ' filename ' -rootname=' filename ' -extension=split -firstPage=' pageStr ' -lastPage=' pageStr ' -interval=' pageStr]);
		tempfile=[filename sprintf('%03i',page),'.split'];
		sdds=sddsload(tempfile);
		delete(tempfile);
	else
		sdds=sddsload(filename);
	end
end
