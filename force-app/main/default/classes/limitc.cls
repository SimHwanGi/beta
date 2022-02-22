public class limitc {
    public input ip{get;set;}
    public class glist{
        public String a{get;set;}
        public String b{get;set;}
    }
    public class  input{
        public String str{get;set;}
        public List<glist> glists{get;set;}
        public input(){
            glists = new List<glist>();
        }
        
    }
    public void init(){
        ip = new input();
        ip.str = 'String!!!';
        glist gl = new glist();
        gl.a = 'a!!!';
        gl.b = 'b!!!!';
        ip.glists.add(gl);
        system.debug('input' + ip);
    }
}