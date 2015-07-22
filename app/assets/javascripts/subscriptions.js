$(document).ready(function(){
  $(document).on('submit', '.new_subscription', createNewSubscription);
  $(document).on('submit', '.delete-subscription', deleteSubscription);
  $(document).on('submit', '.edit-subscription', createEditSubscriptionForm);
  $(document).on('submit', '.subscription-edit-form form', renameSubscription);
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
    $form.children(":text").val('')
  });
};

function deleteSubscription(event){
  event.preventDefault();
  $form = $(event.target)
  $.ajax({
    method: 'DELETE',
    url: $form.attr('action'),
    data: $form.serialize()
  }).done(function(response){
    $form.parent().remove()
  });
};

function createEditSubscriptionForm(event){
  event.preventDefault();
  $form = $(event.target)
  $.ajax({
    url: $form.attr('action'),
    method: 'GET'
  }).done(function(response){
      $form.siblings().hide();
      $form.parent().append(response);
      $form.hide();
    });
};

function renameSubscription(event){
  event.preventDefault();
  $form = $(event.target)
  $.ajax({
    url: $form.attr('action'),
    method: 'PATCH',
    data: $form.serialize()
  }).done(function(response){
    $form.parent().siblings().show()
    $form.parent().siblings('span').html($form.children(':text').val())
    $form.parent().remove()
  });
};
