# Possible journal items
#
# item_type         | arg1          | arg2             | arg3             |  arg4     | comments
# ------------------+---------------+------------------+------------------+-----------+---------
# init              | alb email     | fok email        | hal_email        | pfa_email | game created
# ------------------+---------------+------------------+------------------+-----------+---------
# orders            | side name     | order1           | order2           | -         | orders set
# ------------------+---------------+------------------+------------------+-----------+---------
# war_status        | event card #  | card title       | -                | -         | war status begun
# german_morale     | delta         | new value        | -                | -         |
# allied_morale     | delta         | new value        | -                | -         |
# inflation         | new value     | -                | -                | -         | 1..10
# new_contracts     | new total     | card delta       | unfulfilled      | -         |
# reshuffle         | -             | -                | -                | -         |
# allied_upgrade    | new value     | old value        | max player power | d6        |
# allied_no_upgrade | old value     | max player power | -                | -         |
# allied_new_ac     | new value     | dieroll          | -                | -         |
# allied_leap       | new value     | old value        | max player power | d6        |
# new turn          | new value     | -                | -                | -         |

class JournalItem < ActiveRecord::Base
  belongs_to :game

  validates :item_type, :presence => true
  validates :turn,   :presence => true

  attr_accessible :arg1, :arg2, :arg3, :arg4, :game_id, :item_type, :turn

end
