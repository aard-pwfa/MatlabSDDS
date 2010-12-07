function out=getcol(filename,colname)
	sdds=sddsload(filename);
	out=converttovector(sdds.column.(colname));
end
