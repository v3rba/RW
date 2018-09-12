class Player
  def initialize
    @max_health = 20
    @retreat_point = @max_health / 2
    @recovery_point = @max_health * 3 / 4
    @last_health = @max_health
  end
  
  def continue(warrior)
    space = warrior.feel
    if any_enemies(warrior)
      face_enemies(warrior)
    elsif space.wall?
      warrior.pivot!
    elsif space.captive?
      warrior.rescue!
    else
      warrior.walk!
    end
  end
  
  def any_enemies(warrior)
    look_for_enemies(warrior) or look_for_enemies(warrior, :backward)
  end

  def look_for_enemies(warrior, direction = :forward)
    enemy_spaces = warrior.look(direction).find_all {|space| space.enemy? }
    return enemy_spaces.any?
  end
  
  def face_enemies(warrior)
    if warrior.feel(:backward).enemy?
      warrior.pivot!
    elsif warrior.feel.enemy?
      warrior.attack!
    elsif look_for_enemies(warrior, :backward)
      warrior.shoot!(:backward)
    elsif look_for_enemies(warrior)
      warrior.shoot!
    end
  end
  
  def attacked(warrior)
    warrior.health < @last_health
  end
  
  def play_turn(warrior)
    if attacked(warrior) and warrior.health <= @retreat_point
      warrior.walk!(:backward)
    elsif (attacked(warrior) and warrior.health > @retreat_point)
      face_enemies(warrior)
    elsif warrior.health <= @recovery_point
      warrior.rest!
    else
      continue(warrior)
    end
      
    @last_health = warrior.health
  end
end
