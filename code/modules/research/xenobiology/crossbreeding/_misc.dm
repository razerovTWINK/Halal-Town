/*
Slimecrossing Items
	General items added by the slimecrossing system.
	Collected here for clarity.
*/

//Rewind camera - I'm already Burning Sepia
/obj/item/camera/rewind
	name = "сепия-камера"
	desc = ""
	pictures_left = 1
	pictures_max = 1
	can_customise = FALSE
	default_picture_name = "Ностальгический снимок"
	var/used = FALSE

/datum/saved_bodypart
	var/obj/item/bodypart/old_part
	var/bodypart_type
	var/brute_dam
	var/burn_dam
	var/stamina_dam

/datum/saved_bodypart/New(obj/item/bodypart/part)
	old_part = part
	bodypart_type = part.type
	brute_dam = part.brute_dam
	burn_dam = part.burn_dam
	stamina_dam = part.stamina_dam

/mob/living/carbon/proc/apply_saved_bodyparts(list/datum/saved_bodypart/parts)
	var/list/dont_chop = list()
	for(var/zone in parts)
		var/datum/saved_bodypart/saved_part = parts[zone]
		var/obj/item/bodypart/already = get_bodypart(zone)
		if(QDELETED(saved_part.old_part))
			saved_part.old_part = new saved_part.bodypart_type
		if(!already || already != saved_part.old_part)
			saved_part.old_part.replace_limb(src, TRUE)
		saved_part.old_part.heal_damage(INFINITY, INFINITY, INFINITY, null, FALSE)
		saved_part.old_part.receive_damage(saved_part.brute_dam, saved_part.burn_dam, saved_part.stamina_dam)
		dont_chop[zone] = TRUE
	for(var/_part in bodyparts)
		var/obj/item/bodypart/part = _part
		if(dont_chop[part.body_zone])
			continue
		part.drop_limb(TRUE)

/mob/living/carbon/proc/save_bodyparts()
	var/list/datum/saved_bodypart/ret = list()
	for(var/_part in bodyparts)
		var/obj/item/bodypart/part = _part
		var/datum/saved_bodypart/saved_part = new(part)

		ret[part.body_zone] = saved_part
	return ret

/obj/item/camera/rewind/afterattack(atom/target, mob/user, flag)
	if(!on || !pictures_left || !isturf(target.loc))
		return
	if(!used)//selfie time
		if(user == target)
			to_chat(user, "<span class=notice>Я делаю селфи!</span>")
		else
			to_chat(user, "<span class=notice>Я фотографируюсь с [target]!</span>")
			to_chat(target, "<span class=notice>[user] фотографируется с тобой!</span>")
		to_chat(target, "<span class=notice>Этот момент запомнится навсегда!</span>")

		used = TRUE
		target.AddComponent(/datum/component/dejavu, 2)
	.=..()



//Timefreeze camera - Old Burning Sepia result. Kept in case admins want to spawn it
/obj/item/camera/timefreeze
	name = "сепия-камера"
	desc = ""
	pictures_left = 1
	pictures_max = 1
	var/used = FALSE

/obj/item/camera/timefreeze/afterattack(atom/target, mob/user, flag)
	if(!on || !pictures_left || !isturf(target.loc))
		return
	if(!used) //refilling the film does not refill the timestop
		new /obj/effect/timestop(get_turf(target), 2, 50, list(user))
		used = TRUE
		desc = ""
	. = ..()


//Hypercharged slime cell - Charged Yellow
/obj/item/stock_parts/cell/high/slime/hypercharged
	name = "сверхзаряженное ядро слайма"
	desc = ""
	rating = 7 //Roughly 1.5 times the original.
	maxcharge = 20000 //2 times the normal one.
	chargerate = 2250 //1.5 times the normal rate.

//Barrier cube - Chilling Grey
/obj/item/barriercube
	name = "барьерный куб"
	desc = ""
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "barriercube"
	w_class = WEIGHT_CLASS_TINY

/obj/item/barriercube/attack_self(mob/user)
	if(locate(/obj/structure/barricade/slime) in get_turf(loc))
		to_chat(user, "<span class='warning'>Нельзя поставить больше одного барьера на одну клетку!</span>")
		return
	to_chat(user, "<span class='notice'>Я сжимаю [src].</span>")
	var/obj/B = new /obj/structure/barricade/slime(get_turf(loc))
	B.visible_message("<span class='warning'>[src] внезапно разрастается в огромный желатиновый барьер!</span>")
	qdel(src)

//Slime barricade - Chilling Grey
/obj/structure/barricade/slime
	name = "желатиновый барьер"
	desc = ""
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "slimebarrier"
	proj_pass_rate = 40
	max_integrity = 60

//Melting Gel Wall - Chilling Metal
/obj/effect/forcefield/slimewall
	name = "затвердевший гель"
	desc = ""
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "slimebarrier_thick"
	CanAtmosPass = ATMOS_PASS_NO
	opacity = TRUE
	timeleft = 100

//Rainbow barrier - Chilling Rainbow
/obj/effect/forcefield/slimewall/rainbow
	name = "радужный барьер"
	desc = ""
	icon_state = "rainbowbarrier"

//Ration pack - Chilling Silver
/obj/item/reagent_containers/food/snacks/rationpack
	name = "сухой паёк"
	desc = ""
	icon_state = "rationpack"
	bitesize = 3
	junkiness = 15
	filling_color = "#964B00"
	tastes = list("картон" = 3, "грусть" = 3)
	foodtype = null //Don't ask what went into them. You're better off not knowing.
	list_reagents = list(/datum/reagent/consumable/nutriment/stabilized = 10, /datum/reagent/consumable/nutriment = 2) //Won't make you fat. Will make you question your sanity.

/obj/item/reagent_containers/food/snacks/rationpack/checkLiked(fraction, mob/M)	//Nobody likes rationpacks. Nobody.
	if(last_check_time + 50 < world.time)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.mind && !HAS_TRAIT(H, TRAIT_AGEUSIA))
				to_chat(H, "<span class='notice'>Вкус так себе...</span>") //No disgust, though. It's just not good tasting.
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "gross_food", /datum/mood_event/gross_food)
				last_check_time = world.time
				return
	..()

//Ice stasis block - Chilling Dark Blue
/obj/structure/ice_stasis
	name = "ледяная глыба"
	desc = ""
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "frozen"
	density = TRUE
	max_integrity = 100
	armor = list("melee" = 30, "bullet" = 50, "laser" = -50, "energy" = -50, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = -80, "acid" = 30)

/obj/structure/ice_stasis/Initialize()
	. = ..()
	playsound(src, 'sound/blank.ogg', 50, TRUE)

/obj/structure/ice_stasis/Destroy()
	for(var/atom/movable/M in contents)
		M.forceMove(loc)
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	return ..()

//Gold capture device - Chilling Gold
/obj/item/capturedevice
	name = "золотая ловушка"
	desc = ""
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "capturedevice"

/obj/item/capturedevice/attack(mob/living/M, mob/user)
	if(length(contents))
		to_chat(user, "<span class='warning'>В устройстве уже кто-то есть.</span>")
		return
	if(!isanimal(M))
		to_chat(user, "<span class='warning'>Ловушка работает только на простых существ.</span>")
		return
	if(M.mind)
		to_chat(user, "<span class='notice'>Я протягиваю устройство [M].</span>")
		if(alert(M, "Хочешь ли ты войти в ловушку [user]?", "Золотая ловушка", "Да", "Нет") == "Да")
			if(user.canUseTopic(src, BE_CLOSE) && user.canUseTopic(M, BE_CLOSE))
				to_chat(user, "<span class='notice'>Я помещаю [M] в ловушку.</span>")
				to_chat(M, "<span class='notice'>Мир вокруг искажается, и ты оказываешься в бесконечной пустоте, перед которой парит окно во внешний мир.</span>")
				store(M, user)
			else
				to_chat(user, "<span class='warning'>Я слишком далеко от [M].</span>")
				to_chat(M, "<span class='warning'>Я слишком далеко от [user].</span>")
		else
			to_chat(user, "<span class='warning'>[M] отказывается входить в устройство.</span>")
			return
	else
		if(istype(M, /mob/living/simple_animal/hostile) && !("neutral" in M.faction))
			to_chat(user, "<span class='warning'>Это существо слишком агрессивно для поимки.</span>")
			return
	to_chat(user, "<span class='notice'>Я помещаю [M] в ловушку.</span>")
	store(M)

/obj/item/capturedevice/attack_self(mob/user)
	if(contents.len)
		to_chat(user, "<span class='notice'>Я открываю ловушку!</span>")
		release()
	else
		to_chat(user, "<span class='warning'>Устройство пусто...</span>")

/obj/item/capturedevice/proc/store(var/mob/living/M)
	M.forceMove(src)

/obj/item/capturedevice/proc/release()
	for(var/atom/movable/M in contents)
		M.forceMove(get_turf(loc))
