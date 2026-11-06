/datum/action/innate/cult/blood_magic //Blood magic handles the creation of blood spells (formerly talismans)
	name = "Prepare Blood Magic"
	button_icon_state = "carve"
	desc = ""
	var/list/spells = list()
	var/channeling = FALSE

/datum/action/innate/cult/blood_magic/Grant()
	..()
	button.screen_loc = DEFAULT_BLOODSPELLS
	button.moved = DEFAULT_BLOODSPELLS
	button.ordered = FALSE

/datum/action/innate/cult/blood_magic/Remove()
	for(var/X in spells)
		qdel(X)
	..()

/datum/action/innate/cult/blood_magic/IsAvailable()
	if(!iscultist(owner))
		return FALSE
	return ..()

/datum/action/innate/cult/blood_magic/proc/Positioning()
	var/list/screen_loc_split = splittext(button.screen_loc,",")
	var/list/screen_loc_X = splittext(screen_loc_split[1],":")
	var/list/screen_loc_Y = splittext(screen_loc_split[2],":")
	var/pix_X = text2num(screen_loc_X[2])
	for(var/datum/action/innate/cult/blood_spell/B in spells)
		if(B.button.locked)
			var/order = pix_X+spells.Find(B)*31
			B.button.screen_loc = "[screen_loc_X[1]]:[order],[screen_loc_Y[1]]:[screen_loc_Y[2]]"
			B.button.moved = B.button.screen_loc

/datum/action/innate/cult/blood_magic/Activate()
	var/rune = FALSE
	var/limit = RUNELESS_MAX_BLOODCHARGE
	for(var/obj/effect/rune/empower/R in range(1, owner))
		rune = TRUE
		break
	if(rune)
		limit = MAX_BLOODCHARGE
	if(spells.len >= limit)
		if(rune)
			to_chat(owner, "<span class='cultitalic'>Ты не можешь хранить больше [MAX_BLOODCHARGE] заклинаний. <b>Выбери заклинание для удаления.</b></span>")
		else
			to_chat(owner, "<span class='cultitalic'><b><u>Ты не можешь хранить больше [RUNELESS_MAX_BLOODCHARGE] заклинаний без усиливающей руны! Выбери заклинание для удаления.</b></u></span>")
		var/nullify_spell = input(owner, "Выбери заклинание для удаления.", "Текущие заклинания") as null|anything in spells
		if(nullify_spell)
			qdel(nullify_spell)
		return
	var/entered_spell_name
	var/datum/action/innate/cult/blood_spell/BS
	var/list/possible_spells = list()
	for(var/I in subtypesof(/datum/action/innate/cult/blood_spell))
		var/datum/action/innate/cult/blood_spell/J = I
		var/cult_name = initial(J.name)
		possible_spells[cult_name] = J
	possible_spells += "(REMOVE SPELL)"
	entered_spell_name = input(owner, "Выбери заклинание крови для подготовки...", "Выбор заклинаний") as null|anything in possible_spells
	if(entered_spell_name == "(REMOVE SPELL)")
		var/nullify_spell = input(owner, "Выбери заклинание для удаления.", "Текущие заклинания") as null|anything in spells
		if(nullify_spell)
			qdel(nullify_spell)
		return
	BS = possible_spells[entered_spell_name]
	if(QDELETED(src) || owner.incapacitated() || !BS || (rune && !(locate(/obj/effect/rune/empower) in range(1, owner))) || (spells.len >= limit))
		return
	to_chat(owner,"<span class='warning'>Ты начинаешь вырезать жуткие символы на своей плоти!</span>")
	SEND_SOUND(owner, sound('sound/blank.ogg',0,1,10))
	if(!channeling)
		channeling = TRUE
	else
		to_chat(owner, "<span class='cultitalic'>Ты уже творишь магию крови!</span>")
		return
	if(do_after(owner, 100 - rune*60, target = owner))
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			H.bleed(40 - rune*32)
		var/datum/action/innate/cult/blood_spell/new_spell = new BS(owner)
		new_spell.Grant(owner, src)
		spells += new_spell
		Positioning()
		to_chat(owner, "<span class='warning'>Твои раны светятся силой, ты подготовил заклинание [new_spell.name]!</span>")
	channeling = FALSE

/datum/action/innate/cult/blood_spell //The next generation of talismans, handles storage/creation of blood magic
	name = "Blood Magic"
	button_icon_state = "telerune"
	desc = ""
	var/charges = 1
	var/magic_path = null
	var/obj/item/melee/blood_magic/hand_magic
	var/datum/action/innate/cult/blood_magic/all_magic
	var/base_desc //To allow for updating tooltips
	var/invocation
	var/health_cost = 0

/datum/action/innate/cult/blood_spell/Grant(mob/living/owner, datum/action/innate/cult/blood_magic/BM)
	if(health_cost)
		desc += "<br>Наносит <u>[health_cost] урона</u> руке за использование."
	base_desc = desc
	desc += "<br><b><u>Осталось использований: [charges]</u></b>."
	all_magic = BM
	..()
	button.locked = TRUE
	button.ordered = FALSE

/datum/action/innate/cult/blood_spell/Remove()
	if(all_magic)
		all_magic.spells -= src
	if(hand_magic)
		qdel(hand_magic)
		hand_magic = null
	..()

/datum/action/innate/cult/blood_spell/IsAvailable()
	if(!iscultist(owner) || owner.incapacitated()  || !charges)
		return FALSE
	return ..()

/datum/action/innate/cult/blood_spell/Activate()
	if(magic_path) //If this spell flows from the hand
		if(!hand_magic)
			hand_magic = new magic_path(owner, src)
			if(!owner.put_in_hands(hand_magic))
				qdel(hand_magic)
				hand_magic = null
				to_chat(owner, "<span class='warning'>У тебя нет свободной руки для сотворения магии крови!</span>")
				return
			to_chat(owner, "<span class='notice'>Твои раны светятся, пока ты творишь [name].</span>")
			return
		if(hand_magic)
			qdel(hand_magic)
			hand_magic = null
			to_chat(owner, "<span class='warning'>Ты гасишь заклинание, сберегая его на потом.</span>")


//Cult Blood Spells
/datum/action/innate/cult/blood_spell/stun
	name = "Stun"
	desc = ""
	button_icon_state = "hand"
	magic_path = "/obj/item/melee/blood_magic/stun"
	health_cost = 10

/datum/action/innate/cult/blood_spell/teleport
	name = "Teleport"
	desc = ""
	button_icon_state = "tele"
	magic_path = "/obj/item/melee/blood_magic/teleport"
	health_cost = 7

/datum/action/innate/cult/blood_spell/emp
	name = "Electromagnetic Pulse"
	desc = ""
	button_icon_state = "emp"
	health_cost = 10
	invocation = "Ta'gh fara'qha fel d'amar det!"

/datum/action/innate/cult/blood_spell/emp/Activate()
	owner.visible_message("<span class='warning'>Рука [owner] вспыхивает ярко-синим светом!</span>", \
						 "<span class='cultitalic'>Ты произносишь проклятые слова, испуская импульс из руки.</span>")
	empulse(owner, 2, 5)
	owner.whisper(invocation, language = /datum/language/common)
	charges--
	if(charges<=0)
		qdel(src)

/datum/action/innate/cult/blood_spell/shackles
	name = "Shadow Shackles"
	desc = ""
	button_icon_state = "cuff"
	charges = 4
	magic_path = "/obj/item/melee/blood_magic/shackles"

/datum/action/innate/cult/blood_spell/construction
	name = "Twisted Construction"
	desc = ""
	button_icon_state = "transmute"
	magic_path = "/obj/item/melee/blood_magic/construction"
	health_cost = 12

/datum/action/innate/cult/blood_spell/equipment
	name = "Summon Equipment"
	desc = ""
	button_icon_state = "equip"
	magic_path = "/obj/item/melee/blood_magic/armor"

/datum/action/innate/cult/blood_spell/equipment/Activate()
	var/choice = alert(owner,"Выбери снаряжение",,"Combat Equipment","Ritual Dagger","Cancel")
	if(choice == "Ritual Dagger")
		var/turf/T = get_turf(owner)
		owner.visible_message("<span class='warning'>[owner]'s hand glows red for a moment.</span>", \
			"<span class='cultitalic'>Red light begins to shimmer and take form within my hand!</span>")
		var/obj/O = new /obj/item/melee/cultblade/dagger(T)
		if(owner.put_in_hands(O))
			to_chat(owner, "<span class='warning'>Ритуальный кинжал появляется в твоей руке!</span>")
		else
			owner.visible_message("<span class='warning'>Ритуальный кинжал появляется у ног [owner]!</span>", \
				 "<span class='cultitalic'>Ритуальный кинжал материализуется у твоих ног.</span>")
		SEND_SOUND(owner, sound('sound/blank.ogg',0,1,25))
		charges--
		desc = base_desc
		desc += "<br><b><u>Осталось использований: [charges]</u></b>."
		if(charges<=0)
			qdel(src)
	else if(choice == "Combat Equipment")
		..()

/datum/action/innate/cult/blood_spell/horror
	name = "Hallucinations"
	desc = ""
	button_icon_state = "horror"
	var/obj/effect/proc_holder/horror/PH
	charges = 4

/datum/action/innate/cult/blood_spell/horror/New()
	PH = new()
	PH.attached_action = src
	..()

/datum/action/innate/cult/blood_spell/horror/Destroy()
	var/obj/effect/proc_holder/horror/destroy = PH
	. = ..()
	if(destroy  && !QDELETED(destroy))
		QDEL_NULL(destroy)

/datum/action/innate/cult/blood_spell/horror/Activate()
	PH.toggle(owner) //the important bit
	return TRUE

/obj/effect/proc_holder/horror
	active = FALSE
	ranged_mousepointer = 'icons/effects/cult_target.dmi'
	var/datum/action/innate/cult/blood_spell/attached_action

/obj/effect/proc_holder/horror/Destroy()
	var/datum/action/innate/cult/blood_spell/AA = attached_action
	. = ..()
	if(AA && !QDELETED(AA))
		QDEL_NULL(AA)

/obj/effect/proc_holder/horror/proc/toggle(mob/user)
	if(active)
		remove_ranged_ability("<span class='cult'>Ты развеиваешь магию...</span>")
	else
		add_ranged_ability(user, "<span class='cult'>Ты готовишься внушить ужас цели...</span>")

/obj/effect/proc_holder/horror/InterceptClickOn(mob/living/caller, params, atom/target)
	if(..())
		return
	if(ranged_ability_user.incapacitated() || !iscultist(caller))
		remove_ranged_ability()
		return
	var/turf/T = get_turf(ranged_ability_user)
	if(!isturf(T))
		return FALSE
	if(target in view(7, get_turf(ranged_ability_user)))
		if(!ishuman(target) || iscultist(target))
			return
		var/mob/living/carbon/human/H = target
		H.hallucination = max(H.hallucination, 120)
		SEND_SOUND(ranged_ability_user, sound('sound/blank.ogg',0,1,50))
		var/image/C = image('icons/effects/cult_effects.dmi',H,"bloodsparkles", ABOVE_MOB_LAYER)
		add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/cult, "cult_apoc", C, NONE)
		addtimer(CALLBACK(H,/atom/.proc/remove_alt_appearance,"cult_apoc",TRUE), 2400, TIMER_OVERRIDE|TIMER_UNIQUE)
		to_chat(ranged_ability_user,"<span class='cult'><b>[H] проклят кошмарами наяву!</b></span>")
		attached_action.charges--
		attached_action.desc = attached_action.base_desc
		attached_action.desc += "<br><b><u>Has [attached_action.charges] use\s remaining</u></b>."
		attached_action.UpdateButtonIcon()
		if(attached_action.charges <= 0)
			remove_ranged_ability("<span class='cult'>Ты исчерпал силу заклинания!</span>")
			qdel(src)

/datum/action/innate/cult/blood_spell/veiling
	name = "Conceal Presence"
	desc = ""
	invocation = "Kla'atu barada nikt'o!"
	button_icon_state = "gone"
	charges = 10
	var/revealing = FALSE //if it reveals or not

/datum/action/innate/cult/blood_spell/veiling/Activate()
	if(!revealing)
		owner.visible_message("<span class='warning'>Серая пыль сыплется из руки [owner]!</span>", \
			"<span class='cultitalic'>Ты творишь покров, скрывая руны поблизости.</span>")
		charges--
		SEND_SOUND(owner, sound('sound/blank.ogg',0,1,25))
		owner.whisper(invocation, language = /datum/language/common)
		for(var/obj/effect/rune/R in range(5,owner))
			R.conceal()
		for(var/obj/structure/destructible/cult/S in range(5,owner))
			S.conceal()
		for(var/turf/open/floor/engine/cult/T  in range(5,owner))
			T.realappearance.alpha = 0
		for(var/obj/machinery/door/airlock/cult/AL in range(5, owner))
			AL.conceal()
		revealing = TRUE
		name = "Reveal Runes"
		button_icon_state = "back"
	else
		owner.visible_message("<span class='warning'>Вспышка света озаряет руку [owner]!</span>", \
			 "<span class='cultitalic'>Ты развеиваешь покров, обнажая руны поблизости.</span>")
		charges--
		owner.whisper(invocation, language = /datum/language/common)
		SEND_SOUND(owner, sound('sound/blank.ogg',0,1,25))
		for(var/obj/effect/rune/R in range(7,owner)) //More range in case you weren't standing in exactly the same spot
			R.reveal()
		for(var/obj/structure/destructible/cult/S in range(6,owner))
			S.reveal()
		for(var/turf/open/floor/engine/cult/T  in range(6,owner))
			T.realappearance.alpha = initial(T.realappearance.alpha)
		for(var/obj/machinery/door/airlock/cult/AL in range(6, owner))
			AL.reveal()
		revealing = FALSE
		name = "Conceal Runes"
		button_icon_state = "gone"
	if(charges<= 0)
		qdel(src)
	desc = base_desc
	desc += "<br><b><u>Осталось использований: [charges]</u></b>."
	UpdateButtonIcon()

/datum/action/innate/cult/blood_spell/manipulation
	name = "Blood Rites"
	desc = ""
	invocation = "Fel'th Dol Ab'orod!"
	button_icon_state = "manip"
	charges = 5
	magic_path = "/obj/item/melee/blood_magic/manipulator"


// The "magic hand" items
/obj/item/melee/blood_magic
	name = "\improper magical aura"
	desc = ""
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/misc/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/touchspell_righthand.dmi'
	icon_state = "disintegrate"
	item_state = "disintegrate"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL

	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	var/invocation
	var/uses = 1
	var/health_cost = 0 //The amount of health taken from the user when invoking the spell
	var/datum/action/innate/cult/blood_spell/source

/obj/item/melee/blood_magic/New(loc, spell)
	source = spell
	uses = source.charges
	health_cost = source.health_cost
	..()

/obj/item/melee/blood_magic/Destroy()
	if(!QDELETED(source))
		if(uses <= 0)
			source.hand_magic = null
			qdel(source)
			source = null
		else
			source.hand_magic = null
			source.charges = uses
			source.desc = source.base_desc
			source.desc += "<br><b><u>Has [uses] use\s remaining</u></b>."
			source.UpdateButtonIcon()
	..()

/obj/item/melee/blood_magic/attack_self(mob/living/user)
	afterattack(user, user, TRUE)

/obj/item/melee/blood_magic/attack(mob/living/M, mob/living/carbon/user)
	if(!iscarbon(user) || !iscultist(user))
		uses = 0
		qdel(src)
		return
	log_combat(user, M, "used a cult spell on", source.name, "")
	M.lastattacker = user.real_name
	M.lastattackerckey = user.ckey

/obj/item/melee/blood_magic/afterattack(atom/target, mob/living/carbon/user, proximity)
	. = ..()
	if(invocation)
		user.whisper(invocation, language = /datum/language/common)
	if(health_cost)
		if(user.active_hand_index == 1)
			user.apply_damage(health_cost, BRUTE, BODY_ZONE_L_ARM)
		else
			user.apply_damage(health_cost, BRUTE, BODY_ZONE_R_ARM)
	if(uses <= 0)
		qdel(src)
	else if(source)
		source.desc = source.base_desc
		source.desc += "<br><b><u>Has [uses] use\s remaining</u></b>."
		source.UpdateButtonIcon()

//Stun
/obj/item/melee/blood_magic/stun
	name = "Stunning Aura"
	desc = ""
	color = RUNE_COLOR_RED
	invocation = "Fuu ma'jin!"

/obj/item/melee/blood_magic/stun/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!isliving(target) || !proximity)
		return
	var/mob/living/L = target
	if(iscultist(target))
		return
	if(iscultist(user))
		user.visible_message("<span class='warning'>[user] поднимает руку, которая взрывается вспышкой красного света!</span>", \
							"<span class='cultitalic'>Ты пытаешься оглушить [L] заклинанием!</span>")

		user.mob_light(_color = LIGHT_COLOR_BLOOD_MAGIC, _range = 3, _duration = 2)

		var/anti_magic_source = L.anti_magic_check()
		if(anti_magic_source)

			L.mob_light(_color = LIGHT_COLOR_HOLY_MAGIC, _range = 2, _duration = 100)
			var/mutable_appearance/forbearance = mutable_appearance('icons/effects/genetics.dmi', "servitude", -MUTATIONS_LAYER)
			L.add_overlay(forbearance)
			addtimer(CALLBACK(L, /atom/proc/cut_overlay, forbearance), 100)

			if(istype(anti_magic_source, /obj/item))
				var/obj/item/ams_object = anti_magic_source
				target.visible_message("<span class='warning'>[L] озаряется ореолом света!</span>", \
									   "<span class='danger'>Твой [ams_object.name] начинает светиться, источая покров святого света, который защищает тебя от вспышки!</span>")
			else
				target.visible_message("<span class='warning'>[L] озаряется ореолом света!</span>", \
									   "<span class='danger'>Волна тепла накрывает тебя, лучи святого света окружают тело и защищают от вспышки!</span>")
		else
			to_chat(user, "<span class='cultitalic'>В яркой красной вспышке [L] падает на землю!</span>")
			L.Paralyze(160)
			L.flash_act(1,1)
			if(issilicon(target))
				var/mob/living/silicon/S = L
				S.emp_act(EMP_HEAVY)
			else if(iscarbon(target))
				var/mob/living/carbon/C = L
				C.silent += 6
				C.stuttering += 15
				C.cultslurring += 15
				C.Jitter(15)
		uses--
	..()

//Teleportation
/obj/item/melee/blood_magic/teleport
	name = "Teleporting Aura"
	color = RUNE_COLOR_TELEPORT
	desc = ""
	invocation = "Sas'so c'arta forbici!"

/obj/item/melee/blood_magic/teleport/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!iscultist(target) || !proximity)
		to_chat(user, "<span class='warning'>Этим заклинанием можно телепортировать только стоящих рядом культистов!</span>")
		return
	if(iscultist(user))
		var/list/potential_runes = list()
		var/list/teleportnames = list()
		for(var/R in GLOB.teleport_runes)
			var/obj/effect/rune/teleport/T = R
			potential_runes[avoid_assoc_duplicate_keys(T.listkey, teleportnames)] = T

		if(!potential_runes.len)
			to_chat(user, "<span class='warning'>Нет доступных рун для телепортации!</span>")
			log_game("Teleport talisman failed - no other teleport runes")
			return

		var/turf/T = get_turf(src)
		if(is_away_level(T.z))
			to_chat(user, "<span class='cultitalic'>Ты находишься не в том измерении!</span>")
			log_game("Teleport spell failed - user in away mission")
			return

		var/input_rune_key = input(user, "Выбери руну для телепортации.", "Руна телепортации") as null|anything in potential_runes //we know what key they picked
		var/obj/effect/rune/teleport/actual_selected_rune = potential_runes[input_rune_key] //what rune does that key correspond to?
		if(QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated() || !actual_selected_rune || !proximity)
			return
		var/turf/dest = get_turf(actual_selected_rune)
		if(is_blocked_turf(dest, TRUE))
			to_chat(user, "<span class='warning'>Целевая руна заблокирована. Телепортация невозможна.</span>")
			return
		uses--
		var/turf/origin = get_turf(user)
		var/mob/living/L = target
		if(do_teleport(L, dest, channel = TELEPORT_CHANNEL_CULT))
			origin.visible_message("<span class='warning'>Пыль струится из руки [user], и цель исчезает с резким треском!</span>", \
				"<span class='cultitalic'>Ты произносишь слова заклинания и оказываешься в другом месте!</span>", "<i>Слышен резкий треск.</i>")
			dest.visible_message("<span class='warning'>Раздаётся хлопок рассекаемого воздуха, и над руной кто-то появляется!</span>", null, "<i>Слышен хлопок.</i>")
		..()

//Shackles
/obj/item/melee/blood_magic/shackles
	name = "Shackling Aura"
	desc = ""
	invocation = "In'totum Lig'abis!"
	color = "#000000" // black

/obj/item/melee/blood_magic/shackles/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(iscultist(user) && iscarbon(target) && proximity)
		var/mob/living/carbon/C = target
		if(C.get_num_arms(FALSE) >= 2 || C.get_arm_ignore())
			CuffAttack(C, user)
		else
			user.visible_message("<span class='cultitalic'>У этой жертвы недостаточно рук для связывания!</span>")
			return
		..()

/obj/item/melee/blood_magic/shackles/proc/CuffAttack(mob/living/carbon/C, mob/living/user)
	if(!C.handcuffed)
		playsound(loc, 'sound/blank.ogg', 30, TRUE, -2)
		C.visible_message("<span class='danger'>[user] начинает связывать [C] тёмной магией!</span>", \
								"<span class='danger'>[user] формирует кандалы тёмной магии вокруг твоих запястий!</span>")
		if(do_mob(user, C, 30))
			if(!C.handcuffed)
				C.handcuffed = new /obj/item/restraints/handcuffs/energy/cult/used(C)
				C.update_handcuffed()
				C.silent += 5
				to_chat(user, "<span class='notice'>Ты заковываешь [C].</span>")
				log_combat(user, C, "shackled")
				uses--
			else
				to_chat(user, "<span class='warning'>[C] уже связан.</span>")
		else
			to_chat(user, "<span class='warning'>Не удалось заковать [C].</span>")
	else
		to_chat(user, "<span class='warning'>[C] уже связан.</span>")


/obj/item/restraints/handcuffs/energy/cult //For the shackling spell
	name = "shadow shackles"
	desc = ""
	trashtype = /obj/item/restraints/handcuffs/energy/used
	item_flags = DROPDEL

/obj/item/restraints/handcuffs/energy/cult/used/dropped(mob/user)
	user.visible_message("<span class='danger'>Кандалы на [user] разлетаются во вспышке тёмной магии!</span>", \
							"<span class='danger'>Твои [src] разлетаются во вспышке тёмной магии!</span>")
	. = ..()


//Construction: Converts 50 metal to a construct shell, plasteel to runed metal, airlock to brittle runed airlock, a borg to a construct, or borg shell to a construct shell
/obj/item/melee/blood_magic/construction
	name = "Twisting Aura"
	desc = ""
	invocation = "Ethra p'ni dedol!"
	color = "#000000" // black
	var/channeling = FALSE

/obj/item/melee/blood_magic/construction/examine(mob/user)
	. = ..()
	. += {"<u>A sinister spell used to convert:</u>\n
	Plasteel into runed metal\n
	[METAL_TO_CONSTRUCT_SHELL_CONVERSION] metal into a construct shell\n
	Living cyborgs into constructs after a delay\n
	Cyborg shells into construct shells\n
	Airlocks into brittle runed airlocks after a delay (harm intent)"}

/obj/item/melee/blood_magic/construction/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(proximity_flag && iscultist(user))
		if(channeling)
			to_chat(user, "<span class='cultitalic'>Ты уже творишь искажённое созидание!</span>")
			return
		var/turf/T = get_turf(target)
		if(istype(target, /obj/item/stack/sheet/metal))
			var/obj/item/stack/sheet/candidate = target
			if(candidate.use(METAL_TO_CONSTRUCT_SHELL_CONVERSION))
				uses--
				to_chat(user, "<span class='warning'>Тёмное облако исходит из твоей руки и обвивает металл, превращая его в оболочку конструкта!</span>")
				new /obj/structure/constructshell(T)
				SEND_SOUND(user, sound('sound/blank.ogg',0,1,25))
			else
				to_chat(user, "<span class='warning'>Нужно [METAL_TO_CONSTRUCT_SHELL_CONVERSION] металла для создания оболочки конструкта!</span>")
				return
		else if(istype(target, /obj/item/stack/sheet/plasteel))
			var/obj/item/stack/sheet/plasteel/candidate = target
			var/quantity = candidate.amount
			if(candidate.use(quantity))
				uses --
				new /obj/item/stack/sheet/runed_metal(T,quantity)
				to_chat(user, "<span class='warning'>Тёмное облако исходит из твоей руки и обвивает пласталь, превращая её в рунический металл!</span>")
				SEND_SOUND(user, sound('sound/blank.ogg',0,1,25))
		else if(istype(target,/mob/living/silicon/robot))
			var/mob/living/silicon/robot/candidate = target
			if(candidate.mmi)
				channeling = TRUE
				user.visible_message("<span class='danger'>A dark cloud emanates from [user]'s hand and swirls around [candidate]!</span>")
				playsound(T, 'sound/blank.ogg', 80, TRUE)
				var/prev_color = candidate.color
				candidate.color = "black"
				if(do_after(user, 90, target = candidate))
					candidate.emp_act(EMP_HEAVY)
					var/construct_class = alert(user, "Please choose which type of construct you wish to create.",,"Juggernaut","Wraith","Artificer")
					if(QDELETED(candidate))
						channeling = FALSE
						return
					user.visible_message("<span class='danger'>The dark cloud receedes from what was formerly [candidate], revealing a\n [construct_class]!</span>")
					switch(construct_class)
						if("Juggernaut")
							makeNewConstruct(/mob/living/simple_animal/hostile/construct/armored, candidate, user, 0, T)
						if("Wraith")
							makeNewConstruct(/mob/living/simple_animal/hostile/construct/wraith, candidate, user, 0, T)
						if("Artificer")
							makeNewConstruct(/mob/living/simple_animal/hostile/construct/builder, candidate, user, 0, T)
					SEND_SOUND(user, sound('sound/blank.ogg',0,1,25))
					uses--
					candidate.mmi = null
					qdel(candidate)
					channeling = FALSE
				else
					channeling = FALSE
					candidate.color = prev_color
					return
			else
				uses--
				to_chat(user, "<span class='warning'>Тёмное облако исходит из твоей руки и обвивает [candidate], превращая его в оболочку конструкта!</span>")
				new /obj/structure/constructshell(T)
				SEND_SOUND(user, sound('sound/blank.ogg',0,1,25))
				qdel(candidate)
		else if(istype(target,/obj/machinery/door/airlock))
			channeling = TRUE
			playsound(T, 'sound/blank.ogg', 50, TRUE)
			do_sparks(5, TRUE, target)
			if(do_after(user, 50, target = user))
				if(QDELETED(target))
					channeling = FALSE
					return
				target.narsie_act()
				uses--
				user.visible_message("<span class='warning'>Чёрные ленты вырываются из руки [user] и оплетают дверь, оскверняя и искривляя её!</span>")
				SEND_SOUND(user, sound('sound/blank.ogg',0,1,25))
				channeling = FALSE
			else
				channeling = FALSE
				return
		else
			to_chat(user, "<span class='warning'>Заклинание не подействует на [target]!</span>")
			return
		..()

//Armor: Gives the target a basic cultist combat loadout
/obj/item/melee/blood_magic/armor
	name = "Arming Aura"
	desc = ""
	color = "#33cc33" // green

/obj/item/melee/blood_magic/armor/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(iscarbon(target) && proximity)
		uses--
		var/mob/living/carbon/C = target
		C.visible_message("<span class='warning'>Потусторонняя броня внезапно возникает на [C]!</span>")
		C.equip_to_slot_or_del(new /obj/item/clothing/under/color/black,SLOT_PANTS)
		C.equip_to_slot_or_del(new /obj/item/clothing/suit/hooded/cultrobes/alt(user), SLOT_ARMOR)
		C.equip_to_slot_or_del(new /obj/item/clothing/shoes/cult/alt(user), SLOT_SHOES)
		C.equip_to_slot_or_del(new /obj/item/storage/backpack/cultpack(user), SLOT_BACK)
		if(C == user)
			qdel(src) //Clears the hands
		C.put_in_hands(new /obj/item/melee/cultblade(user))
		C.put_in_hands(new /obj/item/restraints/legcuffs/bola/cult(user))
		..()

/obj/item/melee/blood_magic/manipulator
	name = "Blood Rite Aura"
	desc = ""
	color = "#7D1717"

/obj/item/melee/blood_magic/manipulator/examine(mob/user)
	. = ..()
	. += "Blood spear, blood bolt barrage, and blood beam cost [BLOOD_SPEAR_COST], [BLOOD_BARRAGE_COST], and [BLOOD_BEAM_COST] charges respectively."

/obj/item/melee/blood_magic/manipulator/afterattack(atom/target, mob/living/carbon/human/user, proximity)
	if(proximity)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(NOBLOOD in H.dna.species.species_traits)
				to_chat(user,"<span class='warning'>Обряды крови не действуют на бескровных созданий!</span>")
				return
			if(iscultist(H))
				if(H.stat == DEAD)
					to_chat(user,"<span class='warning'>Только руна воскрешения может вернуть мёртвых!</span>")
					return
				if(H.blood_volume < BLOOD_VOLUME_SAFE)
					var/restore_blood = BLOOD_VOLUME_SAFE - H.blood_volume
					if(uses*2 < restore_blood)
						H.blood_volume += uses*2
						to_chat(user,"<span class='danger'>Ты отдаёшь остатки сил обряда крови, чтобы восполнить кровь!</span>")
						uses = 0
						return ..()
					else
						H.blood_volume = BLOOD_VOLUME_SAFE
						uses -= round(restore_blood/2)
						to_chat(user,"<span class='warning'>Обряд крови восстановил уровень крови [H == user ? "у тебя" : "у [H]"] до безопасного!</span>")
				var/overall_damage = H.getBruteLoss() + H.getFireLoss() + H.getToxLoss() + H.getOxyLoss()
				if(overall_damage == 0)
					to_chat(user,"<span class='cult'>Этому культисту исцеление не требуется!</span>")
				else
					var/ratio = uses/overall_damage
					if(H == user)
						to_chat(user,"<span class='cult'><b>Исцеление крови куда менее эффективно при использовании на себе!</b></span>")
						ratio *= 0.35 // Healing is half as effective if you can't perform a full heal
						uses -= round(overall_damage) // Healing is 65% more "expensive" even if you can still perform the full heal
					if(ratio>1)
						ratio = 1
						uses -= round(overall_damage)
						H.visible_message("<span class='warning'>[H] полностью исцеляется магией крови!</span>")
					else
						H.visible_message("<span class='warning'>[H] частично исцеляется магией крови.</span>")
						uses = 0
					ratio *= -1
					H.adjustOxyLoss((overall_damage*ratio) * (H.getOxyLoss() / overall_damage), 0)
					H.adjustToxLoss((overall_damage*ratio) * (H.getToxLoss() / overall_damage), 0)
					H.adjustFireLoss((overall_damage*ratio) * (H.getFireLoss() / overall_damage), 0)
					H.adjustBruteLoss((overall_damage*ratio) * (H.getBruteLoss() / overall_damage), 0)
					H.updatehealth()
					playsound(get_turf(H), 'sound/blank.ogg', 25)
					new /obj/effect/temp_visual/cult/sparks(get_turf(H))
					user.Beam(H,icon_state="sendbeam",time=15)
			else
				if(H.stat == DEAD)
					to_chat(user,"<span class='warning'>Кровь жертвы перестала течь, придётся найти другой способ добыть её.</span>")
					return
				if(H.cultslurring)
					to_chat(user,"<span class='danger'>Эта кровь осквернена ещё более могущественной магией крови, она бесполезна!</span>")
					return
				if(H.blood_volume > BLOOD_VOLUME_SAFE)
					H.blood_volume -= 100
					uses += 50
					user.Beam(H,icon_state="drainbeam",time=10)
					playsound(get_turf(H), 'sound/blank.ogg', 50)
					H.visible_message("<span class='danger'>[user] вытягивает часть крови из [H]!</span>")
					to_chat(user,"<span class='cultitalic'>Обряд крови получает 50 зарядов за счёт крови [H].</span>")
					new /obj/effect/temp_visual/cult/sparks(get_turf(H))
				else
					to_chat(user,"<span class='warning'>У цели слишком мало крови — больше вытянуть нельзя!</span>")
					return
		if(isconstruct(target))
			var/mob/living/simple_animal/M = target
			var/missing = M.maxHealth - M.health
			if(missing)
				if(uses > missing)
					M.adjustHealth(-missing)
					M.visible_message("<span class='warning'>[M] полностью исцеляется магией крови [user]!</span>")
					uses -= missing
				else
					M.adjustHealth(-uses)
					M.visible_message("<span class='warning'>[M] частично исцеляется магией крови [user]!</span>")
					uses = 0
				playsound(get_turf(M), 'sound/blank.ogg', 25)
				user.Beam(M,icon_state="sendbeam",time=10)
		if(istype(target, /obj/effect/decal/cleanable/blood))
			blood_draw(target, user)
		..()

/obj/item/melee/blood_magic/manipulator/proc/blood_draw(atom/target, mob/living/carbon/human/user)
	var/temp = 0
	var/turf/T = get_turf(target)
	if(T)
		for(var/obj/effect/decal/cleanable/blood/B in view(T, 2))
			if(B.blood_state == BLOOD_STATE_HUMAN)
				if(B.bloodiness == 100) //Bonus for "pristine" bloodpools, also to prevent cheese with footprint spam
					temp += 30
				else
					temp += max((B.bloodiness**2)/800,1)
				new /obj/effect/temp_visual/cult/turf/floor(get_turf(B))
				qdel(B)
		for(var/obj/effect/decal/cleanable/trail_holder/TH in view(T, 2))
			qdel(TH)
		var/obj/item/clothing/shoes/shoecheck = user.shoes
		if(shoecheck && shoecheck.bloody_shoes[/datum/reagent/blood])
			temp += shoecheck.bloody_shoes[/datum/reagent/blood]/20
			shoecheck.bloody_shoes[/datum/reagent/blood] = 0
		if(temp)
			user.Beam(T,icon_state="drainbeam",time=15)
			new /obj/effect/temp_visual/cult/sparks(get_turf(user))
			playsound(T, 'sound/blank.ogg', 50)
			to_chat(user, "<span class='cultitalic'>Обряд крови поглотил [round(temp)] зарядов из пролитой вокруг крови!</span>")
			uses += max(1, round(temp))

/obj/item/melee/blood_magic/manipulator/attack_self(mob/living/user)
	if(iscultist(user))
		var/list/options = list("Blood Spear (150)", "Blood Bolt Barrage (300)", "Blood Beam (500)")
		var/choice = input(user, "Выбери великий обряд крови...", "Великие обряды крови") as null|anything in options
		if(!choice)
			to_chat(user, "<span class='cultitalic'>Ты решаешь не проводить великий обряд крови.</span>")
			return
		switch(choice)
			if("Blood Spear (150)")
				if(uses < BLOOD_SPEAR_COST)
					to_chat(user, "<span class='cultitalic'>Для этого обряда требуется [BLOOD_SPEAR_COST] зарядов.</span>")
				else
					uses -= BLOOD_SPEAR_COST
					var/turf/T = get_turf(user)
					qdel(src)
					var/datum/action/innate/cult/spear/S = new(user)
					var/obj/item/twohanded/cult_spear/rite = new(T)
					S.Grant(user, rite)
					rite.spear_act = S
					if(user.put_in_hands(rite))
						to_chat(user, "<span class='cultitalic'>[rite.name] появляется в твоей руке!</span>")
					else
						user.visible_message("<span class='warning'>[rite.name] появляется у ног [user]!</span>", \
							 "<span class='cultitalic'>[rite.name] материализуется у твоих ног.</span>")
			if("Blood Bolt Barrage (300)")
				if(uses < BLOOD_BARRAGE_COST)
					to_chat(user, "<span class='cultitalic'>Для этого обряда требуется [BLOOD_BARRAGE_COST] зарядов.</span>")
				else
					var/obj/rite = new /obj/item/gun/ballistic/rifle/boltaction/enchanted/arcane_barrage/blood()
					uses -= BLOOD_BARRAGE_COST
					qdel(src)
					if(user.put_in_hands(rite))
						to_chat(user, "<span class='cult'><b>Твои руки светятся силой!</b></span>")
					else
						to_chat(user, "<span class='cultitalic'>Для этого обряда нужна свободная рука!</span>")
						qdel(rite)
			if("Blood Beam (500)")
				if(uses < BLOOD_BEAM_COST)
					to_chat(user, "<span class='cultitalic'>Для этого обряда требуется [BLOOD_BEAM_COST] зарядов.</span>")
				else
					var/obj/rite = new /obj/item/blood_beam()
					uses -= BLOOD_BEAM_COST
					qdel(src)
					if(user.put_in_hands(rite))
						to_chat(user, "<span class='cultlarge'><b>Твои руки светятся СОКРУШИТЕЛЬНОЙ СИЛОЙ!!!</b></span>")
					else
						to_chat(user, "<span class='cultitalic'>Для этого обряда нужна свободная рука!</span>")
						qdel(rite)
