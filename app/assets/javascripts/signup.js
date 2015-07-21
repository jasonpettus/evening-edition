$(document).ready(function(){
  $('#sign-up').on('click', showSignupForm);
});

function showSignupForm(event){
  event.preventDefault();
  var ajax = $.ajax({
    method: 'GET',
    url: '/users/new'
  }).done(function(response){
    console.log(response)
    $(".page-content").prepend(response);
    $(".mdl-grid").hide();
  });
};
