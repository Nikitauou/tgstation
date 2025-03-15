/// Sledgehammer
/obj/item/inteq_sledgehammer
	name = "sledgehammer"
	desc = "Самый нормальный инструмент для разбивания бетона, не так ли?"
	icon_state = "sledgehammer"
	icon = 'newstuff/ahathg/icons/weapons.dmi'
	lefthand_file = 'newstuff/ahathg/icons/weapons_l.dmi'
	righthand_file = 'newstuff/ahathg/icons/weapons_r.dmi'
	force = 10
	block_chance = 30
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	wound_bonus = 30
	bare_wound_bonus = 30
	armour_penetration = 70
	attack_speed = CLICK_CD_MELEE * 1.2
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'newstuff/ahathg/sound/sledge.ogg'
	var/force_unwielded = 10
	var/force_wielded = 30
	attack_verb_continuous = list("бьет", "разбивает")
	attack_verb_simple = list("бьет", "разбивает",)

/obj/item/inteq_sledgehammer/update_icon_state()
	icon_state = "sledgehammer"

/obj/item/inteq_sledgehammer/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is trying to literally smash himself with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/obj/item/bodypart/BP = C.get_bodypart(BODY_ZONE_HEAD)
		if(BP)
			BP.drop_limb()
			playsound(src,pick('newstuff/ahathg/sound/sledge.ogg') ,50, 1, -1)
	return (BRUTELOSS)

/obj/item/inteq_sledgehammer/proc/slash(mob/living/user, mob/living/target)
		user.do_attack_animation(target, ATTACK_EFFECT_KICK)
		sleep(1)

/obj/item/inteq_sledgehammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_multiplier = 4, \
		icon_wielded = "sledgehammer1", \
	)
