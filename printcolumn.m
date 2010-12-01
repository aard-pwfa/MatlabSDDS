function cellarray=printcolumn(filename, num)
	sdds=sddsload(filename);
	names=colnames(sdds);
	names_size=size(names,1)
	if class(num)=='char'
		if num=='end'
			num=size(converttovector(sdds.column.(names{1})),1);
		else
			num=1;
		end
	end
	cellarray=cell(names_size,2);
	for i=1:names_size
		cellarray{i,1}=names{i};
		temp=converttovector(sdds.column.(names{i}));
		cellarray{i,2}=temp(num);
	end
end
