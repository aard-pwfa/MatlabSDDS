function cellarray=chartocell(charray)
	csize=size(charray,1);
	cellarray=cell(csize,1);
	for i=1:csize
		cellarray{i}=strtrim(charray(i,:));
	end
end
