({
	init: function (component) {
var sections = [
{
label: "Reports",
items: [
{
label: "Created by Me",
name: "default_created"
},
{
label: "Public Reports",
name: "default_public"
}
]
},
{
label: "Dashboards",
items: [
{
label: "Favorites",
name: "default_favorites",
icon: "utility:favorite"
},
{
label: "Most Popular",
name: "custom_mostpopular"
}
]
}
];
component.set('v.navigationData', sections);
}
})