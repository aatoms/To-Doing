class WelcomeController < PublicController

   def index
     @quotes_array=[{"quote"=>"gCamp has changed my life! It\'s the best tool I\'ve ever used.", "contributor"=>"Cayla Hayes"},
       {"quote"=>'"Before gCamp I was a disorderly slob. Now I\'m more organized than I\'ve ever been"', "contributor"=>"Leta Jaskolski"},
       {"quote"=>'"Don\'t hesitate - sign up right now! You\'ll never be the same."', "contributor"=>"Lavern Upton"}]
   end
end
