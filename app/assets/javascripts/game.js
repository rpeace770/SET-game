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

  if (total === 3) {
      $.ajax({
        url: "/games",
        type: "post",
        data: total
      })
      .done(function(response){
        alert(response);
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
