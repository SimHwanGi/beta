({
	  handleRemoveOnly: function (cmp, event) {
        event.preventDefault();
        alert('Remove button was clicked!');
    },
    handleClick: function (cmp, event) {
        // this won't run when you click the remove button 
        alert('The pill was clicked!');
    }
})