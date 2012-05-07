function splitfile(filename)
	[pathstr,name,ext]=fileparts(filename);
	if exist([pathstr '/' name])==7
		[status, message, messageid] = rmdir([pathstr '/' name],'s');
		if ~status
			err=MException('splitfile:nodir','Error deleting directory.');
			throw(err);
		end
	end
	mkdir([pathstr '/' name]);
	system(['sddssplit ' filename ' -rootname=' pathstr '/'	name '/ -extension=out']);
end
