def make_bet(credit, new_bet)
  bet_valid = false
  if new_bet > 0
    @bet = new_bet
  else
    puts "Here are your credits : #{credit}$"
    puts 'Place your bets:'
    @bet = gets.chomp.to_i
    until bet_valid
      if @bet <= credit && @bet.positive? && (@bet.is_a? Integer)
        bet_valid = true
      else
        puts 'Invalid bet. Please make a valid bet:'
        @bet = gets.chomp.to_i
      end
    end
  end
  new_bet = 0
end

def croupier_picks(croupier_1rst_pick, croupier_2nd_pick)
  @croupier_hand = "### ~~~ #{croupier_2nd_pick[0]}"
  @croupier_total_score = croupier_1rst_pick[1] + croupier_2nd_pick[1]
  @croupier_total_score = 12 if @croupier_total_score == 22
end

def player_picks(player_1rst_pick, player_2nd_pick, player_first_hand)
  player_hand = "#{player_1rst_pick[0]} ~~~ #{player_2nd_pick[0]}"
  if player_first_hand
    @player_first_hand = player_hand
    @player_first_hand_score += player_1rst_pick[1] + player_2nd_pick[1]
  else
    @player_second_hand = player_hand
    @player_second_hand_score += player_1rst_pick[1] + player_2nd_pick[1]
  end
end

def show_cards(show_score)
  puts 'Croupier cards:'
  puts ''
  puts @croupier_hand
  puts ''
  puts 'These are your cards:'
  puts ''
  if @player_second_hand.empty?
    puts @player_first_hand
  else
    puts @player_first_hand + '   ///   ' + @player_second_hand
  end
  puts ''
  # if show_score
  #   if @player_second_hand_score > 0
  #     puts "Here is your first hand score: #{@player_first_hand_score}"
  #     puts "Here is your second hand score: #{@player_second_hand_score}"
  #   else
  #     puts "Here is your score: #{@player_first_hand_score}"
  #   end
  # end
  sleep(1)
end

def blackjack?(player_total_score, croupier_total_score, credit, bet)
  if player_total_score == 21 && croupier_total_score == 21
    puts 'Push! Both did Black Jack'
    @game_is_on = false
  elsif player_total_score == 21
    puts 'Black Jack!'
    credit += (bet * 2.5).round
    @game_is_on = false
  elsif croupier_total_score == 21
    puts 'Black Jack from the croupier! Better luck next time'
    credit -= bet
    @game_is_on = false
  end
end

def what_to_do(credit, first_choice)
  puts 'What do you want to do next?'
  puts ''
  if @bet * 2 <= credit && first_choice && @player_first_hand[0] == @player_first_hand[-2]
    puts "Draw   ~~~   Double   ~~~   Stick   ~~~   Split"
  elsif @bet * 2 <= credit && first_choice
    puts "Draw   ~~~   Double   ~~~   Stick"
  else
    puts "Draw   ~~~   Stick"
  end
  @answer = gets.chomp.capitalize
  puts ''
  if @bet * 2 <= credit && first_choice == 1 && @player_first_hand[0] == @player_first_hand[-2]
    until @answer == 'Draw' || @answer == 'Double' || @answer == 'Stick' || @answer == 'Split'
      puts "I didn't understand, repeat your choice:"
      @answer = gets.chomp.capitalize
    end
  elsif @bet * 2 <= credit && first_choice == 2
    until @answer == 'Draw' || @answer == 'Double' || @answer == 'Stick'
      puts "I didn't understand, repeat your choice:"
      @answer = gets.chomp.capitalize
    end
  else
    until @answer == 'Draw' || @answer == 'Stick'
      puts "I didn't understand, repeat your choice:"
      @answer = gets.chomp.capitalize
  end
  system 'clear'
end

def double(first_hand)
  @double *= 2
  player_new_pick = @cards_hash.to_a.sample
  @cards_hash.delete(player_new_pick[0])
  first_hand ? @player_first_hand = "#{@player_first_hand} ~~~ #{player_new_pick[0]}" : @player_second_hand = "#{@player_second_hand} ~~~ #{player_new_pick[0]}"
  system 'clear'
  puts "You chose to #{@answer}!"
  change_as(player_new_pick) if player_new_pick[1] == 'flexible'
  first_hand ? @player_first_hand_score += player_new_pick[1].to_i : @player_second_hand_score += player_new_pick[1].to_i
  show_cards(true)
  sleep(2)
  system 'clear'
  if first_hand && @player_first_hand_score > 21
    puts 'You burned out! Better luck next time'
    @credit -= (@bet * 2)
    @bet = 0
  elsif !first_hand && @player_second_hand_score > 21
    puts 'You burned out! Better luck next time'
    @credit -= (@second_bet * 2)
    @second_bet = 0
  elsif first_hand
    @bet *= 2
  else
    @second_bet *= 2
  end
end

def draw(first_hand)
  player_new_pick = @cards_hash.to_a.sample
  @cards_hash.delete(player_new_pick[0])
  first_hand ? @player_first_hand = "#{@player_first_hand} ~~~ #{player_new_pick[0]}" : @player_second_hand = "#{@player_second_hand} ~~~ #{player_new_pick[0]}"
  system 'clear'
  puts "You chose to #{@answer}!"
  first_hand ? @player_first_hand_score += player_new_pick[1].to_i : @player_second_hand_score += player_new_pick[1].to_i
  change_as(player_new_pick) if player_new_pick[1] == 'flexible'
  show_cards(true)
  sleep(2)
end

def change_as(player_new_pick)
  as_constant = false
  until as_constant
    puts "You want your #{player_new_pick[0]} to value as a 1 or a 11?"
    new_as_value = gets.chomp.to_i
    case new_as_value
      when 11
        player_new_pick[1] = 11
        as_constant = true
      when  1
        player_new_pick[1] = 1
        as_constant = true
    end
  end
  @player_new_pick = player_new_pick
end
end
