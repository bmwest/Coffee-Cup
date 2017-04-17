class CoffeeCup
  attr_reader :size
  def cup_parameters(vol1, vol2)
    @volume = vol1
    @volume_max = vol2
  end

  def initialize(size = nil, volume = nil, volume_max = nil)
    @size = size
    if @size.kind_of?(NilClass)
      cup_parameters(8, 12)
    else
      if @volume.kind_of?(NilClass) || @volume_max.kind_of?(NilClass)
        if @size.kind_of?(Fixnum)
          @size = nil
          @volume = size
          @volume_max = volume
        elsif size.kind_of?(NilClass) || size.downcase == 'tall'
          cup_parameters(8, 12)
        elsif size.downcase == 'grande'
          cup_parameters(12, 16)
        elsif size.downcase == 'venti'
          cup_parameters(16, 20)
        elsif size.downcase == 'trenta'
          cup_parameters(27, 31)
        elsif size.downcase == 'doppio'
          cup_parameters(2, 2)
        end
      else
        @volume = volume
        @volume_max = volume_max
      end
    end
  end

  def volume
    @volume
  end

  def sip!
    @volume = volume - rand(1..8)
    if @volume <= 0
      puts "Hey! You need a refill!"
      @volume = 0
    else
      puts "You took a sip, and now have #{@volume}oz left!"
    end
  end

  def spill!
    @volume = 0
  end

  def refill!
    if @volume_max == 2
      @volume = @volume_max
      puts "You got a refill, and now have #{@volume}oz left!"
    else
      @volume = @volume_max - 2
      puts "You got a refill, and now have #{@volume}oz left!"
    end
  end
end

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

def sip(cup, prompt)
  chance = rand(1..4)
  if chance == 2
    cup.spill!
  else
    cup.sip!
  end
  if cup.volume > 0
    print prompt
  end
end

def simulate
  cup = choose_cup
  prompt = "What would you like to do next? Print 'exit' to leave the coffee shop\n> "
  print "You've selected #{cup.size}. Take a 'sip'!\n> "
  while true
    choice = gets.chomp
    if choice.downcase == 'sip'
      sip(cup, prompt)
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
      puts "Oh no! It looks like you've dropped and shattered your coffee mug. Come back tomorrow for a new one!"
      break
    end
  end
end

simulate
