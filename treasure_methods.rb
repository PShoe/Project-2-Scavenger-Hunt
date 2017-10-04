
def not_found

  teams_found_objects = PlayersTreasuresTeam.where(team_id: 2)
  teams_found_objects.each do |found_obj|
    @found_by_this_team = []
    @found_by_this_team.push(found_obj.treasure_id)
    puts @found_by_this_team # 1,2
  end

  treasures_array = Treasure.all
  treasures_array.each do |treasure|
    @all_treasures = []
    @all_treasures.push(treasure.id)
    puts @all_treasures # 1,2,3
  end

  @both_arrays = @all_treasures.concat(@found_by_this_team)
  puts @both_arrays
  @not_yet_found = @both_arrays.uniq

  puts @not_yet_found

end
