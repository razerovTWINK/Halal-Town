/*
Slimecrossing Potions
	Potions added by the slimecrossing system.
	Collected here for clarity.
*/

//Extract cloner - Charged Grey
/obj/item/slimepotion/extract_cloner
	name = "зелье клонирования экстрактов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpurple"

/obj/item/slimepotion/extract_cloner/afterattack(obj/item/target, mob/user , proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/reagent_containers))
		return ..(target, user, proximity)
	if(istype(target, /obj/item/slimecross))
		to_chat(user, "<span class='warning'>[target] слишком сложен для клонирования этим зельем!</span>")
		return
	if(!istype(target, /obj/item/slime_extract))
		return
	var/obj/item/slime_extract/S = target
	if(S.recurring)
		to_chat(user, "<span class='warning'>[target] слишком сложен для клонирования этим зельем!</span>")
		return
	var/path = S.type
	var/obj/item/slime_extract/C = new path(get_turf(target))
	C.Uses = S.Uses
	to_chat(user, "<span class='notice'>Я выливаю зелье на [target], и жидкость застывает в точную копию!</span>")
	qdel(src)
	return

//Peace potion - Charged Light Pink
/obj/item/slimepotion/peacepotion
	name = "зелье умиротворения"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potlightpink"

/obj/item/slimepotion/peacepotion/attack(mob/living/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, "<span class='warning'>Зелье умиротворения действует только на живых.</span>")
		return ..()
	if(istype(M, /mob/living/simple_animal/hostile/megafauna))
		to_chat(user, "<span class='warning'>Зелье умиротворения не действует на порождения чистого зла!</span>")
		return ..()
	if(M != user)
		M.visible_message("<span class='danger'>[user] начинает поить [M] зельем умиротворения!</span>",
			"<span class='danger'>[user] начинает поить тебя зельем умиротворения!</span>")
	else
		M.visible_message("<span class='danger'>[user] начинает пить зелье умиротворения!</span>",
			"<span class='danger'>Я начинаю пить зелье умиротворения!</span>")

	if(!do_after(user, 100, target = M))
		return
	if(M != user)
		to_chat(user, "<span class='notice'>Я спаиваю [M] зелье умиротворения!</span>")
	else
		to_chat(user, "<span class='warning'>Я выпиваю зелье умиротворения!</span>")
	if(isanimal(M))
		ADD_TRAIT(M, TRAIT_PACIFISM, MAGIC_TRAIT)
	else if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_SURGERY)
	qdel(src)

//Love potion - Charged Pink
/obj/item/slimepotion/lovepotion
	name = "любовное зелье"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpink"

/obj/item/slimepotion/lovepotion/attack(mob/living/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, "<span class='warning'>Любовное зелье действует только на живых, извращенец!</span>")
		return ..()
	if(istype(M, /mob/living/simple_animal/hostile/megafauna))
		to_chat(user, "<span class='warning'>Любовное зелье не действует на порождения чистого зла!</span>")
		return ..()
	if(user == M)
		to_chat(user, "<span class='warning'>Я не могу выпить любовное зелье сам. Ты нарцисс, что ли?</span>")
		return ..()
	if(M.has_status_effect(STATUS_EFFECT_INLOVE))
		to_chat(user, "<span class='warning'>[M] уже по уши влюблён!</span>")
		return ..()

	M.visible_message("<span class='danger'>[user] начинает поить [M] любовным зельем!</span>",
		"<span class='danger'>[user] начинает поить тебя любовным зельем!</span>")

	if(!do_after(user, 50, target = M))
		return
	to_chat(user, "<span class='notice'>Я спаиваю [M] любовное зелье!</span>")
	to_chat(M, "<span class='notice'>У меня возникают тёплые чувства к [user] и всем, кто [user.p_they()] нравится.</span>")
	if(M.mind)
		M.mind.store_memory("Ты влюблен в [user].")
	M.faction |= "[REF(user)]"
	M.apply_status_effect(STATUS_EFFECT_INLOVE, user)
	qdel(src)

//Pressure potion - Charged Dark Blue
/obj/item/slimepotion/spaceproof
	name = "зелье герметизации"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potblue"
	var/uses = 2

/obj/item/slimepotion/spaceproof/afterattack(obj/item/clothing/C, mob/user, proximity)
	. = ..()
	if(!uses)
		qdel(src)
		return
	if(!proximity)
		return
	if(!istype(C))
		to_chat(user, "<span class='warning'>Зелье можно использовать только на одежде!</span>")
		return
	if(C.min_cold_protection_temperature == SPACE_SUIT_MIN_TEMP_PROTECT && C.clothing_flags & STOPSPRESSUREDAMAGE)
		to_chat(user, "<span class='warning'>[C] уже герметичен!</span>")
		return ..()
	to_chat(user, "<span class='notice'>Я обмазываю синей жижей [C], делая ткань воздухонепроницаемой.</span>")
	C.name = "герметичный(-ая) [C.name]"
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour("#000080", FIXED_COLOUR_PRIORITY)
	C.min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	C.cold_protection = C.body_parts_covered
	C.clothing_flags |= STOPSPRESSUREDAMAGE
	uses--
	if(!uses)
		qdel(src)

//Enhancer potion - Charged Cerulean
/obj/item/slimepotion/enhancer/max
	name = "максимизатор экстрактов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpurple"

//Lavaproofing potion - Charged Red
/obj/item/slimepotion/lavaproof
	name = "зелье лавостойкости"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potred"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	var/uses = 2

/obj/item/slimepotion/lavaproof/afterattack(obj/item/C, mob/user, proximity)
	. = ..()
	if(!uses)
		qdel(src)
		return ..()
	if(!proximity)
		return ..()
	if(!istype(C))
		to_chat(user, "<span class='warning'>Я не могу покрыть это лавостойкой жидкостью!</span>")
		return ..()
	to_chat(user, "<span class='notice'>Я обмазываю красной жижей [C], делая предмет лавостойким.</span>")
	C.name = "лавостойкий(-ая) [C.name]"
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour("#800000", FIXED_COLOUR_PRIORITY)
	C.resistance_flags |= LAVA_PROOF
	if (istype(C, /obj/item/clothing))
		var/obj/item/clothing/CL = C
		CL.clothing_flags |= LAVAPROTECT
	uses--
	if(!uses)
		qdel(src)

//Revival potion - Charged Grey
/obj/item/slimepotion/slime_reviver
	name = "зелье оживления слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potsilver"

/obj/item/slimepotion/slime_reviver/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>Зелье действует только на слаймов!</span>")
		return ..()
	if(M.stat != DEAD)
		to_chat(user, "<span class='warning'>Слайм всё ещё жив!</span>")
		return
	if(M.maxHealth <= 0)
		to_chat(user, "<span class='warning'>Слайм слишком нестабилен для возвращения!</span>")
	M.revive(full_heal = TRUE, admin_revive = FALSE)
	M.stat = CONSCIOUS
	M.visible_message("<span class='notice'>[M] наполняется новой силой и пробуждается!</span>")
	M.maxHealth -= 10 //Revival isn't healthy.
	M.health -= 10
	M.regenerate_icons()
	qdel(src)

//Stabilizer potion - Charged Blue
/obj/item/slimepotion/slime/chargedstabilizer
	name = "омнистабилизатор слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potcyan"

/obj/item/slimepotion/slime/chargedstabilizer/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>Стабилизатор действует только на слаймов!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>Слайм мёртв!</span>")
		return
	if(M.mutation_chance == 0)
		to_chat(user, "<span class='warning'>У этого слайма и так нет шансов на мутацию!</span>")
		return

	to_chat(user, "<span class='notice'>Я скармливаю слайму омнистабилизатор. Он не будет мутировать в этом цикле!</span>")
	M.mutation_chance = 0
	qdel(src)
