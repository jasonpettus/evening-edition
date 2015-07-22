$(document).ready(function(){
  $(document).on('submit', '.new_section', submitNewSection)
  $(document).on('submit', '.delete-section', deleteSection)
});

function submitNewSection(event){
  event.preventDefault();
  var $form = $(event.target)
  $.ajax({
    method: 'POST',
    url: $form.attr('action'),
    data: $form.serialize()
  }).done(function(response){
    $form.after(response)
    $form.children(':text').val('')
  });
};

function deleteSection(event){
  event.preventDefault();
  var $form = $(event.target)
  $.ajax({
    method: "DELETE",
    url: $form.attr('action'),
  }).done(function(response){
    $form.parents('.section-box').next('.pd-2').remove();
    $form.parents('.section-box').remove();
  });
}
