


$(document).ready(function(){

  $("button#no-set").on('click', function(event) {
    event.preventDefault();
    console.log("shiet");

    var ids = new Array();
    $("li.card").each(function(index) {
    ids.push($(this).attr('id'));
        });

    $.ajax({
      url: "/games/checker",
      type: "get",
      dataType: 'json',
      data: { card_ids: ids }
    })
    .done(function(response){
      alert(response);
      console.log("done");
    })
    .fail(function(response) {
      alert(response.responseText);
      console.log("fail");
    })
    .always(function(){
      console.log("moo");
    })
  });


});
