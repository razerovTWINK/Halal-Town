/// Slime Extracts ///

/obj/item/slime_extract
	name = "экстракт слайма"
	desc = ""
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey slime extract"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6
	grind_results = list()
	var/Uses = 1 // uses before it goes inert
	var/qdel_timer = null // deletion timer, for delayed reactions
	var/effectmod
	var/list/activate_reagents = list() //Reagents required for activation
	var/recurring = FALSE

/obj/item/slime_extract/examine(mob/user)
	. = ..()
	if(Uses > 1)
		. += "It has [Uses] uses remaining."

/obj/item/slime_extract/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/slimepotion/enhancer))
		if(Uses >= 5 || recurring)
			to_chat(user, "<span class='warning'>Этот экстракт нельзя усилить сильнее!</span>")
			return ..()
		if(O.type == /obj/item/slimepotion/enhancer) //Seriously, why is this defined here...?
			to_chat(user, "<span class='notice'>Я наношу усилитель на экстракт слайма. Теперь его можно использовать ещё один раз.</span>")
			Uses++
		if(O.type == /obj/item/slimepotion/enhancer/max)
			to_chat(user, "<span class='notice'>Я выливаю максимизатор на экстракт слайма. Теперь его можно использовать 5 раз!</span>")
			Uses = 5
		qdel(O)
	..()

/obj/item/slime_extract/Initialize()
	. = ..()
	create_reagents(100, INJECTABLE | DRAWABLE)

/obj/item/slime_extract/on_grind()
	if(Uses)
		grind_results[/datum/reagent/toxin/slimejelly] = 20

//Effect when activated by a Luminescent. Separated into a minor and major effect. Returns cooldown in deciseconds.
/obj/item/slime_extract/proc/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	to_chat(user, "<span class='warning'>Ничего не произошло... Этот экстракт слайма нельзя активировать таким способом.</span>")
	return 0

//Core-crossing: Feeding adult slimes extracts to obtain a much more powerful, single extract.
/obj/item/slime_extract/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>Слайм мёртв!</span>")
		return
	if(!M.is_adult)
		to_chat(user, "<span class='warning'>Слайм должен быть взрослым, чтобы скрестить его ядро!</span>")
		return
	if(M.effectmod && M.effectmod != effectmod)
		to_chat(user, "<span class='warning'>Этот слайм уже скрещивается с другим экстрактом!</span>")
		return

	if(!M.effectmod)
		M.effectmod = effectmod

	M.applied++
	qdel(src)
	to_chat(user, "<span class='notice'>I feed the slime [src], [M.applied == 1 ? "запуская мутацию его ядра." : "продолжая мутацию его ядра."]</span>")
	playsound(M, 'sound/blank.ogg', 50, TRUE)

	if(M.applied >= SLIME_EXTRACT_CROSSING_REQUIRED)
		M.spawn_corecross()

/obj/item/slime_extract/grey
	name = "экстракт серого слайма"
	icon_state = "grey slime extract"
	effectmod = "reproductive"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/grey/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/reagent_containers/food/snacks/monkeycube/M = new
			if(!user.put_in_active_hand(M))
				M.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			to_chat(user, "<span class='notice'>Я выплёвываю обезьяний кубик.</span>")
			return 120
		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, "<span class='notice'>Мой [name] начинает пульсировать...</span>")
			if(do_after(user, 40, target = user))
				var/mob/living/simple_animal/slime/S = new(get_turf(user), "grey")
				playsound(user, 'sound/blank.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>Я выплёвываю [S].</span>")
				return 350
			else
				return 0

/obj/item/slime_extract/gold
	name = "экстракт золотого слайма"
	icon_state = "gold slime extract"
	effectmod = "symbiont"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/gold/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.visible_message("<span class='warning'>[user] начинает дрожать!</span>","<span class='notice'>Мой [name] начинает мягко пульсировать...</span>")
			if(do_after(user, 40, target = user))
				var/mob/living/simple_animal/S = create_random_mob(user.drop_location(), FRIENDLY_SPAWN)
				S.faction |= "neutral"
				playsound(user, 'sound/blank.ogg', 50, TRUE)
				user.visible_message("<span class='warning'>[user] выплёвывает [S]!</span>", "<span class='notice'>Я выплёвываю [S]!</span>")
				return 300

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message("<span class='warning'>[user] начинает яростно трястись!</span>","<span class='warning'>Мой [name] яростно пульсирует...</span>")
			if(do_after(user, 50, target = user))
				var/mob/living/simple_animal/S = create_random_mob(user.drop_location(), HOSTILE_SPAWN)
				if(user.used_intent.type != INTENT_HARM)
					S.faction |= "neutral"
				else
					S.faction |= "slime"
				playsound(user, 'sound/blank.ogg', 50, TRUE)
				user.visible_message("<span class='warning'>[user] выплёвывает [S]!</span>", "<span class='warning'>Я выплёвываю [S]!</span>")
				return 600

/obj/item/slime_extract/silver
	name = "экстракт серебряного слайма"
	icon_state = "silver slime extract"
	effectmod = "consuming"
	activate_reagents = list(/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/silver/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/food_type = get_random_food()
			var/obj/O = new food_type
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 200
		if(SLIME_ACTIVATE_MAJOR)
			var/drink_type = get_random_drink()
			var/obj/O = new drink_type
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 200

/obj/item/slime_extract/metal
	name = "экстракт металлического слайма"
	icon_state = "metal slime extract"
	effectmod = "industrial"
	activate_reagents = list(/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/metal/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/stack/sheet/glass/O = new(null, 5)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/obj/item/stack/sheet/metal/O = new(null, 5)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 200

/obj/item/slime_extract/purple
	name = "экстракт фиолетового слайма"
	icon_state = "purple slime extract"
	effectmod = "regenerative"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)

/obj/item/slime_extract/purple/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.adjust_nutrition(50)
			user.blood_volume += 50
			to_chat(user, "<span class='notice'>Я активирую [src], и моё тело наполняется свежим желе слайма!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, "<span class='notice'>Я активирую [src], и он выделяет регенерирующие вещества!</span>")
			user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,10)
			return 600

/obj/item/slime_extract/darkpurple
	name = "экстракт тёмно-фиолетового слайма"
	icon_state = "dark purple slime extract"
	effectmod = "self-sustaining"
	activate_reagents = list(/datum/reagent/toxin/plasma)

/obj/item/slime_extract/darkpurple/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/stack/sheet/mineral/plasma/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("plasma=20")
			to_chat(user, "<span class='warning'>Я активирую [src], и облако плазмы вырывается из моей кожи!</span>")
			return 900

/obj/item/slime_extract/orange
	name = "экстракт оранжевого слайма"
	icon_state = "orange slime extract"
	effectmod = "burning"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/orange/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='notice'>Я активирую [src]. Становится очень жарко!</span>")
			user.reagents.add_reagent(/datum/reagent/consumable/capsaicin,10)
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			user.reagents.add_reagent(/datum/reagent/phosphorus,5)//
			user.reagents.add_reagent(/datum/reagent/potassium,5) // = smoke, along with any reagents inside mr. slime
			user.reagents.add_reagent(/datum/reagent/consumable/sugar,5)     //
			to_chat(user, "<span class='warning'>Я активирую [src], и облако дыма вырывается из моей кожи!</span>")
			return 450

/obj/item/slime_extract/yellow
	name = "экстракт жёлтого слайма"
	icon_state = "yellow slime extract"
	effectmod = "charged"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/yellow/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(species.glow_intensity != LUMINESCENT_DEFAULT_GLOW)
				to_chat(user, "<span class='warning'>Моё свечение уже усилено!</span>")
				return
			species.update_glow(user, 5)
			addtimer(CALLBACK(species, /datum/species/jelly/luminescent.proc/update_glow, user, LUMINESCENT_DEFAULT_GLOW), 600)
			to_chat(user, "<span class='notice'>Я начинаю светиться ярче.</span>")

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message("<span class='warning'>Кожа [user] начинает прерывисто мерцать...</span>", "<span class='warning'>Моя кожа начинает прерывисто мерцать...</span>")
			if(do_after(user, 25, target = user))
				empulse(user, 1, 2)
				user.visible_message("<span class='warning'>Кожа [user] ярко вспыхивает!</span>", "<span class='warning'>Моя кожа вспыхивает, испуская электромагнитный импульс!</span>")
				return 600

/obj/item/slime_extract/red
	name = "экстракт красного слайма"
	icon_state = "red slime extract"
	effectmod = "sanguine"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/red/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='notice'>Я активирую [src]. Ты чувствуешь небывалую скорость!</span>")
			user.reagents.add_reagent(/datum/reagent/medicine/ephedrine,5)
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message("<span class='warning'>Кожа [user] на мгновение вспыхивает красным...</span>", "<span class='warning'>Моя кожа вспыхивает красным, выделяя феромоны ярости...</span>")
			for(var/mob/living/simple_animal/slime/slime in viewers(get_turf(user), null))
				slime.rabid = TRUE
				slime.visible_message("<span class='danger'>[slime] впадает в безумную ярость!</span>")
			return 600

/obj/item/slime_extract/blue
	name = "экстракт синего слайма"
	icon_state = "blue slime extract"
	effectmod = "stabilized"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/blue/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='notice'>Я активирую [src]. Твой геном становится стабильнее!</span>")
			user.adjustCloneLoss(-15)
			user.reagents.add_reagent(/datum/reagent/medicine/mutadone, 10)
			user.reagents.add_reagent(/datum/reagent/medicine/potass_iodide, 10)
			return 250

		if(SLIME_ACTIVATE_MAJOR)
			user.reagents.create_foam(/datum/effect_system/foam_spread,20)
			user.visible_message("<span class='danger'>Пена хлещет из кожи [user]!</span>", "<span class='warning'>Я активирую [src], и пена вырывается из моей кожи!</span>")
			return 600

/obj/item/slime_extract/darkblue
	name = "экстракт тёмно-синего слайма"
	icon_state = "dark blue slime extract"
	effectmod = "chilling"
	activate_reagents = list(/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/darkblue/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='notice'>Я активирую [src]. Становится ощутимо холоднее!</span>")
			user.ExtinguishMob()
			user.adjust_fire_stacks(-20)
			user.reagents.add_reagent(/datum/reagent/consumable/frostoil,4)
			user.reagents.add_reagent(/datum/reagent/medicine/cryoxadone,5)
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("nitrogen=40;TEMP=2.7")
			to_chat(user, "<span class='warning'>Я активирую [src], и ледяной воздух вырывается из моей кожи!</span>")
			return 900

/obj/item/slime_extract/pink
	name = "экстракт розового слайма"
	icon_state = "pink slime extract"
	effectmod = "gentle"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)

/obj/item/slime_extract/pink/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(user.gender != MALE && user.gender != FEMALE)
				to_chat(user, "<span class='warning'>Я не могу сменить свой пол!</span>")
				return

			if(user.gender == MALE)
				user.gender = FEMALE
				user.visible_message("<span class='boldnotice'>[user] внезапно выглядит более женственно!</span>", "<span class='boldwarning'>Я внезапно чувствую себя более женственно!</span>")
			else
				user.gender = MALE
				user.visible_message("<span class='boldnotice'>[user] внезапно выглядит более мужественно!</span>", "<span class='boldwarning'>Я внезапно чувствую себя более мужественно!</span>")
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message("<span class='warning'>Кожа [user] начинает гипнотически мерцать...</span>", "<span class='notice'>Моя кожа покрывается странными узорами, успокаивая существ вокруг.</span>")
			for(var/mob/living/carbon/C in viewers(user, null))
				if(C != user)
					C.reagents.add_reagent(/datum/reagent/pax,2)
			return 600

/obj/item/slime_extract/green
	name = "экстракт зелёного слайма"
	icon_state = "green slime extract"
	effectmod = "mutative"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/uranium/radium)

/obj/item/slime_extract/green/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='warning'>Я чувствую, как возвращаюсь в человеческий облик...</span>")
			if(do_after(user, 120, target = user))
				to_chat(user, "<span class='warning'>Я снова человек!</span>")
				user.set_species(/datum/species/human)
				return
			to_chat(user, "<span class='notice'>Я останавливаю трансформацию.</span>")

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, "<span class='warning'>Я чувствую, как кардинально меняется мой тип слайма...</span>")
			if(do_after(user, 120, target = user))
				to_chat(user, "<span class='warning'>Я чувствую себя иначе!</span>")
				user.set_species(pick(/datum/species/jelly/slime, /datum/species/jelly/stargazer))
				return
			to_chat(user, "<span class='notice'>Я останавливаю трансформацию.</span>")

/obj/item/slime_extract/lightpink
	name = "экстракт светло-розового слайма"
	icon_state = "light pink slime extract"
	effectmod = "loyal"
	activate_reagents = list(/datum/reagent/toxin/plasma)

/obj/item/slime_extract/lightpink/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/slimepotion/slime/renaming/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/obj/item/slimepotion/slime/sentience/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 450

/obj/item/slime_extract/black
	name = "экстракт чёрного слайма"
	icon_state = "black slime extract"
	effectmod = "transformative"
	activate_reagents = list(/datum/reagent/toxin/plasma)

/obj/item/slime_extract/black/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='danger'>Я чувствую, что внутри что-то <i>не так</i>...</span>")
			user.ForceContractDisease(new /datum/disease/transformation/slime(), FALSE, TRUE)
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, "<span class='warning'>Я чувствую, как мой свет обращается во тьму...</span>")
			if(do_after(user, 120, target = user))
				to_chat(user, "<span class='warning'>Я чувствую тягу к тьме.</span>")
				user.set_species(pick(/datum/species/shadow))
				return
			to_chat(user, "<span class='notice'>Я перестаю кормить [src].</span>")

/obj/item/slime_extract/oil
	name = "экстракт масляного слайма"
	icon_state = "oil slime extract"
	effectmod = "detonating"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)

/obj/item/slime_extract/oil/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='warning'>Меня рвёт скользкой нефтью.</span>")
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			new /obj/effect/decal/cleanable/oil/slippery(get_turf(user))
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message("<span class='warning'>Кожа [user] начинает зловеще пульсировать и светиться...</span>", "<span class='danger'>Я чувствую нестабильность...</span>")
			if(do_after(user, 60, target = user))
				to_chat(user, "<span class='danger'>Я взрываюсь!</span>")
				explosion(get_turf(user), 1 ,3, 6)
				user.gib()
				return
			to_chat(user, "<span class='notice'>Я перестаю кормить [src], и это чувство проходит.</span>")

/obj/item/slime_extract/adamantine
	name = "экстракт адамантинового слайма"
	icon_state = "adamantine slime extract"
	effectmod = "crystalline"
	activate_reagents = list(/datum/reagent/toxin/plasma)

/obj/item/slime_extract/adamantine/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(species.armor > 0)
				to_chat(user, "<span class='warning'>Моя кожа уже затвердела!</span>")
				return
			to_chat(user, "<span class='notice'>Я чувствую, как кожа твердеет и становится более прочной.</span>")
			species.armor += 25
			addtimer(CALLBACK(src, .proc/reset_armor, species), 1200)
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, "<span class='warning'>Я чувствую, как моё тело стремительно кристаллизуется...</span>")
			if(do_after(user, 120, target = user))
				to_chat(user, "<span class='warning'>Я чувствую себя твёрдым как камень.</span>")
				user.set_species(pick(/datum/species/golem/adamantine))
				return
			to_chat(user, "<span class='notice'>Я перестаю кормить [src], и моё тело возвращается в желеобразное состояние.</span>")

/obj/item/slime_extract/adamantine/proc/reset_armor(datum/species/jelly/luminescent/species)
	if(istype(species))
		species.armor -= 25

/obj/item/slime_extract/bluespace
	name = "экстракт блюспейс-слайма"
	icon_state = "bluespace slime extract"
	effectmod = "warping"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	var/teleport_ready = FALSE
	var/teleport_x = 0
	var/teleport_y = 0
	var/teleport_z = 0

/obj/item/slime_extract/bluespace/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, "<span class='warning'>Я чувствую вибрацию во всём теле...</span>")
			if(do_after(user, 25, target = user))
				to_chat(user, "<span class='warning'>Я телепортируюсь!</span>")
				do_teleport(user, get_turf(user), 6, asoundin = 'sound/blank.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
				return 300

		if(SLIME_ACTIVATE_MAJOR)
			if(!teleport_ready)
				to_chat(user, "<span class='notice'>Я чувствую привязку к этому месту...</span>")
				var/turf/T = get_turf(user)
				teleport_x = T.x
				teleport_y = T.y
				teleport_z = T.z
				teleport_ready = TRUE
			else
				teleport_ready = FALSE
				if(teleport_x && teleport_y && teleport_z)
					var/turf/T = locate(teleport_x, teleport_y, teleport_z)
					to_chat(user, "<span class='notice'>Меня мгновенно переносит обратно к точке привязки!</span>")
					do_teleport(user, T,  asoundin = 'sound/blank.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
					return 450


/obj/item/slime_extract/pyrite
	name = "экстракт пиритового слайма"
	icon_state = "pyrite slime extract"
	effectmod = "prismatic"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)

/obj/item/slime_extract/pyrite/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/chosen = pick(difflist(subtypesof(/obj/item/toy/crayon),typesof(/obj/item/toy/crayon/spraycan)))
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/blacklisted_cans = list(/obj/item/toy/crayon/spraycan/borg, /obj/item/toy/crayon/spraycan/infinite)
			var/chosen = pick(subtypesof(/obj/item/toy/crayon/spraycan) - blacklisted_cans)
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 250

/obj/item/slime_extract/cerulean
	name = "экстракт лазурного слайма"
	icon_state = "cerulean slime extract"
	effectmod = "recurring"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)

/obj/item/slime_extract/cerulean/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.reagents.add_reagent(/datum/reagent/medicine/salbutamol,15)
			to_chat(user, "<span class='notice'>Кажется, дыхание больше не требуется!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("o2=11;n2=41;TEMP=293.15")
				to_chat(user, "<span class='warning'>Я активирую [src], и свежий воздух вырывается из моей кожи!</span>")
				return 600

/obj/item/slime_extract/sepia
	name = "экстракт сепия-слайма"
	icon_state = "sepia slime extract"
	effectmod = "lengthened"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)

/obj/item/slime_extract/sepia/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/camera/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, "<span class='warning'>Я чувствую, как время замедляется...</span>")
			if(do_after(user, 30, target = user))
				new /obj/effect/timestop(get_turf(user), 2, 50, list(user))
				return 900

/obj/item/slime_extract/rainbow
	name = "экстракт радужного слайма"
	icon_state = "rainbow slime extract"
	effectmod = "hyperchromatic"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,"lesser plasma",/datum/reagent/toxin/slimejelly,"holy water and uranium") //Curse this snowflake reagent list.

/obj/item/slime_extract/rainbow/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.dna.features["mcolor"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
			user.updateappearance(mutcolor_update=1)
			species.update_glow(user)
			to_chat(user, "<span class='notice'>Я чувствую перемены...</span>")
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			var/chosen = pick(subtypesof(/obj/item/slime_extract))
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/blank.ogg', 50, TRUE)
			user.visible_message("<span class='warning'>[user] выплёвывает [O]!</span>", "<span class='notice'>Я выплёвываю [O]!</span>")
			return 150

////Slime-derived potions///

/obj/item/slimepotion
	name = "зелье слайма"
	desc = ""
	w_class = WEIGHT_CLASS_TINY

/obj/item/slimepotion/afterattack(obj/item/reagent_containers/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if (istype(target))
		to_chat(user, "<span class='warning'>Нельзя перелить [src] в [target]! Зелье должно быть поглощено слаймом напрямую.</span>" )
		return

/obj/item/slimepotion/slime/docility
	name = "зелье покорности"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potsilver"

/obj/item/slimepotion/slime/docility/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>Зелье действует только на слаймов!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>Слайм мёртв!</span>")
		return
	if(M.rabid) //Stops being rabid, but doesn't become truly docile.
		to_chat(M, "<span class='warning'>Я поглощаю зелье, и дикий голод уступает место обычному аппетиту.</span>")
		to_chat(user, "<span class='notice'>Я спаиваю слайму зелье, успокаивая его слепую ярость.</span>")
		M.rabid = FALSE
		qdel(src)
		return
	M.docile = 1
	M.set_nutrition(700)
	to_chat(M, "<span class='warning'>Я поглощаю зелье и чувствую, как неутолимый голод полностью исчезает.</span>")
	to_chat(user, "<span class='notice'>Я спаиваю слайму зелье, утоляя его голод и успокаивая его.</span>")
	var/newname = copytext(sanitize_name(input(user, "Хочешь дать слайму имя?", "Имя питомца", "ручной слайм") as null|text),1,MAX_NAME_LEN)

	if (!newname)
		newname = "pet slime"
	M.name = newname
	M.real_name = newname
	qdel(src)

/obj/item/slimepotion/slime/sentience
	name = "зелье разума"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpink"
	var/list/not_interested = list()
	var/being_used = FALSE
	var/sentience_type = SENTIENCE_ORGANIC

/obj/item/slimepotion/slime/sentience/attack(mob/living/M, mob/user)
	if(being_used || !ismob(M))
		return
	if(!isanimal(M) || M.ckey) //only works on animals that aren't player controlled
		to_chat(user, "<span class='warning'>[M] уже слишком разумен для этого!</span>")
		return
	if(M.stat)
		to_chat(user, "<span class='warning'>[M] мёртв!</span>")
		return
	var/mob/living/simple_animal/SM = M
	if(SM.sentience_type != sentience_type)
		to_chat(user, "<span class='warning'>[src] не сработает на [SM].</span>")
		return

	to_chat(user, "<span class='notice'>Я предлагаю [src] [SM]...</span>")
	being_used = TRUE

	var/list/candidates = pollCandidatesForMob("Do you want to play as [SM.name]?", ROLE_SENTIENCE, null, ROLE_SENTIENCE, 50, SM, POLL_IGNORE_SENTIENCE_POTION) // see poll_ignore.dm
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		SM.key = C.key
		SM.mind.enslave_mind_to_creator(user)
		SM.sentience_act()
		to_chat(SM, "<span class='warning'>Всё встаёт на свои места: ты осознаёшь себя и окружающий мир! Разум пробудился!</span>")
		to_chat(SM, "<span class='danger'>Я благодарен за обретённый разум и нахожусь в огромном долгу перед [user.real_name]. Служи [user.real_name] и помогай [user.p_them()] достигать любых целей любой ценой.</span>")
		if(SM.flags_1 & HOLOGRAM_1) //Check to see if it's a holodeck creature
			to_chat(SM, "<span class='danger'>К тебе также приходит тоскливое осознание: ты не настоящее существо, а голоформа. Твоё существование ограничено пределами голодека.</span>")
		to_chat(user, "<span class='notice'>[SM] принимает [src] и внезапно становится внимательным и осознанным. Сработало!</span>")
		SM.copy_known_languages_from(user, FALSE)
		after_success(user, SM)
		qdel(src)
	else
		to_chat(user, "<span class='notice'>[SM] на миг проявляет интерес, но затем снова опускает взгляд. Возможно, стоит попробовать позже.</span>")
		being_used = FALSE
		..()

/obj/item/slimepotion/slime/sentience/proc/after_success(mob/living/user, mob/living/simple_animal/SM)
	return

/obj/item/slimepotion/slime/sentience/nuclear
	name = "зелье разума Синдиката"
	desc = ""

/obj/item/slimepotion/slime/sentience/nuclear/after_success(mob/living/user, mob/living/simple_animal/SM)
	var/obj/item/implant/radio/syndicate/imp = new(src)
	imp.implant(SM, user)

	SM.access_card = new /obj/item/card/id/syndicate(SM)
	ADD_TRAIT(SM.access_card, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/slimepotion/transference
	name = "зелье переноса сознания"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potorange"
	var/prompted = 0
	var/animal_type = SENTIENCE_ORGANIC

/obj/item/slimepotion/transference/afterattack(mob/living/M, mob/user, proximity)
	if(!proximity)
		return
	if(prompted || !ismob(M))
		return
	if(!isanimal(M) || M.ckey) //much like sentience, these will not work on something that is already player controlled
		to_chat(user, "<span class='warning'>У [M] уже есть высшее сознание!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>[M] мёртв!</span>")
		return ..()
	var/mob/living/simple_animal/SM = M
	if(SM.sentience_type != animal_type)
		to_chat(user, "<span class='warning'>Я не могу перенести своё сознание в [SM].</span>" )
		return ..()
	var/jb = is_banned_from(user.ckey, ROLE_MIND_TRANSFER)
	if(QDELETED(src) || QDELETED(M) || QDELETED(user))
		return

	if(jb)
		to_chat(user, "<span class='warning'>Разум затуманивается при попытке использовать зелье.</span>")
		return

	prompted = 1
	if(alert("Это навсегда перенесёт твоё сознание в [SM]. Ты уверен, что хочешь сделать это?",,"Да","Нет")=="Нет")
		prompted = 0
		return

	to_chat(user, "<span class='notice'>Я выпиваю зелье и возлагаю руки на [SM]...</span>")


	user.mind.transfer_to(SM)
	SM.faction = user.faction.Copy()
	SM.sentience_act() //Same deal here as with sentience
	user.death()
	to_chat(SM, "<span class='notice'>Во вспышке света сознание перетекает в [SM]!</span>")
	to_chat(SM, "<span class='warning'>Теперь ты — [SM]. Твоя преданность, союзники и цели остаются теми же, что и до переноса сознания!</span>")
	SM.name = "[user.real_name]"
	qdel(src)

/obj/item/slimepotion/slime/steroid
	name = "стероид для слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potred"

/obj/item/slimepotion/slime/steroid/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))//If target is not a slime.
		to_chat(user, "<span class='warning'>Стероид действует только на детёнышей слаймов!</span>")
		return ..()
	if(M.is_adult) //Can't steroidify adults
		to_chat(user, "<span class='warning'>Только детёныши слаймов могут усвоить этот стероид!</span>")
		return
	if(M.stat)
		to_chat(user, "<span class='warning'>Слайм мёртв!</span>")
		return
	if(M.cores >= 5)
		to_chat(user, "<span class='warning'>Слайм уже даёт максимальное количество экстрактов!</span>")
		return

	to_chat(user, "<span class='notice'>Я скармливаю слайму стероид. Теперь он даст на один экстракт больше.</span>")
	M.cores++
	qdel(src)

/obj/item/slimepotion/enhancer
	name = "усилитель экстрактов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpurple"

/obj/item/slimepotion/slime/stabilizer
	name = "стабилизатор слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potcyan"

/obj/item/slimepotion/slime/stabilizer/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>Стабилизатор действует только на слаймов!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>Слайм мёртв!</span>")
		return
	if(M.mutation_chance == 0)
		to_chat(user, "<span class='warning'>У этого слайма уже нулевой шанс мутации!</span>")
		return

	to_chat(user, "<span class='notice'>Я скармливаю слайму стабилизатор. Теперь шанс мутации снижен.</span>")
	M.mutation_chance = CLAMP(M.mutation_chance-15,0,100)
	qdel(src)

/obj/item/slimepotion/slime/mutator
	name = "мутатор слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potgreen"

/obj/item/slimepotion/slime/mutator/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>Мутатор действует только на слаймов!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>Слайм мёртв!</span>")
		return
	if(M.mutator_used)
		to_chat(user, "<span class='warning'>Этот слайм уже поглотил мутатор, ещё один приведёт к фатальной нестабильности!</span>")
		return
	if(M.mutation_chance == 100)
		to_chat(user, "<span class='warning'>Мутация этого слайма уже гарантирована!</span>")
		return

	to_chat(user, "<span class='notice'>Я скармливаю слайму мутатор. Шанс мутации повышен.</span>")
	M.mutation_chance = CLAMP(M.mutation_chance+12,0,100)
	M.mutator_used = TRUE
	qdel(src)

/obj/item/slimepotion/speed
	name = "зелье скорости слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potyellow"

/obj/item/slimepotion/speed/afterattack(obj/C, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(C))
		to_chat(user, "<span class='warning'>Зелье можно использовать только на предметах или транспорте!</span>")
		return
	if(isitem(C))
		var/obj/item/I = C
		if(I.slowdown <= 0 || I.obj_flags & IMMUTABLE_SLOW)
			to_chat(user, "<span class='warning'>[C] больше нельзя ускорить!</span>")
			return ..()
		I.slowdown = 0

	if(istype(C, /obj/vehicle))
		var/obj/vehicle/V = C
		var/datum/component/riding/R = V.GetComponent(/datum/component/riding)
		if(R)
			var/vehicle_speed_mod = round(CONFIG_GET(number/movedelay/run_delay) * 0.85, 0.01)
			if(R.vehicle_move_delay <= vehicle_speed_mod)
				to_chat(user, "<span class='warning'>[C] больше нельзя ускорить!</span>")
				return ..()
			R.vehicle_move_delay = vehicle_speed_mod

	to_chat(user, "<span class='notice'>Я обмазываю красной жижей [C], ускоряя его.</span>")
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour("#FF0000", FIXED_COLOUR_PRIORITY)
	qdel(src)

/obj/item/slimepotion/fireproof
	name = "зелье хладостойкости слаймов"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potblue"
	resistance_flags = FIRE_PROOF
	var/uses = 3

/obj/item/slimepotion/fireproof/afterattack(obj/item/clothing/C, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!uses)
		qdel(src)
		return
	if(!istype(C))
		to_chat(user, "<span class='warning'>Зелье можно использовать только на одежде!</span>")
		return
	if(C.max_heat_protection_temperature >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		to_chat(user, "<span class='warning'>[C] уже огнеупорен!</span>")
		return ..()
	to_chat(user, "<span class='notice'>Я обмазываю синей жижей [C], делая ткань огнеупорной.</span>")
	C.name = "огнеупорный(-ая) [C.name]"
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour("#000080", FIXED_COLOUR_PRIORITY)
	C.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	C.heat_protection = C.body_parts_covered
	C.resistance_flags |= FIRE_PROOF
	uses --
	if(!uses)
		qdel(src)

/obj/item/slimepotion/genderchange
	name = "зелье смены пола"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potlightpink"

/obj/item/slimepotion/genderchange/attack(mob/living/L, mob/user)
	if(!istype(L) || L.stat == DEAD)
		to_chat(user, "<span class='warning'>Зелье можно использовать только на живых существах!</span>")
		return

	if(L.gender != MALE && L.gender != FEMALE)
		to_chat(user, "<span class='warning'>Зелье можно использовать только на существах с полом!</span>")
		return

	if(L.gender == MALE)
		L.gender = FEMALE
		L.visible_message("<span class='boldnotice'>[L] внезапно выглядит более женственно!</span>", "<span class='boldwarning'>Я внезапно чувствую себя более женственно!</span>")
	else
		L.gender = MALE
		L.visible_message("<span class='boldnotice'>[L] внезапно выглядит более мужественно!</span>", "<span class='boldwarning'>Я внезапно чувствую себя более мужественно!</span>")
	L.regenerate_icons()
	qdel(src)

/obj/item/slimepotion/slime/renaming
	name = "зелье переименования"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potgreen"

	var/being_used = FALSE

/obj/item/slimepotion/slime/renaming/attack(mob/living/M, mob/user)
	if(being_used || !ismob(M))
		return
	if(!M.ckey) //only works on animals that aren't player controlled
		to_chat(user, "<span class='warning'>[M] не обладает самосознанием и не может выбрать себе имя.</span>")
		return

	being_used = TRUE

	to_chat(user, "<span class='notice'>Я предлагаю [src] [user]...</span>")

	var/new_name = stripped_input(M, "Какое имя ты хочешь выбрать?", "Ввод имени", M.real_name, MAX_NAME_LEN)

	if(!new_name || QDELETED(src) || QDELETED(M) || new_name == M.real_name || !M.Adjacent(user))
		being_used = FALSE
		return

	M.visible_message("<span class='notice'><span class='name'>[M]</span> теперь носит имя <span class='name'>[new_name]</span>.</span>", "<span class='notice'>Старое имя <span class='name'>[M.real_name]</span> растворяется, а новое имя <span class='name'>[new_name]</span> укореняется в сознании.</span>")
	message_admins("[ADMIN_LOOKUPFLW(user)] used [src] on [ADMIN_LOOKUPFLW(M)], letting them rename themselves into [new_name].")

	// pass null as first arg to not update records or ID/PDA
	M.fully_replace_character_name(null, new_name)

	qdel(src)

/obj/item/slimepotion/slime/slimeradio
	name = "зелье блюспейс-радио"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potgrey"

/obj/item/slimepotion/slime/slimeradio/attack(mob/living/M, mob/user)
	if(!ismob(M))
		return
	if(!isanimal(M))
		to_chat(user, "<span class='warning'>[M] слишком сложен для этого зелья!</span>")
		return
	if(M.stat)
		to_chat(user, "<span class='warning'>[M] мёртв!</span>")
		return

	to_chat(user, "<span class='notice'>Я спаиваю зелье [M].</span>")
	to_chat(M, "<span class='notice'>В голове возникает лёгкое покалывание при поглощении зелья. Теперь ты слышишь радиоволны!</span>")
	var/obj/item/implant/radio/slime/imp = new(src)
	imp.implant(M, user)
	qdel(src)

/obj/item/stack/tile/bluespace
	name = "блюспейс-плитка пола"
	singular_name = "плитка пола"
	desc = ""
	icon_state = "tile-bluespace"
	item_state = "tile-bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	custom_materials = list(/datum/material/iron=500)
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	flags_1 = CONDUCT_1
	max_amount = 60
	turf_type = /turf/open/floor/bluespace


/obj/item/stack/tile/sepia
	name = "сепия-плитка пола"
	singular_name = "плитка пола"
	desc = ""
	icon_state = "tile-sepia"
	item_state = "tile-sepia"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	custom_materials = list(/datum/material/iron=500)
	throwforce = 10
	throw_speed = 0.1
	throw_range = 28
	glide_size = 2
	flags_1 = CONDUCT_1
	max_amount = 60
	turf_type = /turf/open/floor/sepia


/obj/item/areaeditor/blueprints/slime
	name = "лазурные отпечатки"
	desc = ""
	color = "#2956B2"

/obj/item/areaeditor/blueprints/slime/edit_area()
	..()
	var/area/A = get_area(src)
	for(var/turf/T in A)
		T.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		T.add_atom_colour("#2956B2", FIXED_COLOUR_PRIORITY)
	A.xenobiology_compatible = TRUE
	qdel(src)
