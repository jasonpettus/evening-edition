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
    $form.next('.errors').remove()
    if (typeof response === "string"){
      $form.after(response);
      $form.children(":text").val('')
    } else {
      $form.after('<div class= "list-left feed-box errors"></div>')
      for(var n=0; n<response.length; n++){
        $form.next().append('<p class = "center bold mdl-color--deep-purple-500 mdl-color-text--black-A700">' + response[n] + '</p>')
      }
    }
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
