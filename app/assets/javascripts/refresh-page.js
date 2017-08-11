// window.addEventListener("load", function load(event){
//   alert("refresh")
//   console.log($(this));
// })

$(document).ready(function() {

  if ( document.getElementById("board") != null) {
    alert('board exists');
debugger;
    var ids = new Array();
    $("li.card").each(function(index) {
    ids.push($(this).attr('id'));
        });

    $.ajax({
      url: "/games/new",
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
  }

});
