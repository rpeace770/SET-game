$(document).ready(function(){

  $("button#no-set").on('click', function(event) {
    event.preventDefault();
    console.log("shiet");

    var ids = new Array();
    $("li.card").each(function(index) {
    ids.push($(this).attr('id'));
        });

    if ( ids.length === 12 ) {

      $.ajax({
        url: "/games/twelve",
        type: "get",
        dataType: 'json',
        data: { card_ids: ids }
      })
      .done(function(response){
        if ( response.partials ) {
          for(var i = 0; i < 3; i ++) {
            $("ul.cells").append(response.partials[i])
          }
        } else {
          alert(response.message)
        }
      })
    } else if ( ids.length === 15 ) {
      $.ajax({
        url: "/games/fifteen",
        type: "get",
        dataType: 'json',
        data: { card_ids: ids }
      })
      .done(function(response){
        if ( response.partials ) {
          for(var i = 0; i < 3; i ++) {
          $("ul.cells").append(response.partials[i])
        }
          for(var i = 0; i < 3; i ++) {
          $($("li.card")[i]).remove();
        }
      } else {
        alert(response.message)
      }
      })
      .fail(function(response) {
        console.log("fail");
      })
      .always(function(){
        console.log("moo");
      })
    } else {
      // when the board is < 12
      $.ajax({
        url: "/games/nine",
        type: "get",
        dataType: 'json',
        data: { card_ids: ids }
      })
      .done(function(response){
        $(body).html(response)
      });
    }
  });


});
