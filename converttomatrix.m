function matrix = converttomatrix(structvar, indnum, pagenum)
	switch nargin
	case 1
		indnum=1;
		pagnum=1;
	case 2
		pagenum=1;
	end

	matrix=zeros(6);
	for i=1:6
		for j=1:6
			vector=eval(['converttovector(structvar.R' num2str(i) num2str(j) ', pagenum)']);
			matrix(i,j)=vector(indnum);
		end
	end
end
