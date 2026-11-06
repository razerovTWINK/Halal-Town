/// DEFINITIONS ///
#define VAMP_LEVEL_ONE 10000
#define VAMP_LEVEL_TWO 12000
#define VAMP_LEVEL_THREE 15000
#define VAMP_LEVEL_FOUR 20000

#define MOBSTATS list("strength", "perception", "intelligence", "constitution", "endurance", "speed", "fortune")

/datum/antagonist/vampirelord
	name = "Vampire Lord"
	roundend_category = "Vampires"
	antagpanel_category = "Vampire"
	job_rank = ROLE_VAMPIRE
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "vampire"
	confess_lines = list("Я ДРЕВЕН", "Я ЭТА ЗЕМЛЯ", "ДИТЯ КАИНА!")
	var/isspawn = FALSE
	var/disguised = FALSE
	var/ascended = FALSE
	var/starved = FALSE
	var/sired = FALSE
	var/vamplevel = 0
	var/vitae = 1000
	var/vmax = 2000
	var/obj/structure/vampire/bloodpool/mypool
	var/last_transform
	var/cache_skin
	var/cache_eyes
	var/cache_hair
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform/gas

/datum/antagonist/vampirelord/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord/lesser))
		return "<span class='boldnotice'>Вампирское отродье.</span>"
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		return "<span class='boldnotice'>Вампирский лорд!</span>"
	if(istype(examined_datum, /datum/antagonist/zombie))
		return "<span class='boldnotice'>Ещё один мертвец.</span>"
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return "<span class='boldnotice'>Ещё один мертвец.</span>"

/datum/antagonist/vampirelord/on_gain()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	C.vampires |= owner
	. = ..()
	owner.special_role = name
	ADD_TRAIT(owner.current, RTRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_NOFATSTAM, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_LIMPDICK, TRAIT_GENERIC)
	ADD_TRAIT(owner.current, TRAIT_VAMPMANSION, TRAIT_GENERIC)
	owner.current.cmode_music = 'sound/music/combatvamp.ogg'
	var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(owner.current,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(owner.current)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix)
	owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
	owner.current.verbs |= /mob/living/carbon/human/proc/vampire_telepathy
	vamp_look()
	if(isspawn)
		owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button
		add_objective(/datum/objective/vlordserve)
		finalize_vampire_lesser()
		for(var/obj/structure/vampire/bloodpool/mansion in world)
			mypool = mansion
		equip_spawn()
		greet()
		addtimer(CALLBACK(owner.current, /mob/living/carbon/human/.proc/spawn_pick_class, "VAMPIRE SPAWN"), 5 SECONDS)
	else
		forge_vampirelord_objectives()
		finalize_vampire()
		owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
		owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
		for(var/obj/structure/vampire/bloodpool/mansion in world)
			mypool = mansion
		equip_lord()
		addtimer(CALLBACK(owner.current, /mob/living/carbon/human/.proc/choose_name_popup, "VAMPIRE LORD"), 5 SECONDS)
		greet()
	return ..()
// OLD AND EDITED
/datum/antagonist/vampirelord/proc/equip_lord()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	if(H.mobid in GLOB.character_list)
		GLOB.character_list[H.mobid] = null
	GLOB.chosen_names -= H.real_name
	if(H.dna.species?.id != "human" && H.dna.species?.id != "elf")
		H.age = AGE_ADULT
		if(prob(50))
			H.set_species(/datum/species/human/northern)
		else
			H.set_species(/datum/species/elf/snow) //setspecies randomizes body
		H.after_creation()
	H.equipOutfit(/datum/outfit/job/roguetown/vamplord)

	return TRUE

/datum/antagonist/vampirelord/proc/equip_spawn()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	if(H.mobid in GLOB.character_list)
		GLOB.character_list[H.mobid] = null
	GLOB.chosen_names -= H.real_name
	owner.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	owner.current.ambushable = FALSE

/mob/living/carbon/human/proc/spawn_pick_class()
	var/list/classoptions = list("Bard", "Fisher", "Hunter", "Miner", "Peasant", "Woodcutter", "Cheesemaker", "Blacksmith", "Carpenter", "Rogue", "Treasure Hunter", "Mage", "Sorceress")
	var/list/visoptions = list()

	for(var/T in 1 to 5)
		var/picked = pick(classoptions)
		visoptions |= picked

	var/selected = input(src, "Кем я был при жизни?", "ОТРОДЬЕ ВАМПИРА") as anything in visoptions

	for(var/datum/advclass/A in GLOB.adv_classes)
		if(A.name == selected)
			equipOutfit(A.outfit)
			return

/datum/outfit/job/roguetown/vamplord/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/vampire
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	head  = /obj/item/clothing/head/roguetown/vampire
	beltl = /obj/item/roguekey/vampire
	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel/black
	H.ambushable = FALSE

////////Outfits////////
/obj/item/clothing/under/roguetown/platelegs/vampire
	name = "древние латные поножи"
	desc = ""
	gender = PLURAL
	icon_state = "vpants"
	item_state = "vpants"
	sewrepair = FALSE
	armor = list("melee" = 100, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = PLATEHIT
	do_sound = FALSE
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD

/obj/item/clothing/suit/roguetown/shirt/vampire
	slot_flags = ITEM_SLOT_SHIRT
	name = "царственные шелка"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "vrobe"
	item_state = "vrobe"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/head/roguetown/vampire
	name = "корона тьмы"
	icon_state = "vcrown"
	body_parts_covered = null
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = null
	sellprice = 1000
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/roguetown/armor/chainmail/iron/vampire
	icon_state = "vunder"
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	name = "древняя кольчужная рубаха"
	desc = ""
	body_parts_covered = CHEST|GROIN|VITALS
	armor_class = 2

/obj/item/clothing/suit/roguetown/armor/plate/vampire
	slot_flags = ITEM_SLOT_ARMOR
	name = "древний церемониальный латный доспех"
	desc = ""
	body_parts_covered = CHEST|GROIN|VITALS
	icon_state = "vplate"
	item_state = "vplate"
	armor = list("melee" = 100, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT)
	nodismemsleeves = TRUE
	max_integrity = 500
	allowed_sex = list(MALE, FEMALE)
	do_sound = TRUE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 40
	armor_class = 3

/obj/item/clothing/shoes/roguetown/boots/armor/vampire
	name = "древние церемониальные латные сапоги"
	desc = ""
	body_parts_covered = FEET
	icon_state = "vboots"
	item_state = "vboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT)
	color = null
	blocksound = PLATEHIT
	armor = list("melee" = 100, "bullet" = 100, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/roguetown/helmet/heavy/guard
	name = "древний церемониальный шлем"
	icon_state = "vhelmet"

/obj/item/clothing/gloves/roguetown/chain/vampire
	name = "древние церемониальные перчатки"
	icon_state = "vgloves"

/datum/antagonist/vampirelord/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,"<span class='danger'>Я больше не вампир!</span>")
	owner.special_role = null
	if(!isnull(batform))
		owner.current.RemoveSpell(batform)
		QDEL_NULL(batform)
	return ..()
/datum/antagonist/vampirelord/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/vampirelord/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/vampirelord/proc/forge_vampirelord_objectives()
	var/list/primary = pick(list("1", "2"))
	var/list/secondary = pick(list("1", "2", "3"))
	switch(primary)
		if("1")
			var/datum/objective/vampirelord/conquer/T = new
			objectives += T
		if("2")
			var/datum/objective/vampirelord/ascend/T = new
			objectives += T
	switch(secondary)
		if("1")
			var/datum/objective/vampirelord/infiltrate/one/T = new
			objectives += T
		if("2")
			var/datum/objective/vampirelord/infiltrate/two/T = new
			objectives += T
		if("3")
			var/datum/objective/vampirelord/spread/T = new
			objectives += T
	var/datum/objective/vlordsurvive/survive = new
	objectives += survive

/datum/antagonist/vampirelord/greet()
	to_chat(owner.current, "<span class='userdanger'>Я — древность. Я — эта Земля. И я пробудился, чтобы покарать тех, кто посмел ступить в мои владения.</span>")
	owner.announce_objectives()
	..()

/datum/antagonist/vampirelord/lesser/greet()
	to_chat(owner.current, "<span class='userdanger'>Мы пробудились ото сна — порождения грозного Вампирского лорда.</span>")
	owner.announce_objectives()

/datum/antagonist/vampirelord/proc/finalize_vampire()
	owner.current.forceMove(pick(GLOB.vlord_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)
	

/datum/antagonist/vampirelord/proc/finalize_vampire_lesser()
	if(!sired)
		owner.current.forceMove(pick(GLOB.vspawn_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)
	

/datum/antagonist/vampirelord/proc/vamp_look()
	var/mob/living/carbon/human/V = owner.current
	cache_skin = V.skin_tone
	cache_eyes = V.eye_color
	cache_hair = V.hair_color
	V.skin_tone = "c9d3de"
	V.hair_color = "181a1d"
	V.facial_hair_color = "181a1d"
	V.eye_color = "ff0000"
	V.update_body()
	V.update_hair()
	V.update_body_parts(redraw = TRUE)
	V.mob_biotypes = MOB_UNDEAD
	if(isspawn)
		V.vampire_disguise()

/datum/antagonist/vampirelord/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
		return
	if(!isspawn)
		vitae = mypool.current
	if(ascended)
		return
	if(world.time % 5)
		if(GLOB.tod != "night")
			if(isturf(H.loc))
				var/turf/T = H.loc
				if(T.can_see_sky())
					if(T.get_lumcount() > 0.15)
						if(!isspawn)
							to_chat(H, "<span class='warning'>Астрата отвергает меня! Нужно уйти из-под её лучей!</span>") // VLord is more punished for daylight excursions.
							sleep(100)
							var/turf/N = H.loc
							if(N.can_see_sky())
								if(N.get_lumcount() > 0.15)
									H.dust()
							to_chat(H, "<span class='warning'>Было слишком близко. Мне нужно избегать солнца.</span>")
						else if (isspawn && !disguised)
							H.fire_act(1,5)
							handle_vitae(-10)

	if(H.on_fire)
		if(disguised)
			last_transform = world.time
			H.vampire_undisguise(src)
		H.freak_out()

	if(H.stat)
		if(istype(H.loc, /obj/structure/closet/crate/coffin))
			H.fully_heal()

	if(vitae > 0)
		H.blood_volume = BLOOD_VOLUME_MAXIMUM
		if(vitae < 200)
			if(disguised)
				to_chat(H, "<span class='warning'>Моя маскировка спадает!</span>")
				H.vampire_undisguise(src)
	handle_vitae(-1)

/datum/antagonist/vampirelord/proc/handle_vitae(change, tribute)
	var/tempcurrent = vitae
	if(!isspawn)
		mypool.update_pool(change)
	if(isspawn)
		if(change > 0)
			tempcurrent += change
			if(tempcurrent > vmax)
				tempcurrent = vmax // to prevent overflow
		if(change < 0)
			tempcurrent += change
			if(tempcurrent < 0)
				tempcurrent = 0 // to prevent excessive negative.
		vitae = tempcurrent
	if(tribute)
		mypool.update_pool(tribute)
	if(vitae <= 20)
		if(!starved)
			to_chat(owner, "<span class='userdanger'>Я голодаю, мои силы тают! Я так слаб!</span>")
			starved = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, -5)
	else
		if(starved)
			starved = FALSE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 5)

/datum/antagonist/vampirelord/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlord_starts))

/datum/antagonist/vampirelord/proc/grow_in_power()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	switch(vamplevel)
		if(0)
			vamplevel = 1
			batform = new
			owner.current.AddSpell(batform)
			for(var/obj/structure/vampire/portalmaker/S in world)
				S.unlocked = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			for(var/obj/structure/vampire/bloodpool/B in world)
				B.nextlevel = VAMP_LEVEL_TWO
			to_chat(owner, "<font color='red'>Мои силы восстановились, я стал сильнее. Облик летучей мыши вновь доступен мне. Я также снова могу использовать свои порталы.</font>")
		if(1)
			vamplevel = 2
			owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsteal)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
			owner.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
			gas = new
			owner.current.AddSpell(gas)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			for(var/obj/structure/vampire/bloodpool/B in world)
				B.nextlevel = VAMP_LEVEL_THREE
			to_chat(owner, "<font color='red'>Моя сила возвращается. Заклинания снова подвластны мне. Я также вновь могу принимать облик тумана.</font>")
		if(2)
			vamplevel = 3
			for(var/obj/structure/vampire/necromanticbook/S in world)
				S.unlocked = TRUE
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_strength
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
			owner.current.RemoveSpell(/obj/effect/proc_holder/spell/targeted/transfix)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix/master)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			for(var/obj/structure/vampire/bloodpool/B in world)
				B.nextlevel = VAMP_LEVEL_FOUR
			to_chat(owner, "<font color='red'>Власть над чужими разумами и моим собственным телом возвращается. Я приближаюсь к совершенству. Армии мертвецов теперь отзовутся на мой зов.</font>")
		if(3)
			vamplevel = 4
			owner.current.visible_message("<font color='red'>[owner.current] окутывает тёмно-багровое сияние, по округе разносится ужасающий гул. Тело преобразилось.</font>","<font color='red'>Я ДРЕВЕН, Я ЭТА ЗЕМЛЯ. ДАЖЕ СОЛНЦЕ СКЛОНЯЕТСЯ ПЕРЕДО МНОЙ.</font>")
			ascended = TRUE
			C.ascended = TRUE
			for(var/datum/mind/thrall in C.vampires)
				if(thrall.special_role == "Vampire Spawn")
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_strength
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
					thrall.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
					for(var/S in MOBSTATS)
						thrall.current.change_stat(S, 2)
	return

// SPAWN
/datum/antagonist/vampirelord/lesser
	name = "Vampire Spawn"
	confess_lines = list("БАГРОВЫЙ ЗОВ!", "МОЙ ГОСПОДИН ПРИКАЗЫВАЕТ", "СОЛНЦЕ — ВРАГ!")
	isspawn = TRUE

/datum/antagonist/vampirelord/lesser/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlordspawn_starts))

// NEW VERBS
/mob/living/carbon/human/proc/demand_submission()
	set name = "Demand Submission"
	set category = "VAMPIRE"
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.kingsubmit)
			to_chat(src, "Я уже Владыка Энигмы.")
			return
	for(var/mob/living/carbon/human/H in oview(1))
		if(SSticker.rulermob == H)
			H.receive_submission(src)

/mob/living/carbon/human/proc/receive_submission(var/mob/living/carbon/human/lord)
	if(stat)
		return
	switch(alert("Подчиниться и присягнуть на верность лорду [lord.name]?",,"Yes","No"))
		if("Yes")
			var/datum/game_mode/chaosmode/C = SSticker.mode
			if(istype(C))
				if(!C.kingsubmit)
					C.kingsubmit = TRUE
		if("No")
			lord << "<span class='boldnotice'>Отказ!</span>"
			src << "<span class='boldnotice'>Я отказываюсь!</span>"

/mob/living/carbon/human/proc/vampire_telepathy()
	set name = "Telepathy"
	set category = "VAMPIRE"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/msg = input("Отправить сообщение.", "Приказ") as text|null
	if(!msg)
		return
	for(var/datum/mind/V in C.vampires)
		to_chat(V, "<span class='boldnotice'>Послание от [src.real_name]: [msg]</span>")
	for(var/datum/mind/D in C.deathknights)
		to_chat(D, "<span class='boldnotice'>Послание от [src.real_name]: [msg]</span>")
	for(var/mob/dead/observer/rogue/arcaneeye/A in world)
		to_chat(A, "<span class='boldnotice'>Послание от [src.real_name]: [msg]</span>")

/mob/living/carbon/human/proc/punish_spawn()
	set name = "Punish Minion"
	set category = "VAMPIRE"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/mob/living/carbon/human/possible = list()
	for(var/datum/mind/V in C.vampires)
		if(V.special_role == "Vampire Spawn")
			possible |= V.current
	for(var/datum/mind/D in C.deathknights)
		possible |= D.current
	var/mob/living/carbon/human/choice = input(src, "Кого наказать?", "НАКАЗАНИЕ") as anything in possible|null
	if(choice)
		var/punishmentlevels = list("Pause", "Pain", "Release")
		switch(input(src, "Тяжесть наказания?", "НАКАЗАНИЕ") as anything in punishmentlevels|null)
			if("Pain")
				to_chat(choice, "<span class='boldnotice'>Тебя пронзает невыносимая боль — твой господин карает тебя!</span>")
				choice.apply_damage(30, BRUTE)
				choice.emote_scream()
				playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
			if("Pause")
				to_chat(choice, "<span class='boldnotice'>Твоё тело сковывает паралич — твой господин карает тебя!</span>")
				choice.Paralyze(300)
				choice.emote_scream()
				playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
			if("Release")
				to_chat(choice, "<span class='boldnotice'>Кругом лишь тьма. Господин больше не нуждается в тебе.</span>")
				spawn(10 SECONDS)
					choice.emote_scream()
					choice.dust()
		visible_message("<span class='danger'>[src] простирает руку, сжимая душу [choice] и карая её!</span>")

/obj/structure/vampire/portal/Crossed(atom/movable/AM)
	. = ..()
	if(istype(AM, /mob/living))
		for(var/obj/effect/landmark/vteleport/dest in world)
			playsound(loc, 'sound/misc/portalenter.ogg', 100, FALSE, pressure_affected = FALSE)
			AM.forceMove(dest.loc)
			break

/obj/structure/vampire/portal/sending/Crossed(atom/movable/AM)
	if(istype(AM, /mob/living))
		for(var/obj/effect/landmark/vteleportsenddest/V in world)
			AM.forceMove(V.loc)

/obj/structure/vampire/portal/sending/Destroy()
	for(var/obj/effect/landmark/vteleportsenddest/V in world)
		qdel(V)
	for(var/obj/structure/vampire/portalmaker/P in world)
		P.sending =  FALSE
	..()

/obj/structure/vampire/portalmaker/proc/create_portal_return(aname,duration)
	for(var/obj/effect/landmark/vteleportdestination/Vamp in world)
		if(Vamp.amuletname == aname)
			var/obj/structure/vampire/portal/P = new(Vamp.loc)
			P.duration = duration
			P.spawntime = world.time
			P.visible_message("<span class='boldnotice'>Раздаётся зловещий треск — открывается мрачный портал.</span>")
		qdel(Vamp)

/obj/structure/vampire/portalmaker/proc/create_portal(choice,duration)
	sending = TRUE
	for(var/obj/effect/landmark/vteleportsending/S in world)
		var/obj/structure/vampire/portal/sending/P = new(S.loc)
		P.visible_message("<span class='boldnotice'>Раздаётся зловещий треск — открывается мрачный портал.</span>")

/obj/structure/vampire/portal/Initialize()
	. = ..()
	set_light(3, 20, LIGHT_COLOR_BLOOD_MAGIC)
	playsound(loc, 'sound/misc/portalopen.ogg', 100, FALSE, pressure_affected = FALSE)
	sleep(600)
	visible_message("<span class='boldnotice'>[src] содрогается и быстро закрывается.</span>")
	qdel(src)

/obj/structure/vampire/portal/sending/Destroy()
	for(var/obj/structure/vampire/portalmaker/PM in world)
		PM.sending = FALSE
	. = ..()

/obj/structure/vampire/bloodpool/Initialize()
	. = ..()
	set_light(3, 20, LIGHT_COLOR_BLOOD_MAGIC)

/obj/structure/vampire/bloodpool/examine(mob/user)
	. = ..()
	to_chat(user, "<span class='boldnotice'>Уровень крови: [current]</span>")

/obj/structure/vampire/bloodpool/attack_hand(mob/living/user)
	var/datum/antagonist/vampirelord/lord = user.mind.has_antag_datum(/datum/antagonist/vampirelord)
	if(user.mind.special_role != "Vampire Lord")
		return
	var/choice = input(user,"Что делать?", "РОУГТАУН") as anything in useoptions|null
	switch(choice)
		if("Grow Power")
			if(lord.vamplevel == 4)
				to_chat(user, "Я уже достиг высшего уровня!")
				return
			if(alert(user, "Повысить уровень вампира? Цена: [nextlevel]","","Yes","No") == "Yes")
				if(!check_withdraw(-nextlevel))
					to_chat(user, "Мне не хватает витэ!")
					return
				if(do_after(user, 100))
					lord.handle_vitae(-nextlevel)
					lord.grow_in_power()
					user.playsound_local(get_turf(src), 'sound/misc/batsound.ogg', 100, FALSE, pressure_affected = FALSE)
		if("Shape Amulet")
			if(alert(user, "Создать новый амулет? Цена: 500","","Yes","No") == "Yes")
				if(!check_withdraw(-500))
					to_chat(user, "Мне не хватает витэ!")
					return
				if(do_after(user, 100))
					lord.handle_vitae(-500)
					var/naming = input(user, "Выбери название для амулета.", "РОУГТАУН") as text|null
					var/obj/item/clothing/neck/roguetown/portalamulet/P = new(src.loc)
					if(naming)
						P.name = naming
					user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
		if("Shape Armor")
			if(alert(user, "Создать комплект доспехов? Цена: 1500","","Yes","No") == "Yes")
				if(!check_withdraw(-1500))
					to_chat(user, "Мне не хватает витэ!")
					return
				if(do_after(user, 100))
					lord.handle_vitae(-1500)
					var/list/armorpieces = list(/obj/item/clothing/under/roguetown/platelegs/vampire, /obj/item/clothing/suit/roguetown/armor/chainmail/iron/vampire, /obj/item/clothing/suit/roguetown/armor/chainmail/iron/vampire, /obj/item/clothing/shoes/roguetown/boots/armor/vampire, /obj/item/clothing/head/roguetown/helmet/heavy/guard)
					for(var/obj/item/A in armorpieces)
						new A(src.loc)
				user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)

/obj/structure/vampire/bloodpool/proc/update_pool(change)
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/tempmax = 8000
	if(istype(C))
		for(var/datum/mind/V in C.vampires)
			if(V.special_role == "vampirespawn")
				tempmax += 4000
		if(maximum != tempmax)
			maximum = tempmax
			if(current > maximum)
				current = maximum
	if(debug)
		maximum = 999999
		current = 999999
	if(change)
		current += change

/obj/structure/vampire/bloodpool/proc/check_withdraw(change)
	if(change < 0)
		if(abs(change) > current)
			return FALSE
		return TRUE

/obj/structure/vampire/portalmaker/attack_hand(mob/living/user)
	var/list/possibleportals = list()
	var/list/sendpossibleportals = list()
	var/datum/antagonist/vampirelord/lord = user.mind.has_antag_datum(/datum/antagonist/vampirelord)
	if(user.mind.special_role != "Vampire Lord")
		return
	if(!lord.mypool.check_withdraw(-1000))
		to_chat(user, "Это стоит 1000 витэ, у меня столько нет.")
		return
	if(!unlocked)
		to_chat(user, "Я ещё не восстановил эту грань своей силы!")
		return
	var/list/choices = list("Return", "Sending", "CANCEL")
	var/inputportal = input(user, "Какой тип портала?", "Тип портала") as anything in choices
	switch(inputportal)
		if("Return")
			for(var/obj/item/clothing/neck/roguetown/portalamulet/P in world)
				possibleportals += P
			var/atom/choice = input(user, "Выбери место для открытия портала", "Выбор") as null|anything in possibleportals
			if(!choice)
				return
			user.visible_message("[user] начинает призывать портал.", "Я начинаю призывать портал.")
			if(do_after(user, 30))
				lord.handle_vitae(-1000)
				if(istype(choice, /obj/item/clothing/neck/roguetown/portalamulet))
					var/obj/item/clothing/neck/roguetown/portalamulet/A = choice
					A.uses -= 1
					var/obj/effect/landmark/vteleportdestination/VR = new(A.loc)
					VR.amuletname = A.name
					create_portal_return(A.name, 3000)
					user.playsound_local(get_turf(src), 'sound/misc/portalactivate.ogg', 100, FALSE, pressure_affected = FALSE)
					if(A.uses <= 0)
						A.visible_message("[A] разбивается вдребезги!")
						qdel(A)
		if("Sending")
			if(sending)
				to_chat(user, "Один портал уже открыт!")
				return
			for(var/obj/item/clothing/neck/roguetown/portalamulet/P in world)
				sendpossibleportals += P
			var/atom/choice = input(user, "Выбери место, куда открыть портал", "Выбор") as null|anything in sendpossibleportals
			if(!choice)
				return
			user.visible_message("[user] начинает призывать портал.", "Я начинаю призывать портал.")
			if(do_after(user, 30))
				lord.handle_vitae(-1000)
				if(istype(choice, /obj/item/clothing/neck/roguetown/portalamulet))
					var/obj/item/clothing/neck/roguetown/portalamulet/A = choice
					A.uses -= 1
					var/turf/G = get_turf(A)
					new /obj/effect/landmark/vteleportsenddest(G.loc)
					if(A.uses <= 0)
						A.visible_message("[A] разбивается вдребезги!")
						qdel(A)
					create_portal()
					user.playsound_local(get_turf(src), 'sound/misc/portalactivate.ogg', 100, FALSE, pressure_affected = FALSE)
		if("CANCEL")
			return
/* DISABLED FOR NOW
/obj/item/clothing/neck/roguetown/portalamulet/attack_self(mob/user)
	. = ..()
	if(alert(user, "Create a portal?", "PORTAL GEM", "Yes", "No") == "Yes")
		uses -= 1
		var/obj/effect/landmark/vteleportdestination/Vamp = new(loc)
		Vamp.amuletname = name
		for(var/obj/structure/vampire/portalmaker/P in world)
			P.create_portal_return(name, 3000)
		user.playsound_local(get_turf(src), 'sound/misc/portalactivate.ogg', 100, FALSE, pressure_affected = FALSE)
		if(uses <= 0)
			visible_message("[src] shatters!")
			qdel(src)
*/
/obj/structure/vampire/scryingorb/attack_hand(mob/living/carbon/human/user)
	if(user.mind.special_role == "Vampire Lord")
		user.visible_message("<font color='red'>Глаза [user] наливаются тёмно-красным, когда [user] направляет силу [src]</font>", "<font color='red'>Я направляю своё сознание в Око Хищника.</font>")
		if(do_after(user, 60))
			user.scry(can_reenter_corpse = 1, force_respawn = FALSE)
	if(user.mind.special_role == "Vampire Spawn")
		to_chat(user, "У меня нет сил использовать это!")

/obj/structure/vampire/necromanticbook/attack_hand(mob/living/carbon/human/user)
	var/datum/antagonist/vampirelord/lord = user.mind.has_antag_datum(/datum/antagonist/vampirelord)
	if(user.mind.special_role == "Vampire Lord")
		if(!unlocked)
			to_chat(user, "Я ещё не восстановил эту грань своей силы!")
			return
		var/choice = input(user,"Что делать?", "РОУГТАУН") as anything in useoptions|null
		switch(choice)
			if("Create Death Knight")
				if(alert(user, "Создать Рыцаря смерти? Цена: 5000","","Yes","No") == "Yes")
					if(!lord.mypool.check_withdraw(-5000))
						to_chat(user, "Мне не хватает витэ!")
						return
					if(do_after(user, 100))
						to_chat(user, "Я призвал рыцаря из подземного мира. Осталось лишь дождаться его воплощения.")
						var/datum/game_mode/chaosmode/C = SSticker.mode
						C.deathknightspawn = TRUE
						for(var/mob/dead/observer/D in GLOB.player_list)
							D.death_knight_spawn()
						for(var/mob/living/carbon/spirit/D in GLOB.player_list)
							D.death_knight_spawn()
				user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
			if("Steal the Sun")
				if(sunstolen)
					to_chat(user, "Солнце уже украдено!")
					return
				if(GLOB.tod == "night")
					to_chat(user, "Уже ночь!")
					return
				if(alert(user, "Погрузить Энигму в вечную ночь? Цена: 5000","","Yes","No") == "Yes")
					if(!lord.mypool.check_withdraw(-2500))
						to_chat(user, "Мне не хватает витэ!")
						return
					if(do_after(user, 100))
						GLOB.todoverride = "night"
						sunstolen = TRUE
						settod()
						spawn(6000)
							GLOB.todoverride = null
							sunstolen = FALSE
						priority_announce("Солнце сорвано с небес!", "Зловещее знамение", 'sound/misc/astratascream.ogg')
						addomen("sunsteal")
						for(var/mob/living/carbon/human/W in world)
							var/datum/patrongods/patron = W.client.prefs.selected_patron
							if(patron.name == "Astrata")
								if(!W.mind?.antag_datums)
									to_chat(W, "<span class='userdanger'>Ты чувствуешь боль своего Покровителя!</span>")
									W.emote_scream()

	if(user.mind.special_role == "Vampire Spawn")
		to_chat(user, "У меня нет сил использовать это!")

/mob/proc/death_knight_spawn()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	SEND_SOUND(src, sound('sound/misc/notice (2).ogg'))
	if(alert(src, "Вампирский лорд призывает тебя из Подземного мира.", "Восстать?", "Yes", "No") == "Yes")
		if(!C.deathknightspawn)
			to_chat(src, "<span class='warning'>Была избрана другая душа.</span>")
		returntolobby()

// DEATH KNIGHT ANTAG
/datum/antagonist/skeleton/knight
	name = "Death Knight"
	increase_votepwr = FALSE

/datum/antagonist/skeleton/knight/on_gain()
	. = ..()
	owner.current.verbs |= /mob/living/carbon/human/proc/vampire_telepathy
	add_objective(/datum/objective/vlordserve)
	greet()

/datum/antagonist/skeleton/knight/greet()
	to_chat(owner.current, "<span class='userdanger'>Я вернулся, чтобы служить. Я буду повиноваться, дабы вновь обрести покой.</span>")
	owner.announce_objectives()
	..()

/datum/antagonist/skeleton/knight/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/skeleton/knight/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/skeleton/knight/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(objective.check_completion())
				to_chat(owner, "<B>Цель #[count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
			else
				to_chat(owner, "<B>Цель #[count]</B>: [objective.explanation_text] <span class='redtext'>Провал.</span>")
				traitorwin = FALSE
			count += objective.triumph_count
	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, "<span class='greentext'>[capitalize(special_role_text)] одерживает ТРИУМФ!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, "<span class='redtext'>[capitalize(special_role_text)] терпит КРАХ!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
// OBJECTIVES STORED HERE TEMPORARILY FOR EASE OF REFERENCE

/datum/objective/vampirelord/conquer
	name = "conquer"
	explanation_text = "Заставить правителя Энигмы склониться перед моей волей."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/conquer/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.kingsubmit)
			return TRUE

/datum/objective/vampirelord/ascend
	name = "sun"
	explanation_text = "Астрата слишком долго отвергала меня. Я должен подчинить Солнце."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/ascend/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.ascended)
		return TRUE

/datum/objective/vampirelord/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Обратить служителя Церкви в своё отродье."
	triumph_count = 5

/datum/objective/vampirelord/infiltrate/one/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/churchjobs = list("Priest", "Priestess", "Cleric", "Acolyte", "Churchling", "Crusader")
	for(var/datum/mind/V in C.vampires)
		if(V.current.job in churchjobs)
			return TRUE

/datum/objective/vampirelord/infiltrate/two
	name = "infiltrate2"
	explanation_text = "Обратить дворянина в своё отродье."
	triumph_count = 5

/datum/objective/vampirelord/infiltrate/two/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/noblejobs = list("King", "Queen", "Prince", "Princess", "Hand", "Steward")
	for(var/datum/mind/V in C.vampires)
		if(V.current.job in noblejobs)
			return TRUE

/datum/objective/vampirelord/spread
	name = "spread"
	explanation_text = "Создать не менее 10 вампирских отродий."
	triumph_count = 5

/datum/objective/vampirelord/spread/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.vampires.len >= 10)
		return TRUE

/datum/objective/vampirelord/stock
	name = "stock"
	explanation_text = "Наполнить багровый горнил до 30000 витэ."
	triumph_count = 1

/datum/objective/vlordsurvive
	name = "survive"
	explanation_text = "Я вечен. Глупые смертные не должны уничтожить меня."
	triumph_count = 3

/datum/objective/vlordsurvive/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE

/datum/objective/vlordserve
	name = "serve"
	explanation_text = "Я должен служить господину и привести его к триумфу."
	triumph_count = 3

/datum/objective/vlordserve/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE

/datum/antagonist/vampirelord/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(isspawn) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Цель #[count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
				else
					to_chat(owner, "<B>Цель #[count]</B>: [objective.explanation_text] <span class='redtext'>Провал.</span>")
					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(world, "<B>Цель #[count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
				else
					to_chat(world, "<B>Цель #[count]</B>: [objective.explanation_text] <span class='redtext'>Провал.</span>")
					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, "<span class='greentext'>[capitalize(special_role_text)] одерживает ТРИУМФ!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, "<span class='redtext'>[capitalize(special_role_text)] терпит КРАХ!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

// NEW OBJECTS/STRUCTURES
/obj/item/clothing/neck/roguetown/portalamulet
	name = "амулет врат"
	icon_state = "bloodtooth"
	icon = 'icons/roguetown/clothing/neck.dmi'
	var/uses = 3

/obj/structure/vampire
	icon = 'icons/roguetown/topadd/death/vamp-lord.dmi'
	var/unlocked = FALSE
	density = TRUE

/obj/structure/vampire/bloodpool
	name = "Багровый горнил"
	icon_state = "vat"
	var/maximum = 8000
	var/current = 8000
	var/nextlevel = VAMP_LEVEL_ONE
	var/debug = FALSE
	var/list/useoptions = list("Grow Power", "Shape Amulet", "Shape Armor")

/obj/structure/vampire/scryingorb // Method of spying on the town
	name = "Око ночи"
	icon_state = "scrying"


/obj/structure/vampire/necromanticbook // Used to summon undead to attack town/defend manor.
    name = "Гримуар душ"
    icon_state = "tome"
    var/list/useoptions = list("Create Death Knight", "Steal the Sun")
    var/sunstolen = FALSE

/obj/structure/vampire/portalmaker
    name = "Врата разлома"
    icon_state = "obelisk"
    var/sending = FALSE

/obj/structure/vampire/portal
    name = "Зловещий портал"
    icon_state = "portal"
    var/duration = 999
    var/spawntime = null
    density = 0

/obj/structure/vampire/portal/sending
    name = "Зловещий портал"
    icon_state = "portal"
    var/turf/destloc

// LANDMARKS


/obj/effect/landmark/start/vampirelord
	name = "Vampire Lord"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampirelord/Initialize()
	..()
	GLOB.vlord_starts += loc

/obj/effect/landmark/start/vampirespawn
	name = "Vampire Spawn"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampireknight
	name = "Death Knight"
	icon_state = "arrow"
	jobspawn_override = list("Death Knight")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampirespawn/Initialize()
	..()
	GLOB.vspawn_starts += loc

/obj/effect/landmark/vteleport
	name = "Teleport Destination"
	icon_state = "x2"

/obj/effect/landmark/vteleportsending
	name = "Teleport Sending"
	icon_state = "x2"

/obj/effect/landmark/vteleportdestination
	name = "Return Destination"
	icon_state = "x2"
	var/amuletname

/obj/effect/landmark/vteleportsenddest
	name = "Sending Destination"
	icon_state = "x2"
// SCRYING Since it has so many unique procs
/mob/dead/observer/rogue/arcaneeye
    sight = 0
    see_in_dark = 2
    var/mob/living/carbon/human/vampirelord = null
    icon_state = "arcaneeye"
    hud_type = /datum/hud/eye

/mob/proc/scry(can_reenter_corpse = 1, force_respawn = FALSE, drawskip)
	stop_sound_channel(CHANNEL_HEARTBEAT) //Stop heartbeat sounds because You Are A Ghost Now
	SSdroning.kill_rain(client)
	SSdroning.kill_loop(client)
	SSdroning.kill_droning(client)
	stop_sound_channel(CHANNEL_HEARTBEAT) //Stop heartbeat sounds because You Are A Ghost Now
	var/mob/dead/observer/rogue/arcaneeye/eye = new(src)	// Transfer safety to observer spawning proc.
	SStgui.on_transfer(src, eye) // Transfer NanoUIs.
	eye.can_reenter_corpse = can_reenter_corpse
	eye.vampirelord = src
	eye.ghostize_time = world.time
	eye.key = key
	return eye

/mob/dead/observer/rogue/arcaneeye/proc/scry_tele()
	set category = "Arcane Eye"
	set name = "Teleport"
	set desc= "Teleport to a location"
	set hidden = 0

	if(!isobserver(usr))
		to_chat(usr, "<span class='warning'>Ты не Око!</span>")
		return
	var/list/filtered = list()
	for(var/V in GLOB.sortedAreas)
		var/area/A = V
		if(!A.hidden)
			filtered += A
	var/area/thearea  = input("Область для перемещения", "РОУГТАУН") as null|anything in filtered

	if(!thearea)
		return

	var/list/L = list()
	for(var/turf/T in get_area_turfs(thearea.type))
		L+=T

	if(!L || !L.len)
		to_chat(usr, "<span class='warning'>Нет доступных областей.</span>")
		return

	usr.forceMove(pick(L))
	update_parallax_contents()

/mob/dead/observer/rogue/arcaneeye/Initialize()
	. = ..()
	set_invisibility(GLOB.observer_default_invisibility)
	verbs += list(
		/mob/dead/observer/rogue/arcaneeye/proc/scry_tele,
		/mob/dead/observer/rogue/arcaneeye/proc/cancel_scry,
		/mob/dead/observer/rogue/arcaneeye/proc/eye_down,
		/mob/dead/observer/rogue/arcaneeye/proc/eye_up,
		/mob/dead/observer/rogue/arcaneeye/proc/vampire_telepathy)
	testing("BEGIN LOC [loc]")
	name = "Тайное око"
	grant_all_languages()

/mob/dead/observer/rogue/arcaneeye/proc/cancel_scry()
	set category = "Arcane Eye"
	set name = "Cancel Eye"
	set desc= "Return to Body"

	if(vampirelord)
		vampirelord.ckey = ckey
		qdel(src)
	else
		to_chat(src, "Моё тело уничтожено! Я в ловушке!")

/mob/dead/observer/rogue/arcaneeye/Crossed(mob/living/L)
	if(istype(L, /mob/living/carbon/human))
		var/mob/living/carbon/human/V = L
		var/holyskill = V.mind.get_skill_level(/datum/skill/magic/holy)
		var/magicskill = V.mind.get_skill_level(/datum/skill/magic/arcane)
		if(magicskill >= 2)
			to_chat(V, "<font color='red'>Древняя и необычная магия витает в воздухе вокруг тебя.</font>")
			return
		if(holyskill >= 2)
			to_chat(V, "<font color='red'>Древняя и нечестивая магия витает в воздухе вокруг тебя.</font>")
			return
		if(prob(20))
			to_chat(V, "<font color='red'>Ты чувствуешь, будто кто-то или что-то наблюдает за тобой.</font>")
			return

/mob/dead/observer/rogue/arcaneeye/proc/vampire_telepathy()
	set name = "Telepathy"
	set category = "Arcane Eye"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/msg = input("Отправить сообщение.", "Приказ") as text|null
	if(!msg)
		return
	for(var/datum/mind/V in C.vampires)
		to_chat(V, "<span class='boldnotice'>Послание от [src.real_name]: [msg]</span>")
	for(var/datum/mind/D in C.deathknights)
		to_chat(D, "<span class='boldnotice'>Послание от [src.real_name]: [msg]</span>")
	for(var/mob/dead/observer/rogue/arcaneeye/A in world)
		to_chat(A, "<span class='boldnotice'>Послание от [src.real_name]: [msg]</span>")

/mob/dead/observer/rogue/arcaneeye/proc/eye_up()
	set category = "Arcane Eye"
	set name = "Move Up"

	if(zMove(UP, TRUE))
		to_chat(src, "<span class='notice'>Я поднимаюсь выше.</span>")

/mob/dead/observer/rogue/arcaneeye/proc/eye_down()
	set category = "Arcane Eye"
	set name = "Move Down"

	if(zMove(DOWN, TRUE))
		to_chat(src, "<span class='notice'>Я опускаюсь ниже.</span>")

/mob/dead/observer/rogue/arcaneeye/Move(NewLoc, direct)
	if(world.time < next_gmove)
		return
	next_gmove = world.time + 3

	if(updatedir)
		setDir(direct)//only update dir if we actually need it, so overlays won't spin on base sprites that don't have directions of their own
	var/oldloc = loc

	if(NewLoc)
		var/NewLocTurf = get_turf(NewLoc)
		if(istype(NewLocTurf, /turf/closed/mineral/rogue/bedrock)) // prevent going out of bounds.
			return
		forceMove(NewLoc)
		update_parallax_contents()
	else
		forceMove(get_turf(src))  //Get out of closets and such as a ghost
		if((direct & NORTH) && y < world.maxy)
			y++
		else if((direct & SOUTH) && y > 1)
			y--
		if((direct & EAST) && x < world.maxx)
			x++
		else if((direct & WEST) && x > 1)
			x--

	Moved(oldloc, direct)

// Spells
/obj/effect/proc_holder/spell/targeted/transfix
	name = "Transfix"
	overlay_state = "transfix"
	releasedrain = 100
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	include_user = 0
	max_targets = 1

/obj/effect/proc_holder/spell/targeted/transfix/cast(list/targets, mob/user = usr)
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d8")
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/vampirelord/VD = L.mind.has_antag_datum(/datum/antagonist/vampirelord)
		var/willpower = round(L.STAINT / 3)
		var/willroll = roll("[willpower]d6")
		if(VD)
			return
		if(L.cmode)
			willroll += 10
		if(bloodroll >= willroll)
			to_chat(L, "Твой разум застилает пелена.")
			to_chat(user, "Разум жертвы поддаётся, скоро она уснёт.")
			sleep(50)
			L.Sleeping(300)
		if(willroll >= bloodroll)
			to_chat(user, "Мне не удалось пленить этот разум.")
			if(willroll - bloodroll >= 3)
				to_chat(L, "Кажется, кто-то лезет мне в голову.")
				var/holyskill = user.mind.get_skill_level(/datum/skill/magic/holy)
				var/arcaneskill = user.mind.get_skill_level(/datum/skill/magic/arcane)
				if(holyskill + arcaneskill >= 3)
					to_chat(L, "Кажется, магия исходила от [user]")

/obj/effect/proc_holder/spell/targeted/transfix/master
	name = "Subjugate"
	overlay_state = "transfixmaster"
	releasedrain = 200
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	include_user = 0
	max_targets = 0

/obj/effect/proc_holder/spell/targeted/transfix/master/cast(list/targets, mob/user = usr)
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d10")
	user.visible_message("<font color='red'>Глаза [user] вспыхивают зловещим алым пламенем, подчиняя чужую волю!</font>")
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/vampirelord/VD = L.mind.has_antag_datum(/datum/antagonist/vampirelord)
		var/willpower = round(L.STAINT / 3)
		var/willroll = roll("[willpower]d6")
		if(VD)
			return
		if(L.cmode)
			willroll += 15
		if(bloodroll >= willroll)
			to_chat(L, "<font color='purple'>Твой разум застилает пелена.</font>")
			sleep(50)
			L.Sleeping(300)

