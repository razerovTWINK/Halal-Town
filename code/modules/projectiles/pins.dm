/obj/item/firing_pin
	name = "электронный боёк"
	desc = ""
	icon = 'icons/obj/device.dmi'
	icon_state = "firing_pin"
	item_state = "pen"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("poked")
	var/fail_message = "<span class='warning'>НЕИЗВЕСТНЫЙ ПОЛЬЗОВАТЕЛЬ.</span>"
	var/selfdestruct = 0 // Explode when user check is failed.
	var/force_replace = 0 // Can forcefully replace other pins.
	var/pin_removeable = 0 // Can be replaced by any pin.
	var/obj/item/gun/gun

/obj/item/firing_pin/New(newloc)
	..()
	if(istype(newloc, /obj/item/gun))
		gun = newloc

/obj/item/firing_pin/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		if(istype(target, /obj/item/gun))
			var/obj/item/gun/G = target
			if(G.pin && (force_replace || G.pin.pin_removeable))
				G.pin.forceMove(get_turf(G))
				G.pin.gun_remove(user)
				to_chat(user, "<span class='notice'>Ты извлекаешь старый боёк из [G].</span>")

			if(!G.pin)
				if(!user.temporarilyRemoveItemFromInventory(src))
					return
				gun_insert(user, G)
				to_chat(user, "<span class='notice'>Ты вставляешь [src] в [G].</span>")
			else
				to_chat(user, "<span class='notice'>В этом оружии уже установлен боёк.</span>")

/obj/item/firing_pin/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, "<span class='notice'>Ты взламываешь механизм опознавания.</span>")

/obj/item/firing_pin/proc/gun_insert(mob/living/user, obj/item/gun/G)
	gun = G
	forceMove(gun)
	gun.pin = src
	return

/obj/item/firing_pin/proc/gun_remove(mob/living/user)
	gun.pin = null
	gun = null
	return

/obj/item/firing_pin/proc/pin_auth(mob/living/user)
	return TRUE

/obj/item/firing_pin/proc/auth_fail(mob/living/user)
	if(user)
		user.show_message(fail_message, MSG_VISUAL)
	if(selfdestruct)
		if(user)
			user.show_message("<span class='danger'>САМОУНИЧТОЖЕНИЕ...</span><br>", MSG_VISUAL)
			to_chat(user, "<span class='danger'>[gun] взрывается!</span>")
		explosion(get_turf(gun), -1, 0, 2, 3)
		if(gun)
			qdel(gun)


/obj/item/firing_pin/magic
	name = "осколок магического кристалла"
	desc = ""


// Test pin, works only near firing range.
/obj/item/firing_pin/test_range
	name = "тренировочный боёк"
	desc = ""
	fail_message = "<span class='warning'>ПРОВЕРКА ТИРА НЕ ПРОЙДЕНА.</span>"
	pin_removeable = TRUE

/obj/item/firing_pin/test_range/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	for(var/obj/machinery/magnetic_controller/M in range(user, 3))
		return TRUE
	return FALSE


// Implant pin, checks for implant
/obj/item/firing_pin/implant
	name = "боёк с проверкой импланта"
	desc = ""
	fail_message = "<span class='warning'>ПРОВЕРКА ИМПЛАНТА НЕ ПРОЙДЕНА.</span>"
	var/obj/item/implant/req_implant = null

/obj/item/firing_pin/implant/pin_auth(mob/living/user)
	if(user)
		for(var/obj/item/implant/I in user.implants)
			if(req_implant && I.type == req_implant)
				return TRUE
	return FALSE

/obj/item/firing_pin/implant/mindshield
	name = "боёк щита разума"
	desc = ""
	icon_state = "firing_pin_loyalty"
	req_implant = /obj/item/implant/mindshield

/obj/item/firing_pin/implant/pindicate
	name = "боёк синдиката"
	icon_state = "firing_pin_pindi"
	req_implant = /obj/item/implant/weapons_auth



// Honk pin, clown's joke item.
// Can replace other pins. Replace a pin in cap's laser for extra fun!
/obj/item/firing_pin/clown
	name = "потешный боёк"
	desc = ""
	color = "#FFFF00"
	fail_message = "<span class='warning'>ХОНК!</span>"
	force_replace = TRUE

/obj/item/firing_pin/clown/pin_auth(mob/living/user)
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	return FALSE

// Ultra-honk pin, clown's deadly joke item.
// A gun with ultra-honk pin is useful for clown and useless for everyone else.
/obj/item/firing_pin/clown/ultra/pin_auth(mob/living/user)
	playsound(src.loc, 'sound/blank.ogg', 50, TRUE)
	if(user && (!(HAS_TRAIT(user, TRAIT_CLUMSY)) && !(user.mind && user.mind.assigned_role == "Clown")))
		return FALSE
	return TRUE

/obj/item/firing_pin/clown/ultra/gun_insert(mob/living/user, obj/item/gun/G)
	..()
	G.clumsy_check = FALSE

/obj/item/firing_pin/clown/ultra/gun_remove(mob/living/user)
	gun.clumsy_check = initial(gun.clumsy_check)
	..()

// Now two times deadlier!
/obj/item/firing_pin/clown/ultra/selfdestruct
	desc = ""
	selfdestruct = TRUE


// DNA-keyed pin.
// When you want to keep your toys for myself.
/obj/item/firing_pin/dna
	name = "боёк с ДНК-замком"
	desc = ""
	icon_state = "firing_pin_dna"
	fail_message = "<span class='warning'>ПРОВЕРКА ДНК НЕ ПРОЙДЕНА.</span>"
	var/unique_enzymes = null

/obj/item/firing_pin/dna/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag && iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.dna && M.dna.unique_enzymes)
			unique_enzymes = M.dna.unique_enzymes
			to_chat(user, "<span class='notice'>ДНК-ЗАМОК УСТАНОВЛЕН.</span>")

/obj/item/firing_pin/dna/pin_auth(mob/living/carbon/user)
	if(user && user.dna && user.dna.unique_enzymes)
		if(user.dna.unique_enzymes == unique_enzymes)
			return TRUE
	return FALSE

/obj/item/firing_pin/dna/auth_fail(mob/living/carbon/user)
	if(!unique_enzymes)
		if(user && user.dna && user.dna.unique_enzymes)
			unique_enzymes = user.dna.unique_enzymes
			to_chat(user, "<span class='notice'>ДНК-ЗАМОК УСТАНОВЛЕН.</span>")
	else
		..()

/obj/item/firing_pin/dna/dredd
	desc = ""
	selfdestruct = TRUE

// Paywall pin, brought to you by ARMA 3 DLC.
// Checks if the user has a valid bank account on an ID and if so attempts to extract a one-time payment to authorize use of the gun. Otherwise fails to shoot.
/obj/item/firing_pin/paywall
	name = "платный боёк"
	desc = ""
	color = "#FFD700"
	fail_message = ""
	var/list/gun_owners = list() //list of people who've accepted the license prompt. If this is the multi-payment pin, then this means they accepted the waiver that each shot will cost them money
	var/payment_amount //how much gets paid out to license myself to the gun
	var/obj/item/card/id/pin_owner
	var/multi_payment = FALSE //if true, user has to pay everytime they fire the gun
	var/owned = FALSE
	var/active_prompt = FALSE //purchase prompt to prevent spamming it

/obj/item/firing_pin/paywall/attack_self(mob/user)
	multi_payment = !multi_payment
	to_chat(user, "<span class='notice'>Ты настраиваешь боёк на [( multi_payment ) ? "оплату за каждый выстрел" : "разовую оплату лицензии"].</span>")

/obj/item/firing_pin/paywall/examine(mob/user)
	. = ..()
	if(pin_owner)
		. += "<span class='notice'>Этот боёк настроен на перевод средств на счёт [pin_owner.registered_name].</span>"

/obj/item/firing_pin/paywall/gun_insert(mob/living/user, obj/item/gun/G)
	if(!pin_owner)
		to_chat(user, "<span class='warning'>ОШИБКА: Проведи действительной картой перед установкой бойка!</span>")
		return
	gun = G
	forceMove(gun)
	gun.pin = src
	if(multi_payment)
		gun.desc += "<span class='notice'> Этот [gun.name] требует [payment_amount] монет за выстрел.</span>"
		return
	gun.desc += "<span class='notice'> Этот [gun.name] требует [payment_amount] монет за покупку лицензии.</span>"
	return


/obj/item/firing_pin/paywall/gun_remove(mob/living/user)
	gun.desc = initial(desc)
	..()

/obj/item/firing_pin/paywall/attackby(obj/item/M, mob/user, params)
	if(istype(M, /obj/item/card/id))
		var/obj/item/card/id/id = M
		if(!id.registered_account)
			to_chat(user, "<span class='warning'>ОШИБКА: К карте не привязан банковский счёт!</span>")
			return
		if(id != pin_owner && owned)
			to_chat(user, "<span class='warning'>ОШИБКА: Этот боёк уже авторизован!</span>")
			return
		if(id == pin_owner)
			to_chat(user, "<span class='notice'>Ты отвязываешь карту от бойка.</span>")
			gun_owners -= user
			pin_owner = null
			owned = FALSE
			return
		var/transaction_amount = input(user, "Введи сумму депозита для покупки оружия", "Внесение средств") as null|num
		if(transaction_amount < 1)
			to_chat(user, "<span class='warning'>ОШИБКА: Указана неверная сумма.</span>")
			return
		if(!transaction_amount)
			return
		pin_owner = id
		owned = TRUE
		payment_amount = transaction_amount
		gun_owners += user
		to_chat(user, "<span class='notice'>Ты привязываешь карту к бойку.</span>")

/obj/item/firing_pin/paywall/pin_auth(mob/living/user)
	if(!istype(user))//nice try commie
		return FALSE
	if(ishuman(user))
		var/datum/bank_account/credit_card_details
		var/mob/living/carbon/human/H = user
		if(H.get_bank_account())
			credit_card_details = H.get_bank_account()
		if(H in gun_owners)
			if(multi_payment && credit_card_details)
				if(credit_card_details.adjust_money(-payment_amount))
					pin_owner.registered_account.adjust_money(payment_amount)
					return TRUE
				to_chat(user, "<span class='warning'>ОШИБКА: Недостаточно средств на балансе!</span>")
				return FALSE
			return TRUE
		if(credit_card_details && !active_prompt)
			var/license_request = alert(usr, "Хочешь заплатить [payment_amount] монет за [( multi_payment ) ? "каждый выстрел из [gun.name]" : "лицензию на использование [gun.name]"]?", "Покупка оружия", "Да", "Нет")
			active_prompt = TRUE
			if(!user.canUseTopic(src, BE_CLOSE))
				active_prompt = FALSE
				return FALSE
			switch(license_request)
				if("Да")
					if(credit_card_details.adjust_money(-payment_amount))
						pin_owner.registered_account.adjust_money(payment_amount)
						gun_owners += H
						to_chat(user, "<span class='notice'>Лицензия на оружие приобретена!</span>")
						active_prompt = FALSE
						return FALSE //we return false here so you don't click initially to fire, get the prompt, accept the prompt, and THEN the gun
					to_chat(user, "<span class='warning'>ОШИБКА: Недостаточно средств на балансе!</span>")
					return FALSE
				if("Нет")
					to_chat(user, "<span class='warning'>ОШИБКА: Отказ от покупки лицензии на оружие!</span>")
					return FALSE
		to_chat(user, "<span class='warning'>ОШИБКА: Нет действующего банковского счёта для списания средств!</span>")
		return FALSE

// Laser tag pins
/obj/item/firing_pin/tag
	name = "лазертаг-боёк"
	desc = ""
	fail_message = "<span class='warning'>ПРОВЕРКА КОСТЮМА НЕ ПРОЙДЕНА.</span>"
	var/obj/item/clothing/suit/suit_requirement = null
	var/tagcolor = ""

/obj/item/firing_pin/tag/pin_auth(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/M = user
		if(istype(M.wear_armor, suit_requirement))
			return TRUE
	to_chat(user, "<span class='warning'>Тебе нужно надеть лазертаг-броню [tagcolor] цвета!</span>")
	return FALSE

/obj/item/firing_pin/tag/red
	name = "красный лазертаг-боёк"
	icon_state = "firing_pin_red"
	suit_requirement = /obj/item/clothing/suit/redtag
	tagcolor = "red"

/obj/item/firing_pin/tag/blue
	name = "синий лазертаг-боёк"
	icon_state = "firing_pin_blue"
	suit_requirement = /obj/item/clothing/suit/bluetag
	tagcolor = "blue"

/obj/item/firing_pin/Destroy()
	if(gun)
		gun.pin = null
	return ..()
