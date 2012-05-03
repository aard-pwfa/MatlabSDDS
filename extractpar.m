function out=extractpar(filename)
	sdds=sddsload(filename);
	NameAvail  = converttovector(sdds.column.ElementName);
	ParamAvail = converttovector(sdds.column.ElementParameter);
	ValueAvail = converttovector(sdds.column.ParameterValue);
	TypeAvail  = converttovector(sdds.column.ElementType);
	OccAvail   = converttovector(sdds.column.ElementOccurence);

	lastocc=OccAvail(1);
	lastname=NameAvail{1};
	j=1;
	for i=1:size(NameAvail,1)
		if OccAvail(i) ~= lastocc || ~strcmp(lastname,NameAvail{i})
			j=j+1;
			lastocc=OccAvail(i);
			lastname=NameAvail{i};
		end
		out.name{j}            = NameAvail{i};
		out.type{j}            = TypeAvail{i};
		out.occ{j}             = OccAvail(i);
		out.(ParamAvail{i}){j} = ValueAvail(i);
	end

	fields=fieldnames(out);
	for i=1:size(fields,1)
		out.(fields{i}){j}=0;
	end
end
