function addRow() {
  $('table#participants').append('<tr><td><input type="text" name="participant[][name]" size="15" /></td><td><input type="text" name="participant[][mail]" size="30" /></td></tr>');
}
$(document).ready(function() {
  $('input.addrow').click(function(event){
    addRow();
    event.preventDefault();
    return false;
  });
});
