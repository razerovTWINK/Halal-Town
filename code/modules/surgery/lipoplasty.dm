/datum/surgery/lipoplasty
	name = "удаление жира"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/cut_fat, /datum/surgery_step/remove_fat, /datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery/lipoplasty/can_start(mob/user, mob/living/carbon/target)
	if(HAS_TRAIT(target, TRAIT_FAT))
		return 1
	return 0


//cut fat
/datum/surgery_step/cut_fat
	name = "иссечь лишний жир"
	implements = list(TOOL_SAW = 100, /obj/item/hatchet = 35, /obj/item/kitchen/knife/butcher = 25)
	time = 64

/datum/surgery_step/cut_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] начинает срезать лишний жир [target].</span>", "<span class='notice'>Ты начинаешь срезать лишний жир [target]...</span>")
	display_results(user, target, "<span class='notice'>Ты начинаешь срезать лишний жир [target]...</span>",
			"<span class='notice'>[user] начинает срезать лишний жир [target].</span>",
			"<span class='notice'>[user] делает разрез на [target_zone] [target] с помощью [tool].</span>")

/datum/surgery_step/cut_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты отделяешь лишний жир [target].</span>",
			"<span class='notice'>[user] отделяет лишний жир [target]!</span>",
			"<span class='notice'>[user] завершает разрез на [target_zone] [target].</span>")
	return 1

//remove fat
/datum/surgery_step/remove_fat
	name = "извлечь отделённый жир"
	implements = list(TOOL_RETRACTOR = 100, TOOL_SCREWDRIVER = 45, TOOL_WIRECUTTER = 35)
	time = 32

/datum/surgery_step/remove_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь извлекать отделённый жир [target]...</span>",
			"<span class='notice'>[user] начинает извлекать отделённый жир [target]!</span>",
			"<span class='notice'>[user] начинает что-то извлекать из [target_zone] [target].</span>")

/datum/surgery_step/remove_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты извлекаешь жир [target].</span>",
			"<span class='notice'>[user] извлекает жир [target]!</span>",
			"<span class='notice'>[user] извлекает жир [target]!</span>")
	target.overeatduration = 0 //patient is unfatted
	var/removednutriment = target.nutrition
	target.set_nutrition(NUTRITION_LEVEL_WELL_FED)
	removednutriment -= 450 //whatever was removed goes into the meat
	var/mob/living/carbon/human/H = target
	var/typeofmeat = /obj/item/reagent_containers/food/snacks/meat/slab/human

	if(H.dna && H.dna.species)
		typeofmeat = H.dna.species.meat

	var/obj/item/reagent_containers/food/snacks/meat/slab/human/newmeat = new typeofmeat
	newmeat.name = "жирное мясо"
	newmeat.desc = ""
	newmeat.subjectname = H.real_name
	newmeat.subjectjob = H.job
	newmeat.reagents.add_reagent (/datum/reagent/consumable/nutriment, (removednutriment / 15)) //To balance with nutriment_factor of nutriment
	newmeat.forceMove(target.loc)
	return 1
