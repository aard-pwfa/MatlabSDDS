function analyzefiles(keep)
	files=dir('*.w1');
	for i=1:size(files,1)
		name=files(i).name;
		unix(['sddsanalyzebeam ' name ' ' name '.ana']);
	end
	unix(['sddscombine *.w1.ana w1.combined -retain=col,' keep ' -overWrite -merge']);
end
