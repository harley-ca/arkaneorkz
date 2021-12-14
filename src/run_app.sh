#Remove any previous gemfile
rm Gemfile.lock

#install bundle
gem install bundle
#install required gems
bundle install

#clear the screen
clear
#run the game
ruby index.rb