/datum/smite/finalmessage
	name = "Final Message"

/datum/smite/finalmessage/effect(client/user, mob/living/target)
	. = ..()
	var/mob/living/C = target
	if(C.stat == DEAD)
		to_chat(usr, "<span class='warning'>[C] is dead!")
		return
	else
		if(isanimal(target))
			var/mob/living/simple_animal/simple_animal = target
			simple_animal.toggle_ai(AI_OFF)
		playsound(target, "newstuff/ahathg/sound/changetheworld.ogg", 100, FALSE)
		target.say("Change the world")
		spawn(20)
			playsound(target, "newstuff/ahathg/sound/myfinalmessage.ogg", 100, FALSE)
			target.say("My final message")
			spawn(20)
				playsound(target, "newstuff/ahathg/sound/goodbye.ogg", 100, FALSE)
				target.say("Goodbye.")
				spawn(20)
					playsound(target, "newstuff/ahathg/sound/endjingle.ogg", 100, FALSE)
					animate(target, alpha = 0, time = 3.5 SECONDS)
					QDEL_IN(target, 3.5 SECONDS)