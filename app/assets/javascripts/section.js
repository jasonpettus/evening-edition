$(document).ready(function(){
  $('.mdl-layout__container').on('click','.mdl-navigation__link', function(event){
    alert("STOP");
    event.preventDefault();
    var url =$(this).attr("href");
    console.log("lorg: ", url);

    var ajax = $.get(url).done(
      function(response){
        console.log("from server", response);
      });
    });

  $(document).on('submit', '.new_section', submitNewSection)
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
  });
};
