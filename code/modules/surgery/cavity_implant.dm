/datum/surgery/cavity_implant
	name = "вживление в полость"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/incise, /datum/surgery_step/handle_cavity, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)


//handle cavity
/datum/surgery_step/handle_cavity
	name = "вживить предмет"
	accept_hand = 1
	implements = list(/obj/item = 100)
	repeatable = TRUE
	time = 32
	var/obj/item/IC = null

/datum/surgery_step/handle_cavity/tool_check(mob/user, obj/item/tool)
	if(tool.tool_behaviour == TOOL_CAUTERY || istype(tool, /obj/item/gun/energy/laser))
		return FALSE
	return !tool.get_temperature()

/datum/surgery_step/handle_cavity/preop(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/chest/CH = target.get_bodypart(BODY_ZONE_CHEST)
	IC = CH.cavity_item
	if(tool)
		display_results(user, target, "<span class='notice'>Ты начинаешь помещать [tool] в [target_zone] [target]...</span>",
			"<span class='notice'>[user] начинает помещать [tool] в [target_zone] [target].</span>",
			"<span class='notice'>[user] начинает помещать [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "что-то"] в [target_zone] [target].</span>")
	else
		display_results(user, target, "<span class='notice'>Ты осматриваешь [target_zone] [target] на наличие предметов...</span>",
			"<span class='notice'>[user] осматривает [target_zone] [target] на наличие предметов.</span>",
			"<span class='notice'>[user] ищет что-то в [target_zone] [target].</span>")

/datum/surgery_step/handle_cavity/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/chest/CH = target.get_bodypart(BODY_ZONE_CHEST)
	if(tool)
		if(IC || tool.w_class > WEIGHT_CLASS_NORMAL || HAS_TRAIT(tool, TRAIT_NODROP) || istype(tool, /obj/item/organ))
			to_chat(user, "<span class='warning'>Не удаётся уместить [tool] в [target_zone] [target]!</span>")
			return 0
		else
			display_results(user, target, "<span class='notice'>Ты заталкиваешь [tool] в [target_zone] [target].</span>",
				"<span class='notice'>[user] заталкивает [tool] в [target_zone] [target]!</span>",
				"<span class='notice'>[user] заталкивает [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "что-то"] в [target_zone] [target].</span>")
			user.transferItemToLoc(tool, target, TRUE)
			CH.cavity_item = tool
			return 1
	else
		if(IC)
			display_results(user, target, "<span class='notice'>Ты извлекаешь [IC] из [target_zone] [target].</span>",
				"<span class='notice'>[user] извлекает [IC] из [target_zone] [target]!</span>",
				"<span class='notice'>[user] извлекает [IC.w_class > WEIGHT_CLASS_SMALL ? IC : "что-то"] из [target_zone] [target].</span>")
			user.put_in_hands(IC)
			CH.cavity_item = null
			return 1
		else
			to_chat(user, "<span class='warning'>В [target_zone] [target] ничего не обнаружено.</span>")
			return 0
