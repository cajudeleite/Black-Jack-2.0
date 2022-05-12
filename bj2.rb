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
require 'curses'
system 'clear'

# Curses
Curses.init_screen
begin
  win1 = Curses.stdscr.subwin(10, 20, 0, 0)
  win1.box("|", "-")
  win1.refresh
  input = Curses.getstr
ensure
  Curses.close_screen
end
# Curses

# Card library
@cards_hash = { 'A♠' => 11,
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
split_cards_hash = { 'K♠' => 10,
                      'K♡' => 10,
                      'K♣' => 10,
                      'K♢' => 10 }
# Card library

# Credit
credit = 100
new_bet = 0
# Credit
play = true
while play
  # Set game constants
  @game_is_on = true
  @player_first_hand_score = 0
  @player_second_hand_score = 0
  @croupier_total_score = 0
  @player_first_hand = ''
  @player_second_hand = ''
  @croupier_hand = ''
  @player_new_pick = []
  @answer = ''
  @bet = 0
  @double = 1
  @double_valid = ''
  @cards_hash['A♠'] = 11 if @cards_hash['A♠']
  @cards_hash['A♡'] = 11 if @cards_hash['A♡']
  @cards_hash['A♣'] = 11 if @cards_hash['A♣']
  @cards_hash['A♢'] = 11 if @cards_hash['A♢']
  @credit = credit
  # Set game constants

  # Player makes @bets
  make_bet(credit, new_bet)
  # Player makes @bets

  # Croupier deals
  puts 'Croupier deals...'
  sleep(1)
  croupier_1rst_pick = @cards_hash.to_a.sample
  @cards_hash.delete(croupier_1rst_pick[0])
  player_1rst_pick = @cards_hash.to_a.sample
  @cards_hash.delete(player_1rst_pick[0])
  croupier_2nd_pick = @cards_hash.to_a.sample
  @cards_hash.delete(croupier_2nd_pick[0])
  player_2nd_pick = @cards_hash.to_a.sample
  @cards_hash.delete(player_2nd_pick[0])
  croupier_picks(croupier_1rst_pick, croupier_2nd_pick)
  @player_first_hand = "#{player_1rst_pick[0]} ~~~ #{player_2nd_pick[0]}"
  @player_first_hand_score += player_1rst_pick[1] + player_2nd_pick[1]
  # Croupier deals

  # Show the cards
  system 'clear'
  show_cards(true)
  # Show the cards

  # If player and/or croupier do Black Jack
  blackjack?(@player_first_hand_score, @croupier_total_score, credit, @bet)
  # If player and croupier do Black Jack

  # Ask and choose what to do next
  if @game_is_on
    what_to_do(credit, 1)
  end
  # Ask and choose what to do next

  # Changing As values to be flexible
  if @cards_hash['A♠']
    @cards_hash['A♠'] = 'flexible'
  end
  if @cards_hash['A♡']
    @cards_hash['A♡'] = 'flexible'
  end
  if @cards_hash['A♣']
    @cards_hash['A♣'] = 'flexible'
  end
  if @cards_hash['A♢']
    @cards_hash['A♢'] = 'flexible'
  end
  # Changing As values to be flexible

  # If player splits
  if @game_is_on && @answer == 'Split'
    @second_bet = @bet
    player_3rd_pick = @cards_hash.to_a.sample
    @cards_hash.delete(player_3rd_pick[0])
    player_4th_pick = @cards_hash.to_a.sample
    @cards_hash.delete(player_4th_pick[0])
    @player_first_hand = "#{player_1rst_pick[0]} ~~~ #{player_3rd_pick[0]}"
    @player_second_hand = "#{player_2nd_pick[0]} ~~~ #{player_4th_pick[0]}"
    @player_first_hand_score = player_1rst_pick[1].to_i + player_3rd_pick[1].to_i
    @player_second_hand_score = player_2nd_pick[1].to_i + player_4th_pick[1].to_i
  end
  # If player splits

  # First hand
  if @player_second_hand_score > 0
    system 'clear'
    show_cards(true)
    puts 'First hand:'
    what_to_do(credit, 2)
  end

  # If player doubles
  if @game_is_on && @answer == 'Double'
    double(true)
  end
  # If player doubles

  # If player draws
  while @game_is_on && @answer == 'Draw' && @player_first_hand_score < 21
    draw(true)
    if @player_first_hand_score > 21
      system 'clear'
      puts 'You burned out! Better luck next time'
      @credit -= @bet
      bet = 0
      break
    elsif @player_first_hand_score < 21
      what_to_do(credit, 0)
      sleep(2)
    end
  end
  # If player draws

  # First hand

  # Second hand
  if @player_second_hand_score > 0
    sleep(2)
    system 'clear'
    show_cards(true)
    puts 'Second hand:'
    what_to_do(credit, 2)

    # If player doubles
    if @game_is_on && @answer == 'Double'
      double(false)
    end
    # If player doubles

    # If player draws
    while @game_is_on && @answer == 'Draw' && @player_second_hand_score < 21
      draw(false)
      if @player_second_hand_score > 21
        system 'clear'
        puts 'You burned out! Better luck next time'
        @credit -= @second_bet
        bet = 0
      elsif @player_second_hand_score < 21
        what_to_do(credit, 0)
        sleep(2)
      end
    end
    # If player draws
  end
  #Second hand

  # Show the game
  if @player_first_hand_score || @player_second_hand_score <= 21
    system 'clear'
    @croupier_hand = "#{croupier_1rst_pick[0]} ~~~ #{croupier_2nd_pick[0]}"
    show_cards(false)
    sleep(2)
  else 
    @game_is_on = false
  end
  # Show the game

  # Croupier plays
  puts @game_is_on
  while @game_is_on && @croupier_total_score < 17
    system 'clear'
    croupier_new_pick = @cards_hash.to_a.sample
    @cards_hash.delete(croupier_new_pick[0])
    @croupier_total_score += croupier_new_pick[1].to_i
    @croupier_hand = "#{@croupier_hand} ~~~ #{croupier_new_pick[0]}"
    system 'clear'
    show_cards(false)
    sleep(2)
  end
  # Croupier plays

  # Game results
  if @game_is_on
    system 'clear'
    puts 'First hand:' if @player_second_hand_score > 0
    if @croupier_total_score == @player_first_hand_score
      puts 'Push!'
    elsif @croupier_total_score > 21
      puts 'Croupier burned out!'
      @credit += @bet
    elsif @croupier_total_score > @player_first_hand_score
      puts "Croupier's score is #{@croupier_total_score}! You lost. Better luck next time"
      @credit -= @bet
    elsif @croupier_total_score < @player_first_hand_score && @player_first_hand_score <= 21
      puts "Croupier's score is #{@croupier_total_score}! You won!"
      @credit += @bet
    end

    if @player_second_hand_score > 0
      if @croupier_total_score == @player_second_hand_score
        puts 'Push!'
      elsif @croupier_total_score > 21
        puts 'Croupier burned out!'
        @credit += @second_bet
      elsif @croupier_total_score > @player_second_hand_score
        puts "Croupier's score is #{@croupier_total_score}! You lost. Better luck next time"
        @credit -= @second_bet
      elsif @croupier_total_score < @player_second_hand_score && @player_second_hand_score <= 21
        puts "Croupier's score is #{@croupier_total_score}! You won!"
        @credit += @second_bet
      end
    end
    credit = @credit
  end
  # Game results

  # End game
  sleep(5)
  system 'clear'
  puts "Here are your credits : #{credit}$"
  if credit.positive?
    play_again = true
    while play_again
      puts 'Want to play again?'
      play_q = gets.chomp.downcase
      if play_q == 'y' || play_q == 'yes'
        play = true
        play_again = false
      elsif play_q.to_i > 0 && play_q.to_i <= credit
        play = true
        play_again = false
        new_bet = play_q.to_i
        system 'clear'
        puts "You chose to bet #{new_bet}$"
        sleep(2)
      elsif play_q == 'n' || play_q == 'no'
        puts 'Are you sure you want to quit?'
        confirmation = gets.chomp
        if confirmation == 'y' || confirmation == 'yes'
          play = false
          play_again = false
          puts 'Good bye!'
        end
      else
        puts "I didn't understand"
      end
    end
  else
    puts "You lost! You don't have any credits left"
    play = false
  end
  system 'clear'
  # End Game
end

# For the next patch:

# Croupier can choose ases values automaticaly
# Player and croupier can change already ases chosen values if it burns out
# ? Player can split if it gets two same card in the beggining (like two queens or two fives) ?
