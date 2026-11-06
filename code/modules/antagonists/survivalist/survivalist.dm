/datum/antagonist/survivalist
	name = "Survivalist"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	var/greet_message = ""

/datum/antagonist/survivalist/proc/forge_objectives()
	var/datum/objective/survive/survive = new
	survive.owner = owner
	objectives += survive

/datum/antagonist/survivalist/on_gain()
	owner.special_role = "survivalist"
	forge_objectives()
	. = ..()

/datum/antagonist/survivalist/greet()
	to_chat(owner, "<B>Ты — выживальщик! [greet_message]</B>")
	owner.announce_objectives()

/datum/antagonist/survivalist/guns
	greet_message = "Твоя безопасность превыше всего, и единственный способ обезопасить себя — запастись оружием! Хватай как можно больше оружия любыми средствами. Убивай любого, кто встанет на пути."

/datum/antagonist/survivalist/guns/forge_objectives()
	var/datum/objective/steal_five_of_type/summon_guns/guns = new
	guns.owner = owner
	objectives += guns
	..()

/datum/antagonist/survivalist/magic
	name = "Amateur Magician"
	greet_message = "Развивай свой новообретённый дар! Хватай как можно больше магических артефактов любыми средствами. Убивай любого, кто встанет на пути."

/datum/antagonist/survivalist/magic/greet()
	..()
	to_chat(owner, "<span class='notice'>Как великий чародей, помни: исчерпанные книги заклинаний теряют всякую ценность.</span>")

/datum/antagonist/survivalist/magic/forge_objectives()
	var/datum/objective/steal_five_of_type/summon_magic/magic = new
	magic.owner = owner
	objectives += magic
	..()
