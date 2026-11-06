
/datum/surgery/amputation
	name = "ампутация"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/saw, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/sever_limb)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD)
	requires_bodypart_type = 0


/datum/surgery_step/sever_limb
	name = "отсечь конечность"
	implements = list(TOOL_SCALPEL = 100, TOOL_SAW = 100, /obj/item/melee/arm_blade = 80, /obj/item/twohanded/fireaxe = 50, /obj/item/hatchet = 40, /obj/item/kitchen/knife/butcher = 25)
	time = 64

/datum/surgery_step/sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь отсекать [parse_zone(target_zone)] [target]...</span>",
		"<span class='notice'>[user] начинает отсекать [parse_zone(target_zone)] [target]!</span>",
		"<span class='notice'>[user] начинает отсекать [parse_zone(target_zone)] [target]!</span>")

/datum/surgery_step/sever_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/mob/living/carbon/human/L = target
	display_results(user, target, "<span class='notice'>Ты отсекаешь [parse_zone(target_zone)] [L].</span>",
		"<span class='notice'>[user] отсекает [parse_zone(target_zone)] [L]!</span>",
		"<span class='notice'>[user] отсекает [parse_zone(target_zone)] [L]!</span>")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()

	return 1
