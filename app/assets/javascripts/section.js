$(document).ready(function(){
  $(document).on('submit', '.new_section', submitNewSection)
  $(document).on('submit', '.delete-section', deleteSection)
  $(document).on('submit', '.rename-section', showRenameForm)
  $(document).on('submit', '.edit_section', renameSection)
});

function submitNewSection(event){
  event.preventDefault();
  var $form = $(event.target)
  $.ajax({
    method: 'POST',
    url: $form.attr('action'),
    data: $form.serialize()
  }).done(function(response){
    var new_section_link = response.match(/href.*?\/a>/)
    $form.after(response)
    $form.parentsUntil('.mdl-layout__container').last().find('nav').prepend('<li><a class="mdl-navigation__link" ' + new_section_link + '</li>')
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
    var sidebarLinks = $form.parentsUntil('.mdl-layout__container').last().find('nav').children()
    for(var n = 0; n < sidebarLinks.length; n++){
      if ($(sidebarLinks[n]).children('a').html() == $form.parents('.section-box').find('a').html()){
        sidebarLinks[n].remove();
      };
    };
    $form.parents('.section-box').next('.pd-2').remove();
    $form.parents('.section-box').remove();
  });
};

function showRenameForm(){
  event.preventDefault();
  var $form = $(event.target);
  $.ajax({
    method: 'GET',
    url: $form.attr('action')
  }).done(function(response){
    $form.parents('.section-box').children().hide();
    $form.parents('.section-box').append(response);
  });
};

function renameSection(){
  event.preventDefault();
  var $form = $(event.target);
  $.ajax({
    method: 'PUT',
    url: $form.attr('action'),
    data: $form.serialize()
  }).done(function(response){
    $form.parents('.section-box').children().show()
    $form.parents('.section-box').find('a').html($form.children(':text').val())
    $form.parent().parent().remove()
  });
};
