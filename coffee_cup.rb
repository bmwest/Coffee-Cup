require_relative 'simulation'

class CoffeeCup
  attr_reader :size
  attr_accessor :volume

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

  def sip_outcome(cup, prompt)
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
end
