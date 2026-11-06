/obj/effect/proc_holder/spell/targeted/summonitem
	name = "Призыв предмета"
	desc = ""
	school = "transmutation"
	charge_max = 100
	clothes_req = FALSE
	invocation = "GAR YOK"
	invocation_type = "whisper"
	range = -1
	level_max = 0 //cannot be improved
	cooldown_min = 100
	include_user = TRUE

	var/obj/marked_item

	action_icon_state = "summons"

/obj/effect/proc_holder/spell/targeted/summonitem/cast(list/targets,mob/user = usr)
	for(var/mob/living/L in targets)
		var/list/hand_items = list(L.get_active_held_item(),L.get_inactive_held_item())
		var/message

		if(!marked_item) //linking item to the spell
			message = "<span class='notice'>"
			for(var/obj/item/item in hand_items)
				if(item.item_flags & ABSTRACT)
					continue
				if(SEND_SIGNAL(item, COMSIG_ITEM_MARK_RETRIEVAL) & COMPONENT_BLOCK_MARK_RETRIEVAL)
					continue
				if(HAS_TRAIT(item, TRAIT_NODROP))
					message += "Хоть это и кажется излишним, "
				marked_item = 		item
				message += "Ты помечаешь [item] для призыва.</span>"
				name = "Призыв [item]"
				break

			if(!marked_item)
				if(hand_items)
					message = "<span class='warning'>В руках нет ничего, что можно пометить для призыва!</span>"
				else
					message = "<span class='warning'>Нужно держать нужный предмет в руках, чтобы пометить его для призыва!</span>"

		else if(marked_item && marked_item in hand_items) //unlinking item to the spell
			message = "<span class='notice'>Ты снимаешь метку с [marked_item], чтобы пометить другой предмет.</span>"
			name = "Призыв предмета"
			marked_item = 		null

		else if(marked_item && QDELETED(marked_item)) //the item was destroyed at some point
			message = "<span class='warning'>Ты чувствуешь, что помеченный предмет был уничтожен!</span>"
			name = "Призыв предмета"
			marked_item = 		null

		else	//Getting previously marked item
			var/obj/item_to_retrieve = marked_item
			var/infinite_recursion = 0 //I don't want to know how someone could put something inside itself but these are wizards so let's be safe

			if(!item_to_retrieve.loc)
				if(isorgan(item_to_retrieve)) // Organs are usually stored in nullspace
					var/obj/item/organ/organ = item_to_retrieve
					if(organ.owner)
						// If this code ever runs I will be happy
						log_combat(L, organ.owner, "magically removed [organ.name] from", addition="INTENT: [uppertext(L.a_intent)]")
						organ.Remove(organ.owner)
			else
				while(!isturf(item_to_retrieve.loc) && infinite_recursion < 10) //if it's in something you get the whole thing.
					if(isitem(item_to_retrieve.loc))
						var/obj/item/I = item_to_retrieve.loc
						if(I.item_flags & ABSTRACT) //Being able to summon abstract things because your item happened to get placed there is a no-no
							break
					if(ismob(item_to_retrieve.loc)) //If its on someone, properly drop it
						var/mob/M = item_to_retrieve.loc

						if(issilicon(M)) //Items in silicons warp the whole silicon
							M.loc.visible_message("<span class='warning'>[M] внезапно исчезает!</span>")
							M.forceMove(L.loc)
							M.loc.visible_message("<span class='warning'>[M] внезапно появляется!</span>")
							item_to_retrieve = null
							break
						M.dropItemToGround(item_to_retrieve)

						if(iscarbon(M)) //Edge case housekeeping
							var/mob/living/carbon/C = M
							for(var/X in C.bodyparts)
								var/obj/item/bodypart/part = X
								if(item_to_retrieve in part.embedded_objects)
									part.embedded_objects -= item_to_retrieve
									to_chat(C, "<span class='warning'>[item_to_retrieve], застрявший в [L], загадочным образом исчезает. Какая удача!</span>")
									if(!C.has_embedded_objects())
										C.clear_alert("embeddedobject")
										SEND_SIGNAL(C, COMSIG_CLEAR_MOOD_EVENT, "embedded")
									break

					else
						if(istype(item_to_retrieve.loc, /obj/machinery/portable_atmospherics/)) //Edge cases for moved machinery
							var/obj/machinery/portable_atmospherics/P = item_to_retrieve.loc
							P.disconnect()
							P.update_icon()

						item_to_retrieve = item_to_retrieve.loc

					infinite_recursion += 1

			if(!item_to_retrieve)
				return

			if(item_to_retrieve.loc)
				item_to_retrieve.loc.visible_message("<span class='warning'>[item_to_retrieve.name] внезапно исчезает!</span>")
			if(!L.put_in_hands(item_to_retrieve))
				item_to_retrieve.forceMove(L.drop_location())
				item_to_retrieve.loc.visible_message("<span class='warning'>[item_to_retrieve.name] внезапно появляется!</span>")
				playsound(get_turf(L), 'sound/blank.ogg', 50, TRUE)
			else
				item_to_retrieve.loc.visible_message("<span class='warning'>[item_to_retrieve.name] внезапно появляется в руке [L]!</span>")
				playsound(get_turf(L), 'sound/blank.ogg', 50, TRUE)


		if(message)
			to_chat(L, message)
