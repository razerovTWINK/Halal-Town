/datum/surgery/healing
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/incise,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/heal,
				/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = FALSE
	replaced_by = /datum/surgery
	ignore_clothes = TRUE
	var/healing_step_type
	var/antispam = FALSE

/datum/surgery/healing/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(/datum/surgery_step/incise/nobleed,
					healing_step_type, //hehe cheeky
					/datum/surgery_step/close)

/datum/surgery_step/heal
	name = "залечить раны"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_SCREWDRIVER = 65, /obj/item/pen = 55)
	repeatable = TRUE
	time = 25
	var/brutehealing = 0
	var/burnhealing = 0
	var/missinghpbonus = 0 //heals an extra point of damager per X missing damage of type (burn damage for burn healing, brute for brute). Smaller Number = More Healing!

/datum/surgery_step/heal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/woundtype
	if(brutehealing && burnhealing)
		woundtype = "раны"
	else if(brutehealing)
		woundtype = "ушибы"
	else //why are you trying to 0,0...?
		woundtype = "ожоги"
	if(istype(surgery,/datum/surgery/healing))
		var/datum/surgery/healing/the_surgery = surgery
		if(!the_surgery.antispam)
			display_results(user, target, "<span class='notice'>Ты пытаешься залечить часть повреждений ([woundtype]) у [target].</span>",
		"<span class='notice'>[user] пытается залечить часть повреждений ([woundtype]) у [target].</span>",
		"<span class='notice'>[user] пытается залечить часть повреждений ([woundtype]) у [target].</span>")

/datum/surgery_step/heal/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(..())
		while((brutehealing && target.getBruteLoss()) || (burnhealing && target.getFireLoss()))
			if(!..())
				break

/datum/surgery_step/heal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/umsg = "Ты успешно залечиваешь часть ран [target]" //no period, add initial space to "addons"
	var/tmsg = "[user] залечивает часть ран [target]" //see above
	var/urhealedamt_brute = brutehealing
	var/urhealedamt_burn = burnhealing
	if(missinghpbonus)
		if(target.stat != DEAD)
			urhealedamt_brute += round((target.getBruteLoss()/ missinghpbonus),0.1)
			urhealedamt_burn += round((target.getFireLoss()/ missinghpbonus),0.1)
		else //less healing bonus for the dead since they're expected to have lots of damage to begin with (to make TW into defib not TOO simple)
			urhealedamt_brute += round((target.getBruteLoss()/ (missinghpbonus*5)),0.1)
			urhealedamt_burn += round((target.getFireLoss()/ (missinghpbonus*5)),0.1)
	if(!get_location_accessible(target, target_zone))
		urhealedamt_brute *= 0.55
		urhealedamt_burn *= 0.55
		umsg += ", настолько хорошо, насколько позволяет одежда"
		tmsg += ", настолько хорошо, насколько позволяет одежда"
	target.heal_bodypart_damage(urhealedamt_brute,urhealedamt_burn)
	display_results(user, target, "<span class='notice'>[umsg].</span>",
		"[tmsg].",
		"[tmsg].")
	if(istype(surgery, /datum/surgery/healing))
		var/datum/surgery/healing/the_surgery = surgery
		the_surgery.antispam = TRUE
	return TRUE

/datum/surgery_step/heal/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>Ты совершаешь ошибку!</span>",
		"<span class='warning'>[user] совершает ошибку!</span>",
		"<span class='notice'>[user] залечивает часть ран [target].</span>", TRUE)
	var/urdamageamt_burn = brutehealing * 0.8
	var/urdamageamt_brute = burnhealing * 0.8
	if(missinghpbonus)
		urdamageamt_brute += round((target.getBruteLoss()/ (missinghpbonus*2)),0.1)
		urdamageamt_burn += round((target.getFireLoss()/ (missinghpbonus*2)),0.1)

	target.take_bodypart_damage(urdamageamt_brute, urdamageamt_burn)
	return FALSE

/***************************BRUTE***************************/
/datum/surgery/healing/brute
	name = "Перевязка ран (ушибы)"

/datum/surgery/healing/brute/basic
	name = "Перевязка ран (ушибы, базовая)"
	replaced_by = /datum/surgery/healing/brute/upgraded
	healing_step_type = /datum/surgery_step/heal/brute/basic
	desc = ""

/datum/surgery/healing/brute/upgraded
	name = "Перевязка ран (ушибы, улучш.)"
	replaced_by = /datum/surgery/healing/brute/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal/brute/upgraded
	desc = ""

/datum/surgery/healing/brute/upgraded/femto
	name = "Перевязка ран (ушибы, эксп.)"
	replaced_by = /datum/surgery/healing/combo/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal/brute/upgraded/femto
	desc = ""

/********************BRUTE STEPS********************/
/datum/surgery_step/heal/brute/basic
	name = "лечить ушибы"
	brutehealing = 5
	missinghpbonus = 15

/datum/surgery_step/heal/brute/upgraded
	brutehealing = 5
	missinghpbonus = 10

/datum/surgery_step/heal/brute/upgraded/femto
	brutehealing = 5
	missinghpbonus = 5

/***************************BURN***************************/
/datum/surgery/healing/burn
	name = "Перевязка ран (ожоги)"

/datum/surgery/healing/burn/basic
	name = "Перевязка ран (ожоги, базовая)"
	replaced_by = /datum/surgery/healing/burn/upgraded
	healing_step_type = /datum/surgery_step/heal/burn/basic
	desc = ""

/datum/surgery/healing/burn/upgraded
	name = "Перевязка ран (ожоги, улучш.)"
	replaced_by = /datum/surgery/healing/burn/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal/burn/upgraded
	desc = ""

/datum/surgery/healing/burn/upgraded/femto
	name = "Перевязка ран (ожоги, эксп.)"
	replaced_by = /datum/surgery/healing/combo/upgraded/femto
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal/burn/upgraded/femto
	desc = ""

/********************BURN STEPS********************/
/datum/surgery_step/heal/burn/basic
	name = "лечить ожоги"
	burnhealing = 5
	missinghpbonus = 15

/datum/surgery_step/heal/burn/upgraded
	burnhealing = 5
	missinghpbonus = 10

/datum/surgery_step/heal/burn/upgraded/femto
	burnhealing = 5
	missinghpbonus = 5

/***************************COMBO***************************/
/datum/surgery/healing/combo


/datum/surgery/healing/combo
	name = "Перевязка ран (смешанные, базовая)"
	replaced_by = /datum/surgery/healing/combo/upgraded
	requires_tech = TRUE
	healing_step_type = /datum/surgery_step/heal/combo
	desc = ""

/datum/surgery/healing/combo/upgraded
	name = "Перевязка ран (смешанные, улучш.)"
	replaced_by = /datum/surgery/healing/combo/upgraded/femto
	healing_step_type = /datum/surgery_step/heal/combo/upgraded
	desc = ""


/datum/surgery/healing/combo/upgraded/femto //no real reason to type it like this except consistency, don't worry you're not missing anything
	name = "Перевязка ран (смешанные, эксп.)"
	replaced_by = null
	healing_step_type = /datum/surgery_step/heal/combo/upgraded/femto
	desc = ""

/********************COMBO STEPS********************/
/datum/surgery_step/heal/combo
	name = "лечить телесные раны"
	brutehealing = 3
	burnhealing = 3
	missinghpbonus = 15
	time = 10

/datum/surgery_step/heal/combo/upgraded
	brutehealing = 3
	burnhealing = 3
	missinghpbonus = 10

/datum/surgery_step/heal/combo/upgraded/femto
	brutehealing = 1
	burnhealing = 1
	missinghpbonus = 2.5

/datum/surgery_step/heal/combo/upgraded/femto/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>I screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s wounds.</span>", TRUE)
	target.take_bodypart_damage(5,5)
