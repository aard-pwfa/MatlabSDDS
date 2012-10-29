function scan_par(filename,element_name,param_name,vals)
%SCAN_PAR Generates one-variable scanned Elegant parameter file.  (.par)
%	SCAN_PAR(filename,element_name,param_name,vals) generates an
%	Elegant parameter file with values given by an arbitrary vector.
%
%	filename     = filename to create

%	The element to be varied is given by:
%
%	element_name = {name,[occurrence 1, occurrence 2, ...]}
%	param_name   = parameter name to vary
%	vals         = vector of values to create.
%
%	where [occurrence list] is optional - assumed to be each appearance if not specified.
%
%	Elegant should be run with first_is_fiducial = 1.
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
	
	% Each page is represented by multiple files, which will be concatenated at the end.
	filelist='';
	% Put files in a common file folder.
	mkdir(filename);

	% Put the fiducial element first
	val = [0, vals];

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
