$(document).ready(function(){
  $(document).on('submit', '.new_subscription', createNewSubscription)
})

function createNewSubscription(event){
  event.preventDefault();
  $form = $(event.target)
  $.ajax({
    method: 'POST',
    url: $form.attr('action'),
    data: $form.serialize()
  }).done(function(response){
    $form.after(response);
  });
};
