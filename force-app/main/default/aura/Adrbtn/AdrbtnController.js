({
	openPage : function(cmp, evt) {
        var actids= cmp.get("v.recordId");
        window.open("/apex/AccountAddress?actids="+actids,"주소검색", "scrollbars=yes, width=540px, height=745px");
		$A.get('e.force:refreshView').fire();
    }
})