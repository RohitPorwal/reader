$(function(){
  $(document).on("click", ".fetchFeed", function(){
    id = $(this).attr('id');
    user_id = $(this).attr('user');

    if ($(this).next().css('display') == 'none'){
      $.ajax({
        url: "/users/" + user_id + "/my_entries/" + id,
        dataType: "jsonp"
      });
    }
    else{ 
	  $(this).next().removeClass('show');
	  $(this).next().addClass('hide');
	}
  });
});