public class csvStr {
    
    public Blob csvfile {get;set;}
    public String str {get;set;}
    public void doimport(){
        
        String stringFromCsv = blobToString(csvfile, 'MS949');
system.debug('csvfile' + csvfile);        
        List<String> listFileLine = stringFromCsv.split('\r\n');
        
        system.debug('listFileLine ' + listFileLine);
        for(String str :listFileLine){
            system.debug('str' + str);
        }
    }
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        system.debug('hex***********' + hex);
        System.assertEquals(0, hex.length() & 1);
        system.debug('hex.length()' + hex.length());
        final Integer bytesCount = hex.length() >> 1;
        system.debug('bttesCount' + bytesCount);
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i){
            system.debug('iiiiii' + i);
            bytes[i] =  hex.mid(i << 1, 2);
            system.debug('iiiiii' + i);
        }
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }
}