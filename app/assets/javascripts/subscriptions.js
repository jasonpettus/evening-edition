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
    $form.parents('.feed-box').first().remove()
  });
};

function createEditSubscriptionForm(event){
  event.preventDefault();
  $form = $(event.target)
  $formParent = $form.parent()
  $.ajax({
    url: $form.attr('action'),
    method: 'GET'
  }).done(function(response){
      $formParent.siblings().hide();
      $formParent.after(response);
      $formParent.siblings('div').find(':text').focus();
      $formParent.hide();
    });
};

function renameSubscription(event){
  event.preventDefault();
  $form = $(event.target)
  $formParent = $form.parent()
  $.ajax({
    url: $form.attr('action'),
    method: 'PATCH',
    data: $form.serialize()
  }).done(function(response){
    $formParent.siblings().show()
    $formParent.next().children('a').html($form.children(':text').val())
    $formParent.remove()
  });
};
