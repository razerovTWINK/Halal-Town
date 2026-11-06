// 7.62x38mmR (Nagant Revolver)

/obj/projectile/bullet/n762
	name = "пуля 7.62x38ммR"
	damage = 60

// .50AE (Desert Eagle)

/obj/projectile/bullet/a50AE
	name = "пуля .50AE"
	damage = 60

// .38 (Detective's Gun)

/obj/projectile/bullet/c38
	name = "пуля .38"
	damage = 25

/obj/projectile/bullet/c38/trac
	name = "пуля .38 TRAC"
	damage = 10

/obj/projectile/bullet/c38/trac/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/M = target
	var/obj/item/implant/tracking/c38/imp
	for(var/obj/item/implant/tracking/c38/TI in M.implants) //checks if the target already contains a tracking implant
		imp = TI
		return
	if(!imp)
		imp = new /obj/item/implant/tracking/c38(M)
		imp.implant(M)

/obj/projectile/bullet/c38/hotshot //similar to incendiary bullets, but do not leave a flaming trail
	name = "пуля .38 Hot Shot"
	damage = 20

/obj/projectile/bullet/c38/hotshot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(6)
		M.IgniteMob()

/obj/projectile/bullet/c38/iceblox //see /obj/projectile/temp for the original code
	name = "пуля .38 Iceblox"
	damage = 20
	var/temperature = 100

/obj/projectile/bullet/c38/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

// .357 (Syndie Revolver)

/obj/projectile/bullet/a357
	name = "пуля .357"
	damage = 60
