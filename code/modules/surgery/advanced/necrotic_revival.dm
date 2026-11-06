/datum/surgery/advanced/necrotic_revival
	name = "Некротическое оживление"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/saw,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/bionecrosis,
				/datum/surgery_step/close)

	possible_locs = list(BODY_ZONE_HEAD)

/datum/surgery/advanced/necrotic_revival/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	var/obj/item/organ/zombie_infection/ZI = target.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(ZI)
		return FALSE

/datum/surgery_step/bionecrosis
	name = "запустить бионекроз"
	implements = list(/obj/item/reagent_containers/syringe = 100, /obj/item/pen = 30)
	time = 50
	chems_needed = list(/datum/reagent/toxin/zombiepowder, /datum/reagent/medicine/rezadone)
	require_all_chems = FALSE

/datum/surgery_step/bionecrosis/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь выращивать ромероловую опухоль на мозгу [target]...</span>",
		"<span class='notice'>[user] копошится в мозгу [target]...</span>",
		"<span class='notice'>[user] начинает операцию на мозгу [target].</span>")

/datum/surgery_step/bionecrosis/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Тебе удаётся вырастить ромероловую опухоль на мозгу [target].</span>",
		"<span class='notice'>[user] успешно выращивает ромероловую опухоль на мозгу [target]!</span>",
		"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
	if(!target.getorganslot(ORGAN_SLOT_ZOMBIE))
		var/obj/item/organ/zombie_infection/ZI = new()
		ZI.Insert(target)
	return TRUE
