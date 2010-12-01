function structret = converttovector(structvar, pagenum)
	if nargin == 1
		pagenum=1;
	end
	import SDDS.java.SDDS.*
	switch SDDSUtil.identifyType(structvar.type)
	case {1, 3}
		structret = SDDSUtil.castArrayAsDouble(structvar.(['page' num2str(pagenum)]),SDDSUtil.identifyType(structvar.type));
	case 5
		structret = chartocell(char(SDDSUtil.castArrayAsString(structvar.(['page' num2str(pagenum)]),SDDSUtil.identifyType(structvar.type))));
	end
end
