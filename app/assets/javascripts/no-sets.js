$(document).ready(function(){

  $("button#no-set").on('click', function(event) {
    event.preventDefault();
    console.log("shiet")
    var $button = $(this)
    console.log($button)
    console.log($("#1"))
    console.log($("#displayed-cards"))
    $.ajax({
      url: "/games/checker",
      type: "get"
    })
    .done(function(response){
      console.log("done")
    })
    .fail(function(){
      console.log("fail")
    })
    .always(function(){
      console.log("riibbiitt")
    })
  });












});
