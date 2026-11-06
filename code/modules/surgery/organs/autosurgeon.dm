#define INFINITE -1

/obj/item/autosurgeon
	name = "автохирург"
	desc = ""
	icon = 'icons/obj/device.dmi'
	icon_state = "autoimplanter"
	item_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/organ/storedorgan
	var/organ_type = /obj/item/organ
	var/uses = INFINITE
	var/starting_organ

/obj/item/autosurgeon/Initialize(mapload)
	. = ..()
	if(starting_organ)
		insert_organ(new starting_organ(src))

/obj/item/autosurgeon/proc/insert_organ(var/obj/item/I)
	storedorgan = I
	I.forceMove(src)
	name = "[initial(name)] ([storedorgan.name])"

/obj/item/autosurgeon/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, "<span class='alert'>[src] уже был использован. Инструменты затупились и больше не активируются.</span>")
		return
	else if(!storedorgan)
		to_chat(user, "<span class='alert'>В [src] сейчас нет импланта.</span>")
		return
	storedorgan.Insert(user)//insert stored organ into the user
	user.visible_message("<span class='notice'>[user] нажимает кнопку на [src], раздаётся короткий механический щелчок.</span>", "<span class='notice'>Ты чувствуешь резкий укол, когда [src] вонзается в тело.</span>")
	playsound(get_turf(user), 'sound/blank.ogg', 50, TRUE)
	storedorgan = null
	name = initial(name)
	if(uses != INFINITE)
		uses--
	if(!uses)
		desc = ""

/obj/item/autosurgeon/attack_self_tk(mob/user)
	return //stops TK fuckery

/obj/item/autosurgeon/attackby(obj/item/I, mob/user, params)
	if(istype(I, organ_type))
		if(storedorgan)
			to_chat(user, "<span class='alert'>В [src] уже есть имплант.</span>")
			return
		else if(!uses)
			to_chat(user, "<span class='alert'>[src] уже израсходован.</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		storedorgan = I
		to_chat(user, "<span class='notice'>Ты вставляешь [I] в [src].</span>")
	else
		return ..()

/obj/item/autosurgeon/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(!storedorgan)
		to_chat(user, "<span class='warning'>В [src] нет импланта для извлечения!</span>")
	else
		var/atom/drop_loc = user.drop_location()
		for(var/J in src)
			var/atom/movable/AM = J
			AM.forceMove(drop_loc)

		to_chat(user, "<span class='notice'>Ты извлекаешь [storedorgan] из [src].</span>")
		I.play_tool_sound(src)
		storedorgan = null
		if(uses != INFINITE)
			uses--
		if(!uses)
			desc = ""
	return TRUE

/obj/item/autosurgeon/cmo
	desc = ""
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/medical


/obj/item/autosurgeon/thermal_eyes
	starting_organ = /obj/item/organ/eyes/robotic/thermals

/obj/item/autosurgeon/xray_eyes
	starting_organ = /obj/item/organ/eyes/robotic/xray

/obj/item/autosurgeon/anti_stun
	starting_organ = /obj/item/organ/cyberimp/brain/anti_stun

/obj/item/autosurgeon/reviver
	starting_organ = /obj/item/organ/cyberimp/chest/reviver
