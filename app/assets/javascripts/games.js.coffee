$ ->
  $("#execute_war_status_phase").bind "ajax:success",
    (event, data) ->
      for journalItem in data
        switch journalItem.item_type
          when "german_morale"
            $("#german_morale").html(journalItem.arg2)
            $("#german_morale").effect("highlight", {}, 2000)

          when "allied_morale"
            $("#allied_morale").html(journalItem.arg2)
            $("#allied_morale").effect("highlight", {}, 2000)
