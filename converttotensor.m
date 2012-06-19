function matrix = converttotensor(structvar,indnum, pagenum)
	switch nargin
	case 1
		indnum=1;
		pagenum=1;
	case 2
		pagenum=1;
	end
	matrix=zeros(6,6,6);
	for i=1:6
		for j=1:6
			for k=1:j
				vector=eval(['converttovector(structvar.T' num2str(i) num2str(j) num2str(k) ',pagenum)']);
				matrix(i,j,k)=vector(indnum);
				matrix(i,k,j)=vector(indnum);
			end
		end
	end
end
