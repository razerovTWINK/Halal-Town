/datum/antagonist/space_dragon
	name = "Space Dragon"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE

/datum/antagonist/space_dragon/greet()
	to_chat(owner, "<b>Ты — Космический Дракон, бывший космический карп и хранитель тайн созвездия Дракона.\n\
					Неведомые силы открылись тебе в тот день, когда ты поднял посох превращения мага и воззвал: «Силой Дракона, я обладаю мощью!»\n\
					Маг обратился в недолговечного Котёнка-Пирожное, а ты стал Космическим Драконом, самым могущественным зверем во вселенной.\n\
					Клик по клетке извергает пламя в эту точку.\n\
					Взмах хвостом (Tail Sweep) позволит смести любого, кто осмелится подойти слишком близко.\n\
					Атака трупов разрывает их на куски, восстанавливая твоё здоровье.\n\
					Из записей мага ты узнал, кто правит этим местом: уничтожь их, чтобы местные признали в тебе своего нового повелителя.</b>")
	owner.announce_objectives()
	SEND_SOUND(owner.current, sound('sound/blank.ogg'))

/datum/antagonist/space_dragon/proc/forge_objectives()
	var/current_heads = SSjob.get_all_heads()
	var/datum/objective/assassinate/killchosen = new
	killchosen.owner = owner
	var/datum/mind/selected = pick(current_heads)
	killchosen.target = selected
	killchosen.update_explanation_text()
	objectives += killchosen
	var/datum/objective/survive/survival = new
	survival.owner = owner
	objectives += survival

/datum/antagonist/space_dragon/on_gain()
	forge_objectives()
	. = ..()
