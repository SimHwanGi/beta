public class excel {
    
    public blob excelBody{get;set;}
    public String excelStr{get;set;}
    public String excelKorBody{get;set;}
    	public transient Blob 				contentFile		{get;set;}
    public transient String 			nameFile		{get;set;}
    //public String[] 					rows			{get;set;}
	public excel() {
		
	}

	public PageReference doReadFile() {
		system.debug(';;;;;;;;;;;;;;;;;;;;;;;doReadFile;;;;;;;;;;;;;');
		//nameFile = blobToString(contentFile, 'UTF-8'); 
		nameFile = blobToString(contentFile, 'MS949');
		//nameFile	= InstallationUtil.blobToString( contentFile, 'KSC-5601');
		

		//List<List<String>> csvVal = new List<List<String>>();
		//String[] rows = nameFile.replace('\r\n', '\n').split('\n');
		//system.debug(' =====================rows ' + rows.size());
		//for (Integer i=0;i<rows.size();i++) {
		//	List<String> cells = rows[i].split(',');
		//	csvVal.add(cells);
		//}
		//nameFile = JSON.serialize(csvVal);
		nameFile = JSON.serialize(parseCSV(nameFile, false));
		system.debug(' =====================nameFile ' + nameFile);

		return null;
	}

	public String blobToString(Blob input, String inCharset) {
		String hex = EncodingUtil.convertToHex(input);
		system.debug('hex ::: ' + hex);
		System.assertEquals(0, hex.length() & 1);
		final Integer bytesCount = hex.length() / 2;
		String[] bytes = new String[bytesCount];
		for(Integer i = 0; i < bytesCount; ++i)
			bytes[i] =  hex.mid(i * 2, 2);
			
		string d = '%' + String.join(bytes, '%');
		//system.debug('encoded ::: ' + d);
		
		string e = EncodingUtil.urlDecode(d, inCharset);
		//system.debug('decoded ::: ' + e);
		return e;
	}

	public List<List<String>> parseCSV(String contents,Boolean skipHeaders) {
		List<List<String>> allFields = new List<List<String>>();
        	system.debug('allFields1. ' +   allFields);
		
		contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
		
		contents = contents.replaceAll('""','DBLQT');
		
		List<String> lines = new List<String>();
		try {
			lines = contents.split('\n');
		} catch (System.ListException e) {
			System.debug('Limits exceeded?' + e.getMessage());
		}
		Integer num = 0;
		for(String line : lines) {
			// check for blank CSV lines (only commas)
			
            system.debug('line : ' + line);
			if (line.replaceAll(',','').trim().length() == 0) break;
			
			List<String> fields = line.split(',');	
			List<String> cleanFields = new List<String>();
			String compositeField;
			Boolean makeCompositeField = false;
			for(String field : fields) {
				if (field.startsWith('"') && field.endsWith('"')) {
					cleanFields.add(field.replaceAll('DBLQT','"'));
				} else if (field.startsWith('"')) {
					makeCompositeField = true;
					compositeField = field;
				} else if (field.endsWith('"')) {
					compositeField += ',' + field;
					cleanFields.add(compositeField.replaceAll('DBLQT','"'));
					makeCompositeField = false;
				} else if (makeCompositeField) {
					compositeField +=  ',' + field;
				} else {
					cleanFields.add(field.replaceAll('DBLQT','"'));
				}
			}
			system.debug('cleanFields' + cleanFields);
			allFields.add(cleanFields);
		}
		if (skipHeaders) allFields.remove(0);
        
	return allFields;		
}
    
    public void chgBlobStr(){
        String hex = EncodingUtil.convertToHex(excelBody);
        Integer byteCount = hex.length() / 2;
        String[] bytes = new String[byteCount];
        for(Integer i = 0; i < byteCount; ++i){
            bytes[i] = hex.mid(i*2, 2);
            system.debug(bytes[i]);
        }
        
        String koreaBody = String.join(bytes,'%');
        string e = EncodingUtil.urlDecode(koreaBody, 'KSC-5601');
        
        excelKorBody = e;
        excelStr = hex;      
        
    }
}