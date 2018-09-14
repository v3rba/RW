class Player

  def play_turn(warrior)
    if @ok
      if warrior.feel.enemy?
        warrior.attack!
        @attack=true # kill a monster
      else
        if @attack and !@fullHP and !(warrior.feel:backward).wall?
          warrior.walk!:backward # back to left to rest
        elsif (warrior.feel:backward).wall? and warrior.health <20
          warrior.rest!
          @fullHP = true
        else
          warrior.walk!
        end
      end
    else
      if (warrior.feel:backward).captive?
        warrior.rescue!:backward
        @ok = true
      else
        warrior.walk!:backward
      end 
    end
  end
  
end