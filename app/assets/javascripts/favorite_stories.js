$(document).ready(function(){
  $(document).on('submit','.save_story_button', favorite_post)
});

function favorite_post(event){
  event.preventDefault();
  $form = $(event.target)
  $.ajax({
    method: 'PUT',
    url: $form.attr('action'),
    data: $form.serialize()
  });

  if($form.children('#favorited') == true){
    $form.find('#favorited').val(false);
    $form.find('.save_button').val(' | Save');
  }else{
    $form.find('#favorited').val(true);
    $form.find('.save_button').val(' | Unsave');
  }
}
