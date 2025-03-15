GLOBAL_VAR_INIT(global_forced_parallax, 0)

/obj/item/parallax_forcer
	name = "УСТРОЙСТВО ИЗМЕНЯЮЩЕЕ РЕАЛЬНОСТЬ"
	desc = "meow"
	icon = 'newstuff/nikitauou/icons/projectiles.dmi'
	icon_state = "uncanny"

/obj/item/parallax_forcer/Initialize(mapload)
	. = ..()
	add_filter("rays_filter",3,list(type = "rays", size = 40, density = 16, color = COLOR_DARK_PURPLE, factor = 1, flags = FILTER_UNDERLAY,offset=30))

/obj/item/parallax_forcer/attack_self(mob/user, modifiers)
	. = ..()
	var/parallax_type = input(user,"SELLECT GLOBAL FORCED PARALLAX", "Meow") as num|null
	if(isnull(parallax_type)|parallax_type>4)
		return
	GLOB.global_forced_parallax = parallax_type
	to_chat(user, span_hypnophrase("REALITY HAS BEEN CHANGED!!"))
	to_chat(user, span_hypnophrase(num2text(parallax_type)))
	for(var/m in GLOB.player_list)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			if(M.hud_used)
				M?.hud_used?.update_parallax_pref(M)
