({
    updateSelect: function (component, event, helper) {
        var opts = [
            { value: "Red", label: "Red" },
            { value: "Green", label: "Green" },
            { value: "Blue", label: "Blue" }
         ];
         component.set("v.options", opts);
    },
    loadOptions: function(component, event, helper){
    var opts = [
        { value: "Cyan", label: "Cyan" }, 
        { value: "Yellow", label: "Yellow" }, 
        { value: "Magenta", label: "Magenta", selected: true }];
    component.set('v.options', opts);
    //set the new selected value on the component
    component.set('v.selectedValue', 'Magenta'); 
    //return the selected value
    component.find("mySelect").get("v.value");
	},
    changeSelect: function (cmp, event, helper) {
        //Press button to change the selected option
        cmp.find("select").set("v.value", "closed");
    },
    handleChange: function (cmp, event, helper) {
        //Do something with the change handler
        alert(event.getParam('value'));
    }
})