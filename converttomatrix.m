function matrix = converttomatrix(structvar, indnum)
	if nargin == 1
		indnum=1;
	end
	matrix=zeros(6);
	for i=1:6
		for j=1:6
			vector=eval(['converttovector(structvar.R' num2str(i) num2str(j) ')']);
			matrix(i,j)=vector(indnum);
		end
	end
end
