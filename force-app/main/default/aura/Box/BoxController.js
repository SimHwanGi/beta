({
	handleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        alert(changeValue);
    },
    
    loadOptions: function (component, event, helper) {
        var options = [
            { value: "new", label: "New" },
            { value: "in-progress", label: "In Progress" },
            { value: "finished", label: "Finished" }
        ];
        component.set("v.statusOptions", options);
    },
    handleOptionSelected: function (cmp, event) {
        // Get the string of the "value" attribute on the selected option
        var selectedOptionValue = event.getParam("value");
        alert("Option selected with value: '" + selectedOptionValue + "'");
    },
    radioChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        alert(changeValue);
    }
    
})