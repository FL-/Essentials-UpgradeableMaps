# This script add upgradable maps (when map was loaded), made by FL 
# To install, put it above main. After line
# '@map = load_data(sprintf("Data/Map%03d.rxdata", map_id))'
# add line 'process_map(@map, map_id)'

UPGRADABLE_MAP_MULTIARRAY = [
  # Add maps here
  # [Map id, upgrade version map id, switch, x range, y range],
  [8, 4, 90, 0..1, 0..2],   # Means Oak Lab (4) will be copied into Daisy's House (8)
  [8, 4, 90, 11..12, 0..2], # Same thing, but other coordinates
]

def process_map(map, map_id)
  extra_map_hash = {}
  for map_array in UPGRADABLE_MAP_MULTIARRAY
    next if map_id != map_array[0]
    switch_number = map_array[2]
    next if !$game_switches[switch_number]
    target_map_id = map_array[1]
    if !extra_map_hash.has_key?(target_map_id)
      extra_map_hash[target_map_id] = load_data(
        sprintf("Data/Map%03d.rxdata", target_map_id)
      )
    end
    x_range = map_array[3]
    y_range = map_array[4]
    for x in x_range
      for y in y_range
        for l in [2, 1, 0]
          map.data[x,y,l] = extra_map_hash[target_map_id].data[x,y,l] 
        end
      end
    end
  end
end