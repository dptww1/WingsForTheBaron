$ ->
  $("#execute_war_status_phase").bind "ajax:success",
    (event, data) ->
      for journalItem in data
        switch journalItem.item_type
          when "allied_upgrade", "allied_new_ac", "allied_leap"
            $("#allied_power").html(journalItem.arg1)
            $("#allied_power").effect("highlight", {}, 1000)

          when "allied_morale"
            $("#allied_morale").html(journalItem.arg2)
            $("#allied_morale").effect("highlight", {}, 1000)

          when "german_morale"
            $("#german_morale").html(journalItem.arg2)
            $("#german_morale").effect("highlight", {}, 1000)

          when "inflation"
            $("#inflation").html(journalItem.arg1 + "0%")
            $("#inflation").effect("highlight", {}, 1000)

          when "new_contracts"
            $("#contracts_available").html(journalItem.arg1);
            $("#contracts_available").effect("highlight", {}, 1000)

          when "new_turn"
            $("#turn").html(journalItem.arg1)
            $("#turn").effect("highlight", {}, 1000)
