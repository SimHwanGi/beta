({
    btnClick: function(component, event, helper) {
        var btnClicked = event.getSource();         // the button
        var btnMessage = btnClicked.get("v.label"); // the button's label
        component.set("v.message", btnMessage);     // update our message
    },
     
    handleMenuSelect: function(cmp, event, helper) {
    var selectedMenuItemValue = event.getParam("value");
        //component.set("v.menuselect",selectedMenuItemValue);
        alert(selectedMenuItemValue);
	},
    buttonStateful : function (cmp, event, helper) {
        var buttonstate = cmp.get('v.buttonstate');
        cmp.set('v.buttonstate', !buttonstate);
    },
    handleRangeChange: function (cmp, event) {
        var detail = cmp.set("v.value", event.getParam("value"));
        }

})