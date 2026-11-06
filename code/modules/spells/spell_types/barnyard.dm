/obj/effect/proc_holder/spell/targeted/barnyardcurse
	name = "Проклятие скотного двора"
	desc = ""
	school = "transmutation"
	charge_type = "recharge"
	charge_max	= 150
	charge_counter = 0
	clothes_req = FALSE
	stat_allowed = FALSE
	invocation = "KN'A FTAGHU, PUCK 'BTHNK!"
	invocation_type = "shout"
	range = 7
	cooldown_min = 30
	selection_type = "range"
	var/static/list/compatible_mobs_typecache = typecacheof(list(/mob/living/carbon/human, /mob/living/carbon/monkey))

	action_icon_state = "barn"

/obj/effect/proc_holder/spell/targeted/barnyardcurse/cast(list/targets, mob/user = usr)
	if(!targets.len)
		to_chat(user, "<span class='warning'>В пределах досягаемости нет цели!</span>")
		return

	var/mob/living/carbon/target = targets[1]


	if(!is_type_in_typecache(target, compatible_mobs_typecache))
		to_chat(user, "<span class='warning'>Мне не удаётся проклясть голову [target]!</span>")
		return

	if(!(target in oview(range)))
		to_chat(user, "<span class='warning'>[target] слишком далеко!</span>")
		return

	if(target.anti_magic_check())
		to_chat(user, "<span class='warning'>Заклинание не возымело эффекта!</span>")
		target.visible_message("<span class='danger'>Лицо [target] охватывает пламя, но тут же рассеивается, не причинив вреда!</span>", \
						   "<span class='danger'>Моё лицо вспыхивает, но антимагическая защита тут же отталкивает пламя!</span>")
		return

	var/list/masks = list(/obj/item/clothing/mask/pig/cursed, /obj/item/clothing/mask/cowmask/cursed, /obj/item/clothing/mask/horsehead/cursed)

	var/choice = pick(masks)
	var/obj/item/clothing/mask/magichead = new choice(get_turf(target))
	target.visible_message("<span class='danger'>Лицо [target] охватывает пламя, и на его месте появляется морда скотины!</span>", \
						   "<span class='danger'>Моё лицо обжигает пламя, а когда оно гаснет, я чувствую морду скотины вместо своего лица!</span>")
	if(!target.dropItemToGround(target.wear_mask))
		qdel(target.wear_mask)
	target.equip_to_slot_if_possible(magichead, SLOT_WEAR_MASK, 1, 1)

	target.flash_act()
