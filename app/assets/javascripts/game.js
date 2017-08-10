$(document).ready(function() {
// give section an id
  $("section#board").on("click", "li", function(e) {
    e.preventDefault();
    if($(this).hasClass("selected")) {
      $(this).removeClass("selected");
    } else {
      $(this).addClass("selected");
    }

  var total = $(".selected").length
  var ids = $(".selected");

  if (total === 3) {

  var array_of_ids = [ids[0].id, ids[1].id, ids[2].id]

  $("li").removeClass("selected");

      $.ajax({
        url: "/games",
        type: "post",
        dataType: 'json',
        data: {array: array_of_ids}
      })
      .done(function(response){
        alert(response.thing);
      })
      .fail(function(response) {
        alert(response.responseText);
      })
      .always(function(){
        console.log("moo");
      })
    }
  });
});
