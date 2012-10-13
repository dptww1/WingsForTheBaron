# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

WarStatusCard.delete_all
WarStatusCard.create(card_num:               1,
                     title:                  "All Quiet on the Western Front",
                     do_inflation:           false,
                     german_morale_loss:     1,
                     allied_morale_loss:     1,
                     new_contracts:          4,
                     do_reshuffle:           true,
                     upgraded_allied_ac:     true,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               2,
                     title:                  "German Withdrawal",
                     do_inflation:           false,
                     german_morale_loss:     1,
                     allied_morale_loss:     2,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     true,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               3,
                     title:                  "Romania Overrun",
                     do_inflation:           false,
                     german_morale_loss:     1,
                     allied_morale_loss:     3,
                     new_contracts:          3,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     true,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               4,
                     title:                  "Russia Collapse",
                     do_inflation:           false,
                     german_morale_loss:     1,
                     allied_morale_loss:     4,
                     new_contracts:          2,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               5,
                     title:                  "Chemin des Dames",
                     do_inflation:           false,
                     german_morale_loss:     2,
                     allied_morale_loss:     4,
                     new_contracts:          3,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               6,
                     title:                  "Bloody April",
                     do_inflation:           false,
                     german_morale_loss:     2,
                     allied_morale_loss:     2,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     true,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               7,
                     title:                  "U.S. Enters the War",
                     do_inflation:           true,
                     german_morale_loss:     2,
                     allied_morale_loss:     1,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     true,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               8,
                     title:                  "Jutland",
                     do_inflation:           false,
                     german_morale_loss:     2,
                     allied_morale_loss:     3,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     true,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               9,
                     title:                  "Blockade",
                     do_inflation:           true,
                     german_morale_loss:     3,
                     allied_morale_loss:     1,
                     new_contracts:          2,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          true,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               10,
                     title:                  "Vittorio Veneto",
                     do_inflation:           true,
                     german_morale_loss:     3,
                     allied_morale_loss:     2,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          true,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               11,
                     title:                  "Kaiserschlacht",
                     do_inflation:           false,
                     german_morale_loss:     3,
                     allied_morale_loss:     3,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          true,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               12,
                     title:                  "The Somme",
                     do_inflation:           false,
                     german_morale_loss:     3,
                     allied_morale_loss:     4,
                     new_contracts:          4,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

WarStatusCard.create(card_num:               13,
                     title:                  "Black Day of the German Army",
                     do_inflation:           true,
                     german_morale_loss:     4,
                     allied_morale_loss:     1,
                     new_contracts:          3,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: true)

WarStatusCard.create(card_num:               14,
                     title:                  "Meggido",
                     do_inflation:           true,
                     german_morale_loss:     4,
                     allied_morale_loss:     2,
                     new_contracts:          3,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: true)

WarStatusCard.create(card_num:               15,
                     title:                  "Verdun",
                     do_inflation:           true,
                     german_morale_loss:     4,
                     allied_morale_loss:     3,
                     new_contracts:          2,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: true)

WarStatusCard.create(card_num:               16,
                     title:                  "War Weariness",
                     do_inflation:           false,
                     german_morale_loss:     4,
                     allied_morale_loss:     4,
                     new_contracts:          3,
                     do_reshuffle:           false,
                     upgraded_allied_ac:     false,
                     new_allied_ac:          false,
                     allied_technology_leap: false)

