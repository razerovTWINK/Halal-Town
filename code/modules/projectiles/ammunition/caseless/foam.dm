/obj/item/ammo_casing/caseless/foam_dart
	name = "мягкий дротик"
	desc = ""
	projectile_type = /obj/projectile/bullet/reusable/foam_dart
	caliber = "foam_force"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foamdart"
	custom_materials = list(/datum/material/iron = 11.25)
	harmful = FALSE
	var/modified = FALSE

/obj/item/ammo_casing/caseless/foam_dart/update_icon()
	..()
	if (modified)
		icon_state = "foamdart_empty"
		desc = ""
		if(BB)
			BB.icon_state = "foamdart_empty"
	else
		icon_state = initial(icon_state)
		desc = ""
		if(BB)
			BB.icon_state = initial(BB.icon_state)


/obj/item/ammo_casing/caseless/foam_dart/attackby(obj/item/A, mob/user, params)
	var/obj/projectile/bullet/reusable/foam_dart/FD = BB
	if (A.tool_behaviour == TOOL_SCREWDRIVER && !modified)
		modified = TRUE
		FD.modified = TRUE
		FD.damage_type = BRUTE
		to_chat(user, "<span class='notice'>Ты снимаешь защитный колпачок с [src].</span>")
		update_icon()
	else if (istype(A, /obj/item/pen))
		if(modified)
			if(!FD.pen)
				harmful = TRUE
				if(!user.transferItemToLoc(A, FD))
					return
				FD.pen = A
				FD.damage = 5
				FD.nodamage = FALSE
				to_chat(user, "<span class='notice'>Ты вставляешь [A] в [src].</span>")
			else
				to_chat(user, "<span class='warning'>В [src] уже что-то есть.</span>")
		else
			to_chat(user, "<span class='warning'>Защитный колпачок мешает вставить [A] в [src].</span>")
	else
		return ..()

/obj/item/ammo_casing/caseless/foam_dart/attack_self(mob/living/user)
	var/obj/projectile/bullet/reusable/foam_dart/FD = BB
	if(FD.pen)
		FD.damage = initial(FD.damage)
		FD.nodamage = initial(FD.nodamage)
		user.put_in_hands(FD.pen)
		to_chat(user, "<span class='notice'>Ты вынимаешь [FD.pen] из [src].</span>")
		FD.pen = null

/obj/item/ammo_casing/caseless/foam_dart/riot
	name = "полицейский мягкий дротик"
	desc = ""
	projectile_type = /obj/projectile/bullet/reusable/foam_dart/riot
	icon_state = "foamdart_riot"
	custom_materials = list(/datum/material/iron = 1125)
