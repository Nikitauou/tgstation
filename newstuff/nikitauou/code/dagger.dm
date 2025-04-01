/obj/item/knife/dagger
	name = "Стальной кинжал"
	icon = 'newstuff/general/icons/weapons.dmi'
	icon_state = "sdagger"
	attack_verb_continuous = list("протыкает","пронзает")
	attack_verb_simple = list("проткнул","пронзил")
	force = 20
	sharpness = SHARP_POINTY

/obj/item/knife/dagger/Initialize(mapload)
	. = ..()
	create_reagents(10)
	reagents.add_reagent(/datum/reagent/water,10)

/obj/item/knife/dagger/afterattack(atom/target, mob/user, click_parameters)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		if(M.try_inject(user))
			reagents.trans_to(M,reagents.total_volume/2+0.5)

/obj/item/knife/dagger/wash(clean_types)
	. = ..()
	reagents.remove_all(reagents.total_volume)

/obj/item/knife/dagger/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(is_reagent_container(interacting_with))
		var/obj/item/reagent_containers/RC = interacting_with
		if(RC.reagent_flags & OPENCONTAINER)
			if(RC.reagents.trans_to(reagents,reagents.maximum_volume-reagents.total_volume))
				to_chat(user,span_info("Ты окунул [src] в [RC]"))
