({
	doInit : function(component, event, helper) {
	
        component.find("forceRecord").getNewRecord(
        "Account",
        null,
        false,
        $A.getCallback(function() {
            var rec = component.get("v.accountRecord");
            var error = component.get("v.recordError");
            if (error || (rec === null)) {
                console.log("Error initializing record template: " + error);
                return;
            }
        })
    );
	
	},
    openPage : function(cmp, evt) {
        var actids= cmp.get("v.recordId");
        window.open("/apex/AccountAddress?actids="+actids,"주소검색", "scrollbars=yes, width=540px, height=745px");
		$A.get('e.force:refreshView').fire();
    },
    saveRecord : function(component, event, helper) {
	
    component.set("v.accountRecord.Name", component.find('actName').get("v.value"));    
    component.set("v.accountRecord.BillingAddress", component.find('BillingAddress').get("v.value"));
    component.set("v.accountRecord.BillingCity", component.find('BillingCity').get("v.value"));
    component.set("v.accountRecord.BillingCountry", component.find('BillingCountry').get("v.value"));
    
    var tempRec = component.find("forceRecord");
        
    tempRec.saveRecord($A.getCallback(function(result) {
        console.log(result.state);
        var resultsToast = $A.get("e.force:showToast");
        if (result.state === "SUCCESS") {
            resultsToast.setParams({
                "title": "Saved",
                "message": "The record was saved."
            });
            resultsToast.fire();                
        } else if (result.state === "ERROR") {
            console.log('Error: ' + JSON.stringify(result.error));
            resultsToast.setParams({
                "title": "Error",
                "message": "There was an error saving the record: " + JSON.stringify(result.error)
            });
            resultsToast.fire();
        } else {
            console.log('Unknown problem, state: ' + result.state + ', error: ' + JSON.stringify(result.error));
        }
    }));

    }
})