
client/
	var/list/hidden_atoms = list()
	var/list/hidden_mobs = list()
	var/list/hidden_images = list()

/mob
	var/fovangle

/mob/living/carbon/human
	fovangle = FOV_DEFAULT

//Procs
/atom/proc/InCone(atom/center = usr, dir = NORTH)
	if(get_dist(center, src) == 0 || src == center) return 0
	var/d = get_dir(center, src)
	if(!d || d == dir) return 1
	if(dir & (dir-1))
		return (d & ~dir) ? 0 : 1
	if(!(d & dir)) return 0
	var/dx = abs(x - center.x)
	var/dy = abs(y - center.y)
	if(dx == dy) return 1
	if(dy > dx)
		return (dir & (NORTH|SOUTH)) ? 1 : 0
	return (dir & (EAST|WEST)) ? 1 : 0

/mob/dead/InCone(mob/center = usr, dir = NORTH)//So ghosts aren't calculated.
	return

/proc/cone(atom/center = usr, dirs, list/list = oview(center))
	for(var/atom/A in list)
		var/fou
		for(var/D in dirs)
			if(A.InCone(center, D))
				fou = TRUE
				break
		if(!fou)
			list -= A
	return list


/mob/dead/BehindAtom(mob/center = usr, dir = NORTH)//So ghosts aren't calculated.
	return

/atom/proc/BehindAtom(atom/center = usr, dir = NORTH)
	switch(dir)
		if(NORTH)
			if(y > center.y)
				return 1
		if(SOUTH)
			if(y < center.y)
				return 1
		if(EAST)
			if(x > center.x)
				return 1
		if(WEST)
			if(x < center.x)
				return 1

/proc/behind(atom/center = usr, dirs, list/list = oview(center))
	for(var/atom/A in list)
		var/fou
		for(var/D in dirs)
			if(A.BehindAtom(center, D))
				fou = TRUE
				break
		if(!fou)
			list -= A
	return list

/mob/proc/update_vision_cone()
	return

/mob/proc/update_cone()
	return

/mob/living/update_vision_cone()
	if(client)
		if(hud_used)
			if(hud_used.fov)
				hud_used.fov.dir = src.dir
			if(hud_used.fov_blocker)
				hud_used.fov_blocker.dir = src.dir
		if(client.hidden_images)
			for(var/image/I in client.hidden_images)
				if(!I)
					continue
				if(I.loc == src)
					I.dir = dir
				else if(buckled && !QDELETED(buckled) && I.loc == buckled)
					I.dir = buckled.dir
				else if(pulling && !QDELETED(pulling) && I.loc == pulling)
					I.dir = pulling.dir
		START_PROCESSING(SSincone, client)

/client/proc/update_cone()
	if(mob)
		mob.update_cone()

/mob/living/update_cone()
	if(!client)
		return

	var/image/img = null
	var/image/IB = null
	var/image/IP = null
	var/list/to_remove = null

	if(client.hidden_images)
		for(var/image/I in client.hidden_images)
			if(!I)
				LAZYADD(to_remove, I)
				continue
			if(I.loc == src)
				if(!img)
					img = I
				else
					LAZYADD(to_remove, I)
			else if(buckled && !QDELETED(buckled) && I.loc == buckled)
				if(!IB)
					IB = I
				else
					LAZYADD(to_remove, I)
			else if(pulling && !QDELETED(pulling) && I.loc == pulling)
				if(!IP)
					IP = I
				else
					LAZYADD(to_remove, I)
			else
				LAZYADD(to_remove, I)

	if(to_remove && client)
		client.images -= to_remove
		client.hidden_images -= to_remove

	if(flags_1 & OVERLAY_QUEUED_1)
		COMPILE_OVERLAYS(src)

	if(!img && client)
		img = image(loc = src)
		client.images += img
		client.hidden_images += img

	if(img)
		img.appearance = src.appearance
		img.plane = GAME_PLANE_UPPER
		img.override = 1
		img.glide_size = glide_size
		img.dir = dir

	if(buckled && !QDELETED(buckled) && client)
		if(buckled.flags_1 & OVERLAY_QUEUED_1)
			COMPILE_OVERLAYS(buckled)
		if(!IB)
			IB = image(loc = buckled)
			client.images += IB
			client.hidden_images += IB
		if(IB)
			IB.appearance = buckled.appearance
			IB.plane = GAME_PLANE_UPPER
			IB.override = 1
			IB.glide_size = buckled.glide_size
			IB.dir = buckled.dir

	if(pulling && !QDELETED(pulling) && client)
		if(pulling.flags_1 & OVERLAY_QUEUED_1)
			COMPILE_OVERLAYS(pulling)
		if(!IP)
			IP = image(loc = pulling)
			client.images += IP
			client.hidden_images += IP
		if(IP)
			IP.appearance = pulling.appearance
			IP.plane = GAME_PLANE_UPPER
			IP.override = 1
			IP.glide_size = pulling.glide_size
			IP.dir = pulling.dir
/*	if(hud_used && hud_used.fov_blocker)
		fov_blocker

		var/icon/new_blocker = icon("icon"='icons/mob/vision_cone.dmi', "icon_state"=hud_used.fov_blocker.icon_state)
		var/icon/the_mob = icon("icon"='icons/mob/clothing/under/masking_helpers.dmi', "icon_state"="[(type == FEMALE_UNIFORM_FULL) ? "female_full" : "female_top"]")
		female_clothing_icon.Blend(female_s, ICON_MULTIPLY)
*/

/*	if(src.client)
		var/image/I = null
		for(I in src.client.hidden_atoms)
			I.override = 0
			client.images -= I
			qdel(I)
		for(var/hidden_hud in client.hidden_images)
			client.images += hidden_hud
			client.hidden_images -= hidden_hud
		src.client.hidden_atoms = list()
		src.client.hidden_mobs = list()
		client.hidden_images = list()
		if(hud_used && hud_used.fov)
//			hud_used.fov.dir = src.dir
			if(hud_used.fov.alpha != 0)
				var/mob/living/M
				var/list/mobs2hide = list()

				if(fovangle & FOV_RIGHT)
					if(fovangle & FOV_LEFT)
						var/dirlist = list(turn(src.dir, 180),turn(src.dir, -90),turn(src.dir, 90))
						mobs2hide |= cone(src, dirlist, GLOB.mob_living_list.Copy())
					else
						if(fovangle & FOV_BEHIND)
							var/dirlist = list(turn(src.dir, -90))
							mobs2hide |= behind(src, list(turn(src.dir, 180)), GLOB.mob_living_list.Copy())
							mobs2hide |= cone(src, dirlist, GLOB.mob_living_list.Copy())
						else
							var/dirlist = list(turn(src.dir, 180),turn(src.dir, -90))
							mobs2hide |= cone(src, dirlist, GLOB.mob_living_list.Copy())
				else
					if(fovangle & FOV_LEFT)
						if(fovangle & FOV_BEHIND)
							var/dirlist = list(turn(src.dir, 90))
							mobs2hide |= behind(src, list(turn(src.dir, 180)), GLOB.mob_living_list.Copy())
							mobs2hide |= cone(src, dirlist, GLOB.mob_living_list.Copy())
						else
							var/dirlist = list(turn(src.dir, 180),turn(src.dir, 90))
							mobs2hide |= cone(src, dirlist, GLOB.mob_living_list.Copy())
					else
						if(fovangle & FOV_BEHIND)
							mobs2hide |= behind(src, list(turn(src.dir, 180)), GLOB.mob_living_list.Copy())
						else//default
							mobs2hide |= cone(src, list(turn(src.dir, 180)), GLOB.mob_living_list.Copy())

				for(M in mobs2hide)
					I = image("split", M)
					I.override = 1
					src.client.images += I
					src.client.hidden_atoms += I
					src.client.hidden_mobs += M
					if(src.pulling == M)//If we're pulling them we don't want them to be invisible, too hard to play like that.
						I.override = 0
					if(src.pulledby == M)
						I.icon = 'icons/mob/mob.dmi'
						I.icon_state = "anon"
		for(var/image/HUD in client.images)
			if(HUD.icon != 'icons/mob/hud.dmi')
				continue
			for(var/mob/living/M in client.hidden_mobs)
				if(HUD.loc == M)
					client.hidden_images += HUD
					client.images -= HUD
					break*/

/mob/proc/can_see_cone(mob/L)
	if(!isliving(src) || !isliving(L))
		return
	if(!client)
		return TRUE
	if(hud_used && hud_used.fov)
		if(hud_used.fov.alpha != 0)
			var/list/mobs2hide = list()

			if(fovangle & FOV_RIGHT)
				if(fovangle & FOV_LEFT)
					var/dirlist = list(turn(src.dir, 180),turn(src.dir, -90),turn(src.dir, 90))
					mobs2hide |= cone(src, dirlist, list(L))
				else
					if(fovangle & FOV_BEHIND)
						var/dirlist = list(turn(src.dir, -90))
						mobs2hide |= behind(src, list(turn(src.dir, 180)), list(L))
						mobs2hide |= cone(src, dirlist, list(L))
					else
						var/dirlist = list(turn(src.dir, 180),turn(src.dir, -90))
						mobs2hide |= cone(src, dirlist, list(L))
			else
				if(fovangle & FOV_LEFT)
					if(fovangle & FOV_BEHIND)
						var/dirlist = list(turn(src.dir, 90))
						mobs2hide |= behind(src, list(turn(src.dir, 180)), list(L))
						mobs2hide |= cone(src, dirlist, list(L))
					else
						var/dirlist = list(turn(src.dir, 180),turn(src.dir, 90))
						mobs2hide |= cone(src, dirlist, list(L))
				else
					if(fovangle & FOV_BEHIND)
						mobs2hide |= behind(src, list(turn(src.dir, 180)), list(L))
					else//default
						mobs2hide |= cone(src, list(turn(src.dir, 180)), list(L))

			if(L in mobs2hide)
/*				I = image("split", M)
				I.override = 1
				src.client.images += I
				src.client.hidden_atoms += I
				if(src.pulling == M)//If we're pulling them we don't want them to be invisible, too hard to play like that.
					I.override = 0
				if(src.pulledby == M)
					I.icon = 'icons/mob/mob.dmi'
					I.icon_state = "anon"*/
				return FALSE
	return TRUE

/mob/proc/update_cone_show()
	if(!client)
		return
	if(client.perspective != MOB_PERSPECTIVE)
		return hide_cone()
	if(client.eye != src)
		return hide_cone()
	if(client.pixel_x || client.pixel_y)
		return hide_cone()
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.resting || H.lying)
			return hide_cone()
		if(!H.client && (H.mode != AI_OFF))
			return hide_cone()
	return show_cone()

/mob/proc/update_fov_angles()
	fovangle = initial(fovangle)
	if(ishuman(src) && fovangle)
		var/mob/living/carbon/human/H = src
		if(H.head)
			if(H.head.block2add)
				fovangle |= H.head.block2add
		if(H.wear_mask)
			if(H.wear_mask.block2add)
				fovangle |= H.wear_mask.block2add
		if(has_flaw(/datum/charflaw/noeyer))
			fovangle |= FOV_RIGHT
		if(has_flaw(/datum/charflaw/noeyel))
			fovangle |= FOV_LEFT
		if(H.STAPER < 5)
			fovangle |= FOV_LEFT
			fovangle |= FOV_RIGHT

	if(!hud_used)
		return
	if(!hud_used.fov)
		return
	if(!hud_used.fov_blocker)
		return
	if(fovangle & FOV_DEFAULT)
		if(fovangle & FOV_RIGHT)
			if(fovangle & FOV_LEFT)
				hud_used.fov.icon_state = "both"
				hud_used.fov_blocker.icon_state = "both_v"
				return
			hud_used.fov.icon_state = "right"
			hud_used.fov_blocker.icon_state = "right_v"
			if(fovangle & FOV_BEHIND)
				hud_used.fov.icon_state = "behind_r"
				hud_used.fov_blocker.icon_state = "behind_r_v"
			return
		else if(fovangle & FOV_LEFT)
			hud_used.fov.icon_state = "left"
			hud_used.fov_blocker.icon_state = "left_v"
			if(fovangle & FOV_BEHIND)
				hud_used.fov.icon_state = "behind_l"
				hud_used.fov_blocker.icon_state = "behind_l_v"
			return
		if(fovangle & FOV_BEHIND)
			hud_used.fov.icon_state = "behind"
			hud_used.fov_blocker.icon_state = "behind_v"
		else
			hud_used.fov.icon_state = "combat"
			hud_used.fov_blocker.icon_state = "combat_v"
	else
		hud_used.fov.icon_state = null
		hud_used.fov_blocker.icon_state = null
		return

//Making these generic procs so you can call them anywhere.
/mob/proc/show_cone()
	if(!client)
		return
	if(hud_used)
		if(hud_used.fov)
			hud_used.fov.alpha = 255
		if(hud_used.fov_blocker)
			hud_used.fov_blocker.alpha = 255
	if(client.screen)
		var/obj/screen/plane_master/game_world_fov_hidden/PM = locate(/obj/screen/plane_master/game_world_fov_hidden) in client.screen
		PM?.backdrop(src)
	update_cone()

/mob/proc/hide_cone()
	if(!client)
		return
	if(hud_used)
		if(hud_used.fov)
			hud_used.fov.alpha = 0
		if(hud_used.fov_blocker)
			hud_used.fov_blocker.alpha = 0
	if(client.screen)
		var/obj/screen/plane_master/game_world_fov_hidden/PM = locate(/obj/screen/plane_master/game_world_fov_hidden) in client.screen
		PM?.backdrop(src)

/obj/screen/fov_blocker
	icon = 'icons/mob/vision_cone.dmi'
	icon_state = "combat_v"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FIELD_OF_VISION_BLOCKER_PLANE
	screen_loc = "1,1"

/obj/screen/fov
	icon = 'icons/mob/vision_cone.dmi'
	icon_state = "combat"
	name = " "
	screen_loc = "1,1"
	mouse_opacity = 0
	layer = HUD_LAYER
	plane = HUD_PLANE-2
