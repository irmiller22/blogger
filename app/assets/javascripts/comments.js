$(document).ready(function(){
  // comment create button
  $('#create_comment').on('click', function(){
    e.preventDefault();
    createComment();
  });

  $('#create_comment').keypress(function(e){
    if(e.which == 13){
      e.preventDefault();
      e.stopPropagation();
    }
  });

  function createComment(){
    var regex = /\d/
    var post_id = regex.exec( $('#new_comment').attr('action') );
    var title = ('#comment_title').val();
    var input = $('#comment_body').val();

    $.ajax({
      method: "POST",
      url: "/posts/" + post_id + "comments",
      data: { title: title , body: input }
    })
      .done(function(callback){
        console.log(callback);
      });
  }
});
