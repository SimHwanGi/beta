({
	doinit : function(component, event, helper) {
		helper.findObj(component);
        var yobj ={};
        var firstlist = [{'label': '1', 'value': '1'},
                                                               {'label': '2', 'value': '2'},
                                                               {'label': '3', 'value': '3'},
                                                               {'label': '4', 'value': '4'}];
        var seclist = [{'label': 'a', 'value': 'a'},
                                                               {'label': 'b', 'value': 'b'},
                                                               {'label': 'c', 'value': 'c'},
                                                               {'label': 'd', 'value': 'd'}];
        
        yobj["a"] = firstlist;
        yobj["b"] = seclist;
        component.set("v.yearObject", yobj);  
        
        var combo1 = component.find("combo2");
        
        
	},
    
    addWrapper : function(component, event, helper) {
		helper.addObj(component);
	},
    
    delWrapper : function(component, event, helper) {
        
        var buttonName = event.getSource().get("v.name"); // buttonName = index
        helper.delObj(component , buttonName);
	}
    
    
    
    
})