# Thank you for playing my game and improving it! Peace, love and code ♡ ~cajudeleite

# V2 Update Log
# - Transformed the cards array into a hash
# - Now the player can choose the Ases values @between 1 or 11
# - Some bug fixes in multi-argument conditionals
# - Some fixes on informations displayed to the player
# - Fixed player choice of playing again or not
# - Fixed user input information
# - Added a 'Want to play again' screen
# - Added a 'You lost' screen when player doens't have credits anymore

# V3 Update Log
# - Player can't @double if (2 * @bet) > credit

require_relative 'methods'
system 'clear'
# Card library
cards_hash = { 'A♠' => 11,
               '2♠' => 2,
               '3♠' => 3,
               '4♠' => 4,
               '5♠' => 5,
               '6♠' => 6,
               '7♠' => 7,
               '8♠' => 8,
               '9♠' => 9,
               '10♠' => 10,
               'J♠' => 10,
               'Q♠' => 10,
               'K♠' => 10,
               'A♡' => 11,
               '2♡' => 2,
               '3♡' => 3,
               '4♡' => 4,
               '5♡' => 5,
               '6♡' => 6,
               '7♡' => 7,
               '8♡' => 8,
               '9♡' => 9,
               '10♡' => 10,
               'J♡' => 10,
               'Q♡' => 10,
               'K♡' => 10,
               'A♣' => 11,
               '2♣' => 2,
               '3♣' => 3,
               '4♣' => 4,
               '5♣' => 5,
               '6♣' => 6,
               '7♣' => 7,
               '8♣' => 8,
               '9♣' => 9,
               '10♣' => 10,
               'J♣' => 10,
               'Q♣' => 10,
               'K♣' => 10,
               'A♢' => 11,
               '2♢' => 2,
               '3♢' => 3,
               '4♢' => 4,
               '5♢' => 5,
               '6♢' => 6,
               '7♢' => 7,
               '8♢' => 8,
               '9♢' => 9,
               '10♢' => 10,
               'J♢' => 10,
               'Q♢' => 10,
               'K♢' => 10 }
# Card library

# Credit
credit = 100
# Credit
play = true
while play
  # Set game constants
  @game_is_on = true
  @player_total_score = 0
  @croupier_total_score = 0
  @player_cards = ''
  @player_new_pick = []
  @answer = ''
  @croupier_hand = ''
  @bet = 0
  @double = 1
  @double_valid = ''
  cards_hash['A♠'] = 11
  cards_hash['A♡'] = 11
  cards_hash['A♣'] = 11
  cards_hash['A♢'] = 11
  @credit = credit
  # Set game constants

  # Player makes @bets
  make_bet(credit)
  # Player makes @bets

  # Croupier 1rst pick
  croupier_1rst_pick = cards_hash.to_a.sample
  croupier_2nd_pick = cards_hash.to_a.sample
  @croupier_hand = "### ~~~ #{croupier_2nd_pick[0]}"
  croupier_hand = @croupier_hand
  croupier_picks(croupier_1rst_pick, croupier_2nd_pick)
  # Croupier 1rst pick

  # Player first pick
  player_1rst_pick = cards_hash.to_a.sample
  player_2nd_pick = cards_hash.to_a.sample
  player_picks(player_1rst_pick, player_2nd_pick)
  # Player first pick

  # Show the cards
  player_cards = @player_cards
  player_total_score = @player_total_score
  show_cards(croupier_hand, player_cards)
  puts 'Here is your score:'
  puts @player_total_score
  sleep(3)
  # Show the cards

  # If player and/or croupier do Black Jack
  croupier_total_score = @croupier_total_score
  bet = @bet
  blackjack?(player_total_score, croupier_total_score, credit, bet)
  # If player and croupier do Black Jack

  # Ask and choose what to do next
  if @game_is_on
    what_to_do
  end
  # Ask and choose what to do next

  # Changing As values to be flexible
  cards_hash['A♠'] = 'flexible'
  cards_hash['A♡'] = 'flexible'
  cards_hash['A♣'] = 'flexible'
  cards_hash['A♢'] = 'flexible'
  # Changing As values to be flexible

  # If player doubles
  if @game_is_on && @answer == 'Double' && @player_total_score < 21
    @double = 2
    @player_new_pick = cards_hash.to_a.sample
    @player_cards = "#{@player_cards} ~~~ #{@player_new_pick[0]}"
    puts "You chose to #{@answer}!"
    show_cards(croupier_hand, player_cards)
    change_as(player_new_pick) if @player_new_pick[1] == 'flexible'
    @player_total_score += @player_new_pick[1]
    puts 'Here is your score:'
    puts @player_total_score
    sleep(3)
    if @player_total_score > 21
      puts 'You burned out! Better luck next time'
      credit -= (@bet * @double)
      @game_is_on = false
    end
  end
  # If player doubles

  # If player draws
  while @game_is_on && @answer == 'Draw' && @player_total_score < 21
    @player_new_pick = cards_hash.to_a.sample
    @player_cards = "#{@player_cards} ~~~ #{@player_new_pick[0]}"
    player_cards = @player_cards
    player_total_score =  @player_total_score
    system 'clear'
    puts "You chose to #{@answer}!"
    show_cards(croupier_hand, player_cards)
    if @player_new_pick[1] == 'flexible'
      as_constant = false
      until as_constant
        puts "You want your #{@player_new_pick[0]} to value as a 1 or a 11?"
        new_as_value = gets.chomp.to_i
        case new_as_value
        when 11
          @player_new_pick[1] = 11
          as_constant = true
        when  1
          @player_new_pick[1] = 1
          as_constant = true
        end
      end
    end
    @player_total_score += @player_new_pick[1]
    puts 'Here is your score:'
    puts @player_total_score
    sleep(3)
    if @player_total_score > 21
      puts 'You burned out! Better luck next time'
      credit -= (@bet * @double)
      @game_is_on = false
    elsif @player_total_score < 21
      what_to_do
      puts "You chose to #{@answer}!"
      sleep(3)
    end
  end
  # If player draws

  # Show the game
  if @game_is_on
    @croupier_hand = "#{croupier_1rst_pick[0]} ~~~ #{croupier_2nd_pick[0]}"
    croupier_hand = @croupier_hand
    system 'clear'
    show_cards(croupier_hand, player_cards)
    puts 'Here is your score:'
    puts @player_total_score
    sleep(3)
  end
  # Show the game

  # Croupier plays
  while @game_is_on && @croupier_total_score < @player_total_score && @croupier_total_score < 17
    croupier_new_pick = cards_hash.to_a.sample
    @croupier_total_score += croupier_new_pick[1].to_i
    @croupier_hand = "#{@croupier_hand} ~~~ #{croupier_new_pick[0]}"
    croupier_hand = @croupier_hand
    system 'clear'
    show_cards(croupier_hand, player_cards)
    sleep(3)
  end
  # Croupier plays

  # Game results
  if @game_is_on
    if @croupier_total_score == @player_total_score
      puts 'Push!'
    elsif @croupier_total_score > 21
      puts 'Croupier burned out!'
      credit += (@bet * @double)
      @game_is_on = false
    elsif @croupier_total_score > @player_total_score
      puts "Croupier's score is #{@croupier_total_score}! You lost. Better luck next time"
      credit -= (@bet * @double)
      @game_is_on = false
    else
      puts "Croupier's score is #{@croupier_total_score}! You won!"
      credit += (@bet * @double)
      @game_is_on = false
    end
  end
  # Game results

  # End game
  sleep(5)
  system 'clear'
  puts "Here are your credits : #{credit}$"
  if credit.positive?
    puts 'Want to play again?'
    play_q = gets.chomp.downcase
    if play_q == 'y' || play_q == 'yes'
      play = true
    else
      puts 'Are you sure you want to quit?'
      confirmation = gets.chomp
      if confirmation == 'y' || confirmation == 'yes'
        play = false
        puts 'Bye bye'
      end
    end
  else
    puts "You lost! You don't have any credits left"
    play = false
  end
  sleep(3)
  system 'clear'
  # End Game
end

# For the next patch:

# Croupier can choose ases values automaticaly
# Player and croupier can change already ases chosen values if it burns out
# ? Player can split if it gets two same card in the beggining (like two queens or two fives) ?
