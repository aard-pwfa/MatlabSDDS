function montecarlo_onevar_par(filename,npages,gauss_params,element_name,param_name)
%MONTECARLO_ONEVAR_PAR Generates one-variable Monte Carlo Elegant parameter file.  (.par)
%	MONTECARLO_ONEVAR_PAR(filename,npages,gauss_params,element_name,param_name) generates a 
%	Monte Carlo Elegant parameter file.  The file creates a set of value definitions
%	NPAGES long, with a gaussian distribution:
%
%	npages       = number of simulations to run
%	gauss_params = [mean, sigma]
%	
%	The element to be varied is given by:
%
%	element_name = {name,[occurrence 1, occurrence 2, ...]}
%
%	where [occurrence list] is optional - assumed to be each appearance if not specified.
%
%	The first page uses the mean value, so that Elegant should be run with
%	first_is_fiducial = 1 so that the beamline is fiducialized against the mean.
%	Then, successive pages will be simulated as variations from the norm, while the
%	rest of the beamline stays the same.
%
%	Note:  each page is an Elegant simulation!

	% Extract occurrence array if it exists
	if size(element_name,2) == 2
		occArray = element_name{2};
		element_name = element_name{1};
	else
		occArray = 1;
	end

	% Extract mean, sigma for readability.
	gmean = gauss_params(1);
	gsig  = gauss_params(2);


	% Each page is represented by multiple files, which will be concatenated at the end.
	filelist='';
	% Put files in a common file folder.
	mkdir(filename);

	% Create values desired.
	% Note that the first value is the mean, so that
	% first_is_fiducial will fiducialize the beamline.
	val = [gmean, normrnd(gmean,gsig,1,npages)];

	% Create a separate par file for each page.
	for i = [1:size(val,2)]
		% Create temporary csv file and write header.
		tempfr = [filename '/' num2str(i)];
		fid=fopen([tempfr '.csv'],'w');
		fprintf(fid,['Name, Occurence, ' param_name '\n']);

		% Write element name, occurrence, and value
		for occ = occArray
			fprintf(fid,'%s, %d, %3.6e\n',element_name,occ,val(i));
		end

		% Close file
		fclose(fid);

		% Change csv file to par file.
		system(['gen_multi_par.py ' tempfr '.csv ' tempfr '.par']);
		delete([tempfr '.csv'],[tempfr '.par.tmp']);

		filelist = [filelist ' ' tempfr '.par'];
	end
	% Fiducial + others
	system(['sddscombine ' filelist ' ' filename '.par -overWrite']);
	% system(['sddscombine' filelist ' FACET_WORK/quad_misalign.par -overWrite']);
	rmdir(filename,'s');
end
