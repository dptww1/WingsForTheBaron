$ ->
  $("#execute_war_status_phase").bind "ajax:success",
    (event, data) ->
      for item in data

        $("#journal_items").prepend("<tr><td>#{item.created_at}</td><td>#{item.event_text}</td></tr>")

        switch item.item_type
          when "allied_upgrade", "allied_new_ac", "allied_leap"
            $("#allied_power").html(item.arg1)
            $("#allied_power").effect("highlight", {}, 1000)

          when "allied_morale"
            $("#allied_morale").html(item.arg2)
            $("#allied_morale").effect("highlight", {}, 1000)

          when "german_morale"
            $("#german_morale").html(item.arg2)
            $("#german_morale").effect("highlight", {}, 1000)

          when "inflation"
            $("#inflation").html(item.arg1 + "0%")
            $("#inflation").effect("highlight", {}, 1000)

          when "new_contracts"
            $("#contracts_available").html(item.arg1);
            $("#contracts_available").effect("highlight", {}, 1000)

          when "new_turn"
            $("#turn").html(item.arg1)
            $("#turn").effect("highlight", {}, 1000)
