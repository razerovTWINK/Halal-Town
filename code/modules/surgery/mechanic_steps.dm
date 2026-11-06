//open shell
/datum/surgery_step/mechanic_open
	name = "открутить обшивку"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 			= 75, // med borgs could try to unskrew shell with scalpel
		/obj/item/kitchen/knife	= 50,
		/obj/item				= 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь откручивать обшивку на [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает откручивать обшивку на [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает откручивать обшивку на [parse_zone(target_zone)] [target].</span>")

/datum/surgery_step/mechanic_incise/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE

	return TRUE

//close shell
/datum/surgery_step/mechanic_close
	name = "прикрутить обшивку"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 			= 75,
		/obj/item/kitchen/knife	= 50,
		/obj/item				= 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь прикручивать обшивку на [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает прикручивать обшивку на [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает прикручивать обшивку на [parse_zone(target_zone)] [target].</span>")

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE

	return TRUE

//prepare electronics
/datum/surgery_step/prepare_electronics
	name = "подготовить электронику"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 10) // try to reboot internal controllers via short circuit with some conductor
	time = 24

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь подготавливать электронику в [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает подготавливать электронику в [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает подготавливать электронику в [parse_zone(target_zone)] [target].</span>")

//unwrench
/datum/surgery_step/mechanic_unwrench
	name = "отвинтить болты"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 24

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь отвинчивать болты на [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает отвинчивать болты на [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает отвинчивать болты на [parse_zone(target_zone)] [target].</span>")

//wrench
/datum/surgery_step/mechanic_wrench
	name = "завинтить болты"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 24

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь завинчивать болты на [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает завинчивать болты на [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает завинчивать болты на [parse_zone(target_zone)] [target].</span>")

//open hatch
/datum/surgery_step/open_hatch
	name = "открыть сервисный люк"
	accept_hand = 1
	time = 10

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь открывать фиксаторы люка на [parse_zone(target_zone)] [target]...</span>",
		"<span class='notice'>[user] начинает открывать фиксаторы люка на [parse_zone(target_zone)] [target].</span>",
		"<span class='notice'>[user] начинает открывать фиксаторы люка на [parse_zone(target_zone)] [target].</span>")
