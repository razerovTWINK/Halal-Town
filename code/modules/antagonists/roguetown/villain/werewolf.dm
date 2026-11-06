#ifdef TESTSERVER
/mob/living/carbon/human/verb/become_werewolf()
	set category = "DEBUGTEST"
	set name = "WEREWOLFTEST"
	if(mind)
		var/datum/antagonist/werewolf/new_antag = new /datum/antagonist/werewolf()
		mind.add_antag_datum(new_antag)
#endif

/datum/antagonist/werewolf
	name = "Werewolf"
	roundend_category = "Werewolves"
	antagpanel_category = "Werewolf"
	job_rank = ROLE_WEREWOLF
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "werewolf"
	var/special_role = ROLE_WEREWOLF
	var/transformed
	var/transforming
	var/transform_cooldown
	confess_lines = list("ЗВЕРЬ ВНУТРИ МЕНЯ!", "БОЙТЕСЬ ЗВЕРЯ!", "ВОЛЧЬЯ МЕТКА!")
	var/wolfname = "Werevolf"
	var/last_howl = 0
	var/pre_transform
	var/next_idle_sound

/datum/antagonist/werewolf/lesser
	name = "Lesser Werewolf"
	increase_votepwr = FALSE

/datum/antagonist/werewolf/lesser/roundend_report()
	return

/datum/antagonist/werewolf/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/werewolf/lesser))
		return "<span class='boldnotice'>Молодой волчий сородич.</span>"
	if(istype(examined_datum, /datum/antagonist/werewolf))
		return "<span class='boldnotice'>Старший волчий сородич.</span>"
	if(examiner.Adjacent(examined))
		if(istype(examined_datum, /datum/antagonist/vampirelord/lesser))
			if(transformed)
				return "<span class='boldwarning'>Низший вампир.</span>"
		if(istype(examined_datum, /datum/antagonist/vampirelord))
			if(transformed)
				return "<span class='boldwarning'>Древний вампир. Мне стоит быть осторожнее!</span>"

/datum/antagonist/werewolf/on_gain()
	transform_cooldown = SSticker.round_start_time
	owner.special_role = name
	if(increase_votepwr)
		forge_werewolf_objectives()
	finalize_werewolf()
	wolfname = "[pick_n_take(GLOB.wolf_prefixes)] [pick_n_take(GLOB.wolf_suffixes)]"
	return ..()

/datum/antagonist/werewolf/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,"<span class='danger'>Я больше не оборотень!</span>")
	owner.special_role = null
	return ..()

/datum/antagonist/werewolf/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/werewolf/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/werewolf/proc/forge_werewolf_objectives()
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/werewolf/escape_objective = new
		escape_objective.owner = owner
		add_objective(escape_objective)
		return

/datum/antagonist/werewolf/greet()
	to_chat(owner.current, "<span class='userdanger'>С того самого укуса я — ОБОРОТЕНЬ.</span>")
	owner.announce_objectives()
	..()

/datum/antagonist/werewolf/proc/finalize_werewolf()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/wolfintro.ogg', 80, FALSE, pressure_affected = FALSE)
	

/datum/antagonist/werewolf/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
		return

	if(transformed)
		H.real_name = wolfname
		H.name = "WEREVOLF"

	if(!transforming && !transformed)
		if(world.time % 5)
			if(GLOB.tod == "night")
				if(isturf(H.loc))
					var/turf/T = H.loc
					if(T.can_see_sky())
						transforming = world.time
						to_chat(H, "<span class='userdanger'>ЛУННЫЙ СВЕТ ПРЕЗИРАЕТ МЕНЯ... ВОЛЧЬЯ МЕТКА!</span>")
						H.flash_fullscreen("redflash3")

	if(transforming)
		if(world.time >= transforming + 40 SECONDS)
			H.flash_fullscreen("redflash3")
			transforming = FALSE
			pre_transform = FALSE
			if(transformed)
				transformed = FALSE
				H.werewolf_untransform()
			else
				transformed = TRUE
				H.werewolf_transform()
		else if(world.time >= transforming + 35 SECONDS)
			if(!pre_transform)
				pre_transform = TRUE
				if(transformed)
					H.emote("rage", forced = TRUE)
				else
					H.emote("agony", forced = TRUE)
				H.flash_fullscreen("redflash3")
				H.Stun(30)
				to_chat(H, "<span class='userdanger'>КАКАЯ БОЛЬ!</span>")
	else
		if(transformed)
			if(H.m_intent != MOVE_INTENT_SNEAK)
				if(world.time > next_idle_sound + 8 SECONDS)
					next_idle_sound = world.time
					H.emote("idle")
			if(GLOB.tod != "night")
				H.flash_fullscreen("redflash1")
				to_chat(H, "<span class='warning'>Проклятие начинает отступать...</span>")
				transforming = world.time

/mob/living/carbon/human/proc/howl_button()
	set name = "Howl"
	set category = "WEREWOLF"

	if(stat)
		return
	var/datum/antagonist/werewolf/WD = mind.has_antag_datum(/datum/antagonist/werewolf)
	if(WD && WD.transformed)
		if(world.time > WD.last_howl + 10 SECONDS)
			var/message = stripped_input(src, "Вой на сокрытую луну", "ОБОРОТЕНЬ")
			if(!message)
				return
			if(world.time < WD.last_howl + 10 SECONDS)
				return
			WD.last_howl = world.time
			playsound(src, pick('sound/vo/mobs/wwolf/howl (1).ogg','sound/vo/mobs/wwolf/howl (2).ogg'), 100, TRUE)
			for(var/mob/player in GLOB.player_list)
				if(player.mind)
					if(player.stat == DEAD)
						continue
					if(isbrain(player)) //also technically dead
						continue
					if(player.mind.has_antag_datum(/datum/antagonist/werewolf))
						to_chat(player, "<span class='boldannounce'>[WD.wolfname] воет: [message]</span>")
				if(player == src)
					continue
				if(get_dist(player, src) > 7)
					player.playsound_local(get_turf(player), pick('sound/vo/mobs/wwolf/howldist (1).ogg','sound/vo/mobs/wwolf/howldist (2).ogg'), 100, FALSE, pressure_affected = FALSE)
			playsound(src, pick('sound/vo/mobs/wwolf/howl (1).ogg','sound/vo/mobs/wwolf/howl (2).ogg'), 100, TRUE)
		else
			to_chat(src, "<span class='warning'>Мне нужно подождать.</span>")
			return


/mob/living/carbon/human/proc/werewolf_infect()
	if(!mind)
		return
	if(mind.has_antag_datum(/datum/antagonist/vampirelord))
		return
	if(mind.has_antag_datum(/datum/antagonist/zombie))
		return
	if(mind.has_antag_datum(/datum/antagonist/werewolf))
		return
	var/datum/antagonist/werewolf/new_antag = new /datum/antagonist/werewolf/lesser()
	mind.add_antag_datum(new_antag)
	new_antag.transforming = world.time
	to_chat(src, "<span class='danger'>Мне ужасно плохо...</span>")
	src.playsound_local(get_turf(src), 'sound/music/horror.ogg', 80, FALSE, pressure_affected = FALSE)
	flash_fullscreen("redflash3")
