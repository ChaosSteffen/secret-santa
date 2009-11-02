require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  p params[:participant].inspect
end

__END__

@@ layout
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de">
  <head>
    <title>Secret Santa</title>
    <script src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js" type="text/javascript" charset="utf-8"></script>
  </head>
  <body>
    <script type="text/javascript" charset="utf-8">
      function addRow() {
        $('table#participants').append('
          <tr>
            <td><input type="text" name="participant[][name]" size="15" /></td>
            <td><input type="text" name="participant[][mail]" size="30" /></td>
          </tr>');
      }
    </script>
    <%= yield %>
  </body>
</html>

@@ index
<h1>Secret Santa</h1>

<h2>Teilnehmer:</h2>

<form action="/" method="post">
  <table border="0" cellspacing="0" cellpadding="0" id="participants">
    <tr>
      <th>Name</th>
      <th>E-Mail</th>
    </tr>
    <tr>
      <td><input type="text" name="participant[][name]" size="15" /></td>
      <td><input type="text" name="participant[][mail]" size="30" /></td>
    </tr>
    <tr>
      <td><input type="text" name="participant[][name]" size="15" /></td>
      <td><input type="text" name="participant[][mail]" size="30" /></td>
    </tr>
    <tr>
      <td><input type="text" name="participant[][name]" size="15" /></td>
      <td><input type="text" name="participant[][mail]" size="30" /></td>
    </tr>
  </table>
  <input type="submit" value="mehr Teilnehmer" onclick="addRow(); return false;">
  
  <p>
    Betreff: <input type="text" name="subject" />
  </p>
  <p>
    Nachricht:<br />
    <textarea name="message" rows="8" cols="40">
Ho Ho Ho!

Hier spricht Santa.

{name} würde sich über ein Geschenk von dir freuen.

Frohe Weihnachten wünscht,
Santa Claus
    </textarea>
  </p>
  
  <input type="submit" value="Ho ho ho!">
</form>


