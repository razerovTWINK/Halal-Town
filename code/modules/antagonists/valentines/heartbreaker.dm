/datum/antagonist/heartbreaker
	name = "heartbreaker"
	roundend_category = "valentines"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE


/datum/antagonist/heartbreaker/proc/forge_objectives()
	var/datum/objective/martyr/normiesgetout = new
	normiesgetout.owner = owner
	objectives += normiesgetout

/datum/antagonist/heartbreaker/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/heartbreaker/greet()
	to_chat(owner, "<span class='warning'><B>Ты остался без пары! Все веселятся без тебя! Но ты им ещё покажешь...</B></span>")
	owner.announce_objectives()
