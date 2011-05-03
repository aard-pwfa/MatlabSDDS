function namearray=colnames(filename)
	switch class(filename)
		case 'char'
			sdds=sddsheader(filename);
		case 'struct'
			sdds=filename;
	end
	names=sdds.column_names;
	names_size=size(names,1);
	namearray=cell(names_size,1);
	for i=1:names_size
		namearray{i}=strtrim(names(i,:));
	end
end
