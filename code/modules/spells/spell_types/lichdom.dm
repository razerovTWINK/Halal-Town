/obj/effect/proc_holder/spell/targeted/lichdom
	name = "Связывание души"
	desc = "Тёмный некромантический пакт, навеки привязывающий душу к \
	выбранному предмету. Пока твоё тело и предмет остаются \
	целы и находятся в одном плане, ты сможешь возрождаться, но время \
	между перерождениями будет расти, а новое тело-скелет будет \
	испытывать слабость после возрождения. Обратите внимание: \
	обращение в лича уничтожает все органы, кроме мозга."
	school = "necromancy"
	charge_max = 10
	clothes_req = FALSE
	centcom_cancast = FALSE
	invocation = "NECREM IMORTIUM!"
	invocation_type = "shout"
	range = -1
	level_max = 0 //cannot be improved
	cooldown_min = 10
	include_user = TRUE

	action_icon = 'icons/mob/actions/actions_spells.dmi'
	action_icon_state = "skeleton"

/obj/effect/proc_holder/spell/targeted/lichdom/cast(list/targets,mob/user = usr)
	for(var/mob/M in targets)
		var/list/hand_items = list()
		if(iscarbon(M))
			hand_items = list(M.get_active_held_item(),M.get_inactive_held_item())
		if(!hand_items.len)
			to_chat(M, "<span class='warning'>В руках нужно держать предмет, который станет филактерией!</span>")
			return
		if(!M.mind.hasSoul)
			to_chat(user, "<span class='warning'>У тебя нет души!</span>")
			return

		var/obj/item/marked_item

		for(var/obj/item/item in hand_items)
			// I ensouled the nuke disk once. But it's probably a really
			// mean tactic, so probably should discourage it.
			if((item.item_flags & ABSTRACT) || HAS_TRAIT(item, TRAIT_NODROP) || SEND_SIGNAL(item, COMSIG_ITEM_IMBUE_SOUL, user))
				continue
			marked_item = item
			to_chat(M, "<span class='warning'>Ты начинаешь переносить саму свою суть в [item]...</span>")
			break

		if(!marked_item)
			to_chat(M, "<span class='warning'>Ни один из предметов в руках не подходит для вместилища души.</span>")
			return

		playsound(user, 'sound/blank.ogg', 100)

		if(!do_after(M, 50, needhand=FALSE, target=marked_item))
			to_chat(M, "<span class='warning'>Душа возвращается в тело, когда ты прекращаешь одушевление [marked_item]!</span>")
			return

		marked_item.name = "одушевлённый [marked_item.name]"
		marked_item.desc += "\nУжасающая аура окружает этот предмет, само его существование оскорбляет всё живое..."
		marked_item.add_atom_colour("#003300", ADMIN_COLOUR_PRIORITY)

		new /obj/item/phylactery(marked_item, M.mind)

		to_chat(M, "<span class='danger'>С жутким чувством пустоты ты в ужасе наблюдаешь, как плоть сползает с костей! Кровь закипает, нервы распадаются, глаза выкипают в глазницах! Когда твои органы обращаются в прах в бестелесной груди, ты осознаёшь свой выбор. Ты — лич!</span>")
		M.mind.hasSoul = FALSE
		M.set_species(/datum/species/skeleton)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.dropItemToGround(H.wear_pants)
			H.dropItemToGround(H.wear_armor)
			H.dropItemToGround(H.head)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe/black(H), SLOT_ARMOR)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/wizard/black(H), SLOT_HEAD)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/black(H), SLOT_PANTS)

		// you only get one phylactery.
		M.mind.RemoveSpell(src)


/obj/item/phylactery
	name = "филактерия"
	desc = ""
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bluespace"
	color = "#003300"
	light_color = "#003300"
	var/lon_range = 3
	var/resurrections = 0
	var/datum/mind/mind
	var/respawn_time = 1800

	var/static/active_phylacteries = 0

/obj/item/phylactery/Initialize(mapload, datum/mind/newmind)
	. = ..()
	mind = newmind
	name = "филактерия [mind.name]"

	active_phylacteries++
	GLOB.poi_list |= src
	START_PROCESSING(SSobj, src)
	set_light(lon_range)
	if(initial(SSticker.mode.round_ends_with_antag_death))
		SSticker.mode.round_ends_with_antag_death = FALSE

/obj/item/phylactery/Destroy(force=FALSE)
	STOP_PROCESSING(SSobj, src)
	active_phylacteries--
	GLOB.poi_list -= src
	if(!active_phylacteries)
		SSticker.mode.round_ends_with_antag_death = initial(SSticker.mode.round_ends_with_antag_death)
	. = ..()

/obj/item/phylactery/process()
	if(QDELETED(mind))
		qdel(src)
		return

	if(!mind.current || (mind.current && mind.current.stat == DEAD))
		addtimer(CALLBACK(src, .proc/rise), respawn_time, TIMER_UNIQUE)

/obj/item/phylactery/proc/rise()
	if(mind.current && mind.current.stat != DEAD)
		return "[mind] already has a living body: [mind.current]"

	var/turf/item_turf = get_turf(src)
	if(!item_turf)
		return "[src] is not at a turf? NULLSPACE!?"

	var/mob/old_body = mind.current
	var/mob/living/carbon/human/lich = new(item_turf)

	lich.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal/magic(lich), SLOT_SHOES)
	lich.equip_to_slot_or_del(new /obj/item/clothing/under/color/black(lich), SLOT_PANTS)
	lich.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe/black(lich), SLOT_ARMOR)
	lich.equip_to_slot_or_del(new /obj/item/clothing/head/wizard/black(lich), SLOT_HEAD)

	lich.real_name = mind.name
	mind.transfer_to(lich)
	mind.grab_ghost(force=TRUE)
	lich.hardset_dna(null,null,lich.real_name,null, new /datum/species/skeleton)
	to_chat(lich, "<span class='warning'>Кости стучат и содрогаются, пока тебя затягивает обратно в этот мир!</span>")
	var/turf/body_turf = get_turf(old_body)
	lich.Paralyze(200 + 200*resurrections)
	resurrections++
	if(old_body && old_body.loc)
		if(iscarbon(old_body))
			var/mob/living/carbon/C = old_body
			for(var/obj/item/W in C)
				C.dropItemToGround(W)
			for(var/X in C.internal_organs)
				var/obj/item/organ/I = X
				I.Remove(C)
				I.forceMove(body_turf)
		var/wheres_wizdo = dir2text(get_dir(body_turf, item_turf))
		if(wheres_wizdo)
			old_body.visible_message("<span class='warning'>Внезапно останки [old_body.name] рассыпаются на куски! Странная энергия поднимается из них и устремляется в сторону: [wheres_wizdo]!</span>")
			body_turf.Beam(item_turf,icon_state="lichbeam",time=10+10*resurrections,maxdistance=INFINITY)
		old_body.dust()


	return "Respawn of [mind] successful."
