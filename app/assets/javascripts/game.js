$(document).ready(function() {

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

      $.ajax({
        url: "/games",
        type: "post",
        dataType: 'json',
        data: {array: array_of_ids}
      })
      .done(function(response){
        if(response.ids) {
          for(var i = 0; i < 3; i++) {
          var new_list_partial = "<li class='card' id=" + response.ids[i] + "><img src='/assets/" + response.urls[i] + "'></li>"

          var found_list_item = $("ul").find("li#" + array_of_ids[i]);
          $(found_list_item).replaceWith(new_list_partial);
          }
        } else {
          $("li").remove(".selected");
        }
        $("#set-count").html("Sets made: " + response.sets_made);

        alert(response.thing);
      })
      .fail(function(response) {
        $("li").removeClass("selected");
        alert("Fuck no");
      })
      .always(function(){
        console.log("moo");
      })
    }
  });
});
