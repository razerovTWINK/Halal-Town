/datum/surgery/dental_implant
	name = "зубной имплант"
	steps = list(/datum/surgery_step/drill, /datum/surgery_step/insert_pill)
	possible_locs = list(BODY_ZONE_PRECISE_MOUTH)

/datum/surgery_step/insert_pill
	name = "вставить таблетку"
	implements = list(/obj/item/reagent_containers/pill = 100)
	time = 16

/datum/surgery_step/insert_pill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь закреплять [tool] в [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает закреплять [tool] в [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает что-то закреплять в [parse_zone(target_zone)] [target].</span>")

/datum/surgery_step/insert_pill/success(mob/user, mob/living/carbon/target, target_zone, obj/item/reagent_containers/pill/tool, datum/surgery/surgery)
	if(!istype(tool))
		return 0

	user.transferItemToLoc(tool, target, TRUE)

	var/datum/action/item_action/hands_free/activate_pill/P = new(tool)
	P.button.name = "Проглотить [tool.name]"
	P.target = tool
	P.Grant(target)	//The pill never actually goes in an inventory slot, so the owner doesn't inherit actions from it

	display_results(user, target, "<span class='notice'>Ты закрепляешь [tool] в [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] закрепляет [tool] в [parse_zone(target_zone)] [target]!</span>",
			"<span class='notice'>[user] закрепляет что-то в [parse_zone(target_zone)] [target]!</span>")
	return 1

/datum/action/item_action/hands_free/activate_pill
	name = "Раскусить капсулу"

/datum/action/item_action/hands_free/activate_pill/Trigger()
	if(!..())
		return FALSE
	to_chat(owner, "<span class='notice'>Ты стискиваешь зубы и раскусываешь вживлённую капсулу ([target.name])!</span>")
	log_combat(owner, null, "swallowed an implanted pill", target)
	if(target.reagents.total_volume)
		target.reagents.reaction(owner, INGEST)
		target.reagents.trans_to(owner, target.reagents.total_volume, transfered_by = owner)
	qdel(target)
	return TRUE
