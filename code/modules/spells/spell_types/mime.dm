/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall
	name = "Невидимая стена"
	desc = ""
	school = "mime"
	panel = "Mime"
	summon_type = list(/obj/effect/forcefield/mime)
	invocation_type = "emote"
	invocation_emote_self = "<span class='notice'>Я возвожу перед собой стену.</span>"
	summon_lifespan = 300
	charge_max = 300
	clothes_req = FALSE
	antimagic_allowed = TRUE
	range = 0
	cast_sound = null
	human_req = TRUE

	action_icon = 'icons/mob/actions/actions_mime.dmi'
	action_icon_state = "invisible_wall"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall/Click()
	if(usr && usr.mind)
		if(!usr.mind.miming)
			to_chat(usr, "<span class='warning'>Сначала нужно принять обет молчания!</span>")
			return
		invocation = "<B>[usr.real_name]</B> показывает, будто перед [usr.p_them()] стоит стена."
	else
		invocation_type ="none"
	..()

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_chair
	name = "Невидимый стул"
	desc = ""
	school = "mime"
	panel = "Mime"
	summon_type = list(/obj/structure/chair/mime)
	invocation_type = "emote"
	invocation_emote_self = "<span class='notice'>Я создаю невидимый стул и сажусь.</span>"
	summon_lifespan = 250
	charge_max = 300
	clothes_req = FALSE
	antimagic_allowed = TRUE
	range = 0
	cast_sound = null
	human_req = TRUE

	action_icon = 'icons/mob/actions/actions_mime.dmi'
	action_icon_state = "invisible_chair"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_chair/Click()
	if(usr && usr.mind)
		if(!usr.mind.miming)
			to_chat(usr, "<span class='warning'>Сначала нужно принять обет молчания!</span>")
			return
		invocation = "<B>[usr.real_name]</B> придвигает невидимый стул и садится."
	else
		invocation_type ="none"
	..()

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_chair/cast(list/targets,mob/user = usr)
	..()
	var/turf/T = user.loc
	for (var/obj/structure/chair/A in T)
		if (is_type_in_list(A, summon_type))
			A.setDir(user.dir)
			A.buckle_mob(user)

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_box
	name = "Невидимая коробка"
	desc = ""
	school = "mime"
	panel = "Mime"
	summon_type = list(/obj/item/storage/box/mime)
	invocation_type = "emote"
	invocation_emote_self = "<span class='notice'>Я создаю невидимую коробку, достаточно вместительную для пары вещей.</span>"
	summon_lifespan = 500
	charge_max = 300
	clothes_req = FALSE
	antimagic_allowed = TRUE
	range = 0
	cast_sound = null
	human_req = TRUE

	action_icon = 'icons/mob/actions/actions_mime.dmi'
	action_icon_state = "invisible_box"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_box/cast(list/targets,mob/user = usr)
	..()
	var/turf/T = user.loc
	for (var/obj/item/storage/box/mime/B in T)
		user.put_in_hands(B)
		B.alpha = 255
		addtimer(CALLBACK(B, /obj/item/storage/box/mime/.proc/emptyStorage, FALSE), (summon_lifespan - 1))

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_box/Click()
	if(usr && usr.mind)
		if(!usr.mind.miming)
			to_chat(usr, "<span class='warning'>Сначала нужно принять обет молчания!</span>")
			return
		invocation = "<B>[usr.real_name]</B> очерчивает руками куб, извлекая коробку прямо из воздуха."
	else
		invocation_type ="none"
	..()


/obj/effect/proc_holder/spell/targeted/mime/speak
	name = "Речь"
	desc = ""
	school = "mime"
	panel = "Mime"
	clothes_req = FALSE
	human_req = TRUE
	antimagic_allowed = TRUE
	charge_max = 3000
	range = -1
	include_user = TRUE

	action_icon = 'icons/mob/actions/actions_mime.dmi'
	action_icon_state = "mime_speech"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/targeted/mime/speak/Click()
	if(!usr)
		return
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/H = usr
	if(H.mind.miming)
		still_recharging_msg = "<span class='warning'>Нельзя нарушить обет молчания так быстро!</span>"
	else
		still_recharging_msg = "<span class='warning'>Придётся подождать, прежде чем снова дать обет молчания!</span>"
	..()

/obj/effect/proc_holder/spell/targeted/mime/speak/cast(list/targets,mob/user = usr)
	for(var/mob/living/carbon/human/H in targets)
		H.mind.miming=!H.mind.miming
		if(H.mind.miming)
			to_chat(H, "<span class='notice'>Я приношу обет молчания.</span>")
			SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "vow")
		else
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "vow", /datum/mood_event/broken_vow)
			to_chat(H, "<span class='notice'>Я нарушаю обет молчания.</span>")

// These spells can only be gotten from the "Guide for Advanced Mimery series" for Mime Traitors.

/obj/effect/proc_holder/spell/targeted/forcewall/mime
	name = "Невидимая баррикада"
	desc = ""
	school = "mime"
	panel = "Mime"
	wall_type = /obj/effect/forcefield/mime/advanced
	invocation_type = "emote"
	invocation_emote_self = "<span class='notice'>Я возвожу перед собой баррикаду.</span>"
	charge_max = 600
	sound =  null
	clothes_req = FALSE
	antimagic_allowed = TRUE
	range = -1
	include_user = TRUE

	action_icon = 'icons/mob/actions/actions_mime.dmi'
	action_icon_state = "invisible_blockade"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/targeted/forcewall/mime/Click()
	if(usr && usr.mind)
		if(!usr.mind.miming)
			to_chat(usr, "<span class='warning'>Сначала нужно принять обет молчания!</span>")
			return
		invocation = "<B>[usr.real_name]</B> показывает, будто перед [usr.p_them()] стоит баррикада."
	else
		invocation_type ="none"
	..()

/obj/effect/proc_holder/spell/aimed/finger_guns
	name = "Пальцестрел"
	desc = ""
	school = "mime"
	panel = "Mime"
	charge_max = 300
	clothes_req = FALSE
	antimagic_allowed = TRUE
	invocation_type = "emote"
	invocation_emote_self = "<span class='dangers'>Я стреляю из пальца!</span>"
	range = 20
	projectile_type = /obj/projectile/bullet/mime
	projectile_amount = 3
	sound = null
	active_msg = "Ты вскидываешь пальцы!"
	deactive_msg = "Ты опускаешь пальцы. В другой раз."
	active = FALSE

	action_icon = 'icons/mob/actions/actions_mime.dmi'
	action_icon_state = "finger_guns0"
	action_background_icon_state = "bg_mime"
	base_icon_state = "finger_guns"


/obj/effect/proc_holder/spell/aimed/finger_guns/Click()
	var/mob/living/carbon/human/owner = usr
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>Нельзя целиться пальцами в беспомощном состоянии.</span>")
		return
	if(usr && usr.mind)
		if(!usr.mind.miming)
			to_chat(usr, "<span class='warning'>Сначала нужно принять обет молчания!</span>")
			return
		invocation = "<B>[usr.real_name]</B> стреляет из пальца!"
	else
		invocation_type ="none"
	..()

/obj/effect/proc_holder/spell/aimed/finger_guns/InterceptClickOn(mob/living/caller, params, atom/target)
	if(caller.incapacitated())
		to_chat(caller, "<span class='warning'>Нельзя целиться пальцами в беспомощном состоянии.</span>")
		if(charge_type == "recharge")
			var/refund_percent = current_amount/projectile_amount
			charge_counter = charge_max * refund_percent
			start_recharge()
		remove_ranged_ability()
		on_deactivation(caller)
	..()

/obj/item/book/granter/spell/mimery_blockade
	spell = /obj/effect/proc_holder/spell/targeted/forcewall/mime
	spellname = "Невидимая баррикада"
	name = "Руководство по продвинутой пантомиме. Том 1"
	desc = ""
	icon_state ="bookmime"
	remarks = list("...")

/obj/item/book/granter/spell/mimery_blockade/attack_self(mob/user)
	. = ..()
	if(!.)
		return
	if(!locate(/obj/effect/proc_holder/spell/targeted/mime/speak) in user.mind.spell_list)
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/mime/speak)

/obj/item/book/granter/spell/mimery_guns
	spell = /obj/effect/proc_holder/spell/aimed/finger_guns
	spellname = "Пальцестрел"
	name = "Руководство по продвинутой пантомиме. Том 2"
	desc = ""
	icon_state ="bookmime"
	remarks = list("...")

/obj/item/book/granter/spell/mimery_guns/attack_self(mob/user)
	. = ..()
	if(!.)
		return
	if(!locate(/obj/effect/proc_holder/spell/targeted/mime/speak) in user.mind.spell_list)
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/mime/speak)
