$(document).ready(function() {
	$(document).on('click', '#editSectinonButton', getEditForm);
});

function getEditForm() {
	event.preventDefault();
	alert("target acquired!");
}