// $(document).ready(function(){
//   $(document).on('submit','#login-form', logUserIn);
// });

// function logUserIn(event){
//   event.preventDefault();
//   var formAction = $(event.target).attr('action');
//   var ajax = $.ajax({
//     method: 'POST',
//     url: formAction,
//     data: $(event.target).serialize()
//   }).done(function(response, status){
//     $('.masthead').remove();
//     $('body').prepend(response);
//   });
// };
