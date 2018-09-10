class Player

  def play_turn(warrior)
    @health = warrior.health
    if warrior.feel.captive?
      warrior.rescue!
      @shooter = true
    else
      if warrior.look[1].enemy?
        warrior.shoot!
      else
        warrior.walk!
      end      
    end
  end
end
