({
    findObj : function(component) {
        
        var action = component.get("c.wrapperList");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var returnValue = response.getReturnValue();
                console.log(returnValue);
                component.set( "v.obj1List", returnValue );
                
            }else{
                console.log("err");
            }
        });
        $A.enqueueAction( action );
        
    },
    
    addObj : function(component) {
        var objList = component.get("v.obj1List");        
 
        var action = component.get("c.addObjwrapper");
        action.setParams( {
            wrapperListstr :  JSON.stringify(objList)    
		} );
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var returnValue = response.getReturnValue();
                console.log(returnValue);
                component.set( "v.obj1List", returnValue );
                
            }else{
                console.log("err");
            }
        });
        $A.enqueueAction( action );
        
    },
    delObj : function(component, index) {
        var objList = component.get("v.obj1List");       
        objList[index].del = true;
        component.set("v.obj1List" , objList);    
    }
})