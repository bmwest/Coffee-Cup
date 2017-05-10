require_relative 'coffee_cup'

class Simulation

  def choose_cup
    print "Hello, please select a cup. Print 'tall', 'grande', 'venti', 'trenta', \nor 'doppio'\n> "
    while true
      choice = gets.chomp
      if choice == 'tall' || choice == 'grande' || choice == 'venti' || choice == 'trenta' || choice == 'doppio'
        break
      else
        print "Please select a cup. Print 'tall', 'grande', 'venti', 'trenta', \nor 'doppio'\n> "
      end
    end
    cup = CoffeeCup.new(choice)
  end

  def simulate
    cup = choose_cup
    prompt = "What would you like to do next? Print 'exit' to leave the coffee shop\n> "
    print "You've selected #{cup.size}. Take a 'sip'!\n> "
    while true
      choice = gets.chomp
      if choice.downcase == 'sip'
        cup.sip_outcome(cup, prompt)
      elsif choice.downcase == 'refill'
        cup.refill!
        print prompt
      elsif choice.downcase == 'exit'
        puts "Bye!"
        break
      else
        print "I'm sorry, would you like to take a 'sip', or would you like a 'refill'?\n> "
      end
      if cup.volume == 0
        puts "Oh no! It looks like you've dropped and shattered your coffee mug. \nCome back tomorrow for a new one!"
        break
      end
    end
  end
end
