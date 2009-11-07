require 'rubygems'
require 'sinatra'
require 'pony'

set :public, File.dirname(__FILE__) + '/static'

get '/' do
  erb :index
end

post '/' do
  mails = cleanup params[:participant]
  mails = randomize mails
  
  mails.each do |item|
    Pony.mail :to => item[:mail],
      :from => ENV['SANTA_MAIL_FROM'],
      :subject => params[:subject],
      :body => params[:message].gsub('{name}', item[:name]),
      :via => :smtp,
      :smtp => {
        :host     => ENV['SANTA_MAIL_HOST'],
        :port     => ENV['SANTA_MAIL_PORT'],
        :user     => ENV['SANTA_MAIL_USER'],
        :password => ENV['SANTA_MAIL_PASSWORD'],
        :auth     => ENV['SANTA_MAIL_AUTH'].to_sym,  # :plain, :login, :cram_md5, no auth by default
        :domain   => ENV['SANTA_MAIL_DOMAIN']        # the HELO domain provided by the client to the server
      }
  end
  
  "Teilnehmer wurden benachrichtigt."
end

def randomize participants
  srand(Time.now.hash)
  participants = participants.sort_by { rand }
  
  mailing = Array.new
  (0...participants.length).each do |i|
    mailing.push({:mail => participants[i-1]['mail'], :name => participants[i]['name'] })
  end
  
  return mailing
end

def cleanup mails
  mails.delete_if { |mail| p mail; (mail['name'].blank? || mail['mail'].blank?) }
end

__END__

@@ layout
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de">
  <head>
    <title>Secret Santa</title>
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" charset="utf-8">
    <script src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="javascript.js" type="text/javascript" charset="utf-8"></script>
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ index
<h1>
  <img src="/icon/gift_box_32.png" />&nbsp;&nbsp;Secret Santa
</h1>

<div id="content">
  <h2>Teilnehmer:</h2>
  <p>
    Trage den Namen und die E-Mail jedes Teilnehmers in das Formular ein.
  </p>
  
  <form action="/" method="post">
    <table border="0" cellspacing="0" cellpadding="0" id="participants">
      <tbody>
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
      </tbody>
    </table>
    <input type="submit" class="addrow" value="mehr Teilnehmer" />
    
    <h2>Nachricht:</h2>
    <p>
      Du kannst nun die E-Mail, die jedem Teilnehmer zugesendet wird, anpassen.
    </p>
    
    <div id="mail">
      <label for="subject">Betreff:</label><br />
      <input type="text" name="subject" value="Ho Ho Ho!" />
      <br /><br />
      Nachricht:<br />
      <textarea name="message" rows="8" cols="40">
Ho Ho Ho!

{name} würde sich über ein Geschenk von dir freuen.

Frohe Weihnachten wünscht,
Santa Claus
      </textarea>
    </div>
    
    <p class="small">
      Beachte: das Schlüsselwort "{name}" wird später mit dem Namen des Teilnehmers der beschenkt werden soll ersetzt.
    </p>
    
    <p><input type="submit" value="Ho ho ho! Jetzt abschicken." /></p>
  </form>
</div>

