({
	openactadr : function (component, event, helper) {
    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": "/AccountAddress?actids=0017F00000KaSJ8"
    });
    urlEvent.fire();
}
})