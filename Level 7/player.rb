class Player
  def play_turn(warrior)
    if warrior.feel.wall?
      warrior.pivot!
    elsif warrior.feel.enemy?
      warrior.attack!
    elsif warrior.health < 20 && warrior.feel(:backward).wall?
      warrior.rest!
    elsif warrior.health < 15
      warrior.walk!(:backward)
    elsif warrior.feel.empty?
      warrior.walk!
    end
  end
end
