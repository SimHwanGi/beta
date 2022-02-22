({
acceptWork: function(cmp, evt, hlp) {
var omniAPI = cmp.find("omniToolkit");
omniAPI.getAgentWorks({
callback: function(result) {
var works = JSON.parse(result.works);
var work = works[0];
omniAPI.acceptAgentWork({
workId: work.workId,
callback: function(result2) {
if (result2.success) {
console.log("Accepted work successfully");
} else {
console.log("Accept work failed");
}
}
});
}
});
}
})