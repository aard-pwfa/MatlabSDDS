function output=indfromtype(eltype,strsearch)
	switch class(strsearch)
		case 'char'
			output=find(strcmp(eltype,strsearch));
		case 'cell'
			output=[];
			for i=1:max(size(strsearch))
				output=[output; find(strcmp(eltype,strsearch{i}))];
			end
			output=sort(output);
	end
end
