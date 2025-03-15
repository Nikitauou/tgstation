/mob/living/simple_animal/hostile/space_mosquito
	name = "Space Mosquito"
	real_name = "Space Mosquito"
	icon = 'newstuff/ahathg/icons/animals.dmi'
	desc = "An expert of battle and survival in extremal environment."
	icon_state = "komar"
	icon_living = "komar"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 250
	health = 250
	response_harm_continuous = "harmlessly punches"
	response_harm_simple = "harmlessly punch"
	harm_intent_damage = 0
	obj_damage = 100
	melee_damage_lower = 250
	melee_damage_upper = 300
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slashes"
	speed = -10
	environment_smash = ENVIRONMENT_SMASH_WALLS
	attack_sound = 'newstuff/ahathg/sound/komar.ogg'
	status_flags = 0
	mob_size = MOB_SIZE_HUMAN
	del_on_death = TRUE
	move_to_delay = 1 // √Œ““¿ ‘¿—“ ¡Œ………
	speak_chance = 0
	AIStatus = AI_ON
	loot = list(/obj/effect/gibspawner/human)

/mob/living/simple_animal/hostile/space_mosquito/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		L.adjustBruteLoss(110)
		qdel(src)
	return