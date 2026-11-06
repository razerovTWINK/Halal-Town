
/mob/living/carbon/human/proc/choose_name_popup(input)
	if(QDELETED(src))
		return
	var/old_name = real_name
	if(!stat)
		if(job)
			var/datum/job/j = SSjob.GetJob(job)
			j.current_positions--
		mob_timers["mirrortime"] = world.time
		var/begin_time = world.time
		var/new_name = input(src, "Каким будет твоё имя ([input])?", "РОУГТАУН")
		if(world.time > begin_time + 60 SECONDS)
			to_chat(src, "<font color='red'>Ты ждал слишком долго.</font>")
			return
		new_name = reject_bad_name(new_name)
		if(new_name)
			if(new_name in GLOB.chosen_names)
				to_chat(src, "<font color='red'>Это имя уже занято.</font>")
				return
			else
				real_name = new_name
		else
			to_chat(src, "<font color='red'>Недопустимое имя. Имя должно содержать от 2 до [MAX_NAME_LEN] символов и может состоять только из букв A-Z, a-z, -, ' и .</font>")
			return
	GLOB.chosen_names += real_name
	if(mind.special_role == "Vampire Lord")
		if(gender == FEMALE)
			real_name = "Lady [real_name]"
		if(gender == MALE)
			real_name = "Lord [real_name]"
	mind.name = real_name
	var/fakekey = ckey
	if(ckey in GLOB.anonymize)
		fakekey = get_fake_key(ckey)
	GLOB.character_list[mobid] = "[fakekey] was [real_name] ([input])<BR>"
	if(GLOB.character_ckey_list[old_name])
		GLOB.character_ckey_list -= old_name
	GLOB.character_ckey_list[real_name] = ckey
	log_character("[ckey] - [real_name] - [input]")
	log_manifest(ckey,mind,src,latejoin = TRUE)
