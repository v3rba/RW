class Player

  FULL_HEALTH = 20

  def play_turn(warrior)
    @warrior = warrior
    
    if need_to_rest?
      if able_to_rest?
        warrior.rest!
      else
        warrior.walk!(:backward)
      end
    else
      if warrior.feel.captive?
        warrior.rescue!
      elsif warrior.feel.empty?
        warrior.walk!
      else
        warrior.attack!
      end
    end    

    @previous_health = current_health
  end
  
  def need_to_rest?
    resting_not_completed_yet || current_health < 10
  end
  
  def resting_not_completed_yet
    current_health < FULL_HEALTH && current_health > @previous_health
  end
  
  def able_to_rest?
    @warrior.feel.empty? and not taken_damage?
  end
  
  def taken_damage?
    return false if @previous_health.nil?
    @previous_health > current_health
  end
  
  def current_health
    @warrior.health
  end

end