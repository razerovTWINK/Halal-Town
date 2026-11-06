
/////AUGMENTATION SURGERIES//////


//SURGERY STEPS

/datum/surgery_step/replace
	name = "пересечь мышцы"
	implements = list(TOOL_SCALPEL = 100, TOOL_WIRECUTTER = 55)
	time = 32


/datum/surgery_step/replace/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь пересекать мышцы на [parse_zone(user.zone_selected)] [target]...</span>",
		"<span class='notice'>[user] начинает пересекать мышцы на [parse_zone(user.zone_selected)] [target].</span>",
		"<span class='notice'>[user] делает разрез на [parse_zone(user.zone_selected)] [target].</span>")

/datum/surgery_step/replace_limb
	name = "заменить конечность"
	implements = list(/obj/item/bodypart = 100, /obj/item/organ_storage = 100)
	time = 32
	var/obj/item/bodypart/L = null // L because "limb"


/datum/surgery_step/replace_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/organ_storage) && istype(tool.contents[1], /obj/item/bodypart))
		tool = tool.contents[1]
	var/obj/item/bodypart/aug = tool
	if(aug.status != BODYPART_ROBOTIC)
		to_chat(user, "<span class='warning'>Это не аугмент!</span>")
		return -1
	if(aug.body_zone != target_zone)
		to_chat(user, "<span class='warning'>[tool] не подходит для [parse_zone(target_zone)].</span>")
		return -1
	L = surgery.operated_bodypart
	if(L)
		display_results(user, target, "<span class='notice'>Ты начинаешь устанавливать аугмент на [parse_zone(user.zone_selected)] [target]...</span>",
			"<span class='notice'>[user] начинает устанавливать [aug] на [parse_zone(user.zone_selected)] [target].</span>",
			"<span class='notice'>[user] начинает устанавливать аугмент на [parse_zone(user.zone_selected)] [target].</span>")
	else
		user.visible_message("<span class='notice'>[user] осматривает [parse_zone(user.zone_selected)] [target].</span>", "<span class='notice'>Ты осматриваешь [parse_zone(user.zone_selected)] [target]...</span>")


//ACTUAL SURGERIES

/datum/surgery/augmentation
	name = "аугментация"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/replace, /datum/surgery_step/saw, /datum/surgery_step/replace_limb)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM,BODY_ZONE_R_LEG,BODY_ZONE_L_LEG,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	requires_real_bodypart = TRUE

//SURGERY STEP SUCCESSES

/datum/surgery_step/replace_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/bodypart/tool, datum/surgery/surgery)
	if(L)
		if(istype(tool, /obj/item/organ_storage))
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = tool.contents[1]
		if(istype(tool) && user.temporarilyRemoveItemFromInventory(tool))
			tool.replace_limb(target, TRUE)
		display_results(user, target, "<span class='notice'>Ты успешно завершаешь установку аугмента на [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] успешно устанавливает [tool] на [parse_zone(target_zone)] [target]!</span>",
			"<span class='notice'>[user] успешно завершает установку аугмента на [parse_zone(target_zone)] [target]!</span>")
		log_combat(user, target, "augmented", addition="by giving him new [parse_zone(target_zone)] INTENT: [uppertext(user.a_intent)]")
	else
		to_chat(user, "<span class='warning'>У [target] там нет живой конечности ([parse_zone(target_zone)])!</span>")
	return TRUE
