# Possible journal items
#
# item_type     | arg1         | arg2      | arg3      |  arg4     | comments
# --------------+--------------+-----------+-----------+-----------+---------
# init          | alb email    | fok email | hal_email | pfa_email | game created
# orders        | side name    | order1    | order2    | -         | orders set
# war_status    | event card # | -         | -         | -         | war status begun
# german_morale | delta        | new value | -         | -         |
# allied_morale | delta        | new value | -         | -         |

class JournalItem < ActiveRecord::Base
  belongs_to :game

  validates :item_type, :presence => true
  validates :turn,   :presence => true

  attr_accessible :arg1, :arg2, :arg3, :arg4, :game_id, :item_type, :turn

end
