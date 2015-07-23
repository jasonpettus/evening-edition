$(document).ready(function(){
  $('#sign-up').on('click', showSignupForm);
  $(document).on('submit', '#create-account-form', submitNewAccount);
});

function showSignupForm(event){
  event.preventDefault();
  if ($(".form_box").size() == 0){
    var ajax = $.ajax({
      method: 'GET',
      url: '/users/new'
    }).done(function(response, status){
      $(".page-content").prepend(response);
      $(".mdl-grid").remove();
      $("#banner").text("Create Account")
    });
  }
};

function submitNewAccount(event){
  event.preventDefault();
  $form = $(event.target);
  var ajax = $.ajax({
    method: 'POST',
    url: '/users',
    data: $form.serialize()
  }).done(function(response, status){
    if (response.redirect) {
      window.location.href = response.redirect
    } else {
      $form.parent().siblings('p').remove()
      $form.parent().before(response)
    };
  });
};
