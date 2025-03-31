#define HEIGHT_OPTIMAL 	400000
#define HEIGHT_DANGER 	300000
#define HEIGHT_CRITICAL 200000
#define HEIGHT_DEADEND 	100000
#define HEIGHT_CRASH 	0
GLOBAL_VAR_INIT(ruination_orbit_height, HEIGHT_OPTIMAL)
GLOBAL_VAR_INIT(ruination_orbit_speed, 0)
GLOBAL_LIST_EMPTY(pulse_engines)

/obj/structure/pulse_engine
	name = "импульсный двигатель"
	desc = "Массивная конструкция для выведения с орбит непригодных станций... погоди, а что он делает на нашей станции?"
	icon = 'newstuff/nikitauou/icons/pulse.dmi'
	icon_state = "pulse_off"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = ABOVE_ALL_MOB_LAYER
	density = TRUE
	var/engine_power = 0
	var/minimum_power = 0
	var/engine_active = FALSE

/obj/structure/pulse_engine/examine(mob/user)
	. = ..()
	. += span_danger("<hr>Текущая мощность: [engine_power]%")
	. += span_danger("Минимальная мощность: [minimum_power]%")
	. += span_notice("<hr>Похоже, если его неплохо так поколотить, то он станет работать <b>намного [user?.mind?.has_antag_datum(/datum/antagonist/traitor/ruiner) ? "лучше" : "хуже"]</b>.")

/obj/structure/pulse_engine/Destroy(force)
	GLOB.pulse_engines -= src
	. = ..()

/obj/structure/pulse_engine/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(user?.mind?.has_antag_datum(/datum/antagonist/traitor/ruiner) && is_station_level(user.z))
		var/turf/T = get_turf(src)
		var/area/A = get_area(T)
		if(engine_active)
			to_chat(user, span_danger("Двигатель уже включён!"))
			return
		if(istype(A, /area/space) || isinspace())
			to_chat(user,span_danger("ТЫ НЕ НА СТАНЦИИ"))
			return
		engine_active = TRUE
		anchored = TRUE
		flick("pulse_activate",src)
		to_chat(user, span_notice("Включаю двигатель"))
		spawn(66)
			GLOB.pulse_engines += src
			icon_state = "pulse_on"
			add_overlay("pulse_overlay")
			START_PROCESSING(SSmachines,src)
			priority_announce("Был обнаружен импульсный двигатель в локации [get_area_name(src, TRUE)].", "ТРЕВОГА", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
			light_color = "#f79947"
			light_range = 8
			update_light()

/obj/structure/pulse_engine/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(I.force)
		if(user?.mind?.has_antag_datum(/datum/antagonist/traitor/ruiner))
			engine_power += min(I.force, 25)
			engine_power = min(engine_power, 100)
		else
			engine_power -= min(I.force, 25)
			engine_power = max(engine_power, minimum_power)

/obj/structure/pulse_engine/process(delta_time)
	engine_power = max(engine_power - 2, minimum_power)

/obj/item/sbeacondrop/pulse_engine
	desc = "Надпись гласит: <i>Внимание: Активация данного устройства отправит импульсный двигатель в точку вызова</i>."
	droptype = /obj/structure/pulse_engine

///PULSE ENGINE END
///GAMEMODE LOGIC START

/datum/antagonist/traitor/ruiner
	name = "Ruiner"
	show_in_antagpanel = TRUE
	give_objectives = FALSE
	antag_hud_name = "ruiner"
	antag_moodlet = /datum/mood_event/focused
	job_rank = ROLE_TRAITOR

/datum/antagonist/traitor/ruiner/on_gain()
	. = ..()
	var/mob/living/carbon/H = owner.current
	to_chat(H,span_danger("ДАВАЙ ДАВАЙ ДАВАЙ!!!!!"))
	var/T = new /obj/item/sbeacondrop/pulse_engine(H)
	H.equip_to_slot_if_possible(T, ITEM_SLOT_BACKPACK, FALSE, indirect_action = TRUE)

/datum/dynamic_ruleset/roundstart/ruination
	name = "Ruination"
	persistent = TRUE
	flags = list(LONE_RULESET)
	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor/ruiner
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
	antag_cap = 2
	var/show_height_hud = FALSE
	var/started_time
	var/current_stage = 0
	var/announce_stage = 0
	var/win_time = 20 MINUTES
	var/ended = FALSE

/datum/dynamic_ruleset/roundstart/ruination/pre_execute(population)
	. = ..()
	for (var/i in 1 to get_antag_cap(population))
		var/mob/candidate = pick_n_take(candidates)
		if (isnull(candidate))
			break

		assigned += candidate.mind
		candidate.mind.restricted_roles = restricted_roles
		candidate.mind.special_role = ROLE_TRAITOR
		GLOB.pre_setup_antags += candidate.mind

	return TRUE

/datum/dynamic_ruleset/roundstart/ruination/execute()
	. = ..()
	CONFIG_SET(flag/allow_random_events, FALSE)

/datum/dynamic_ruleset/roundstart/ruination/rule_process()
	. = ..()

	///Once at least 1 engine started
	if(!started_time && GLOB.pulse_engines.len>0)
		started_time = world.time
		priority_announce("На вашей станции был обнаружен запуск одного или нескольких импульсных двигателей!\nПомешайте террористам любой ценой!", "ТРЕВОГА", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
		sound_to_playing_players('newstuff/nikitauou/sound/music/Ruination_ost.ogg',channel=CHANNEL_LOBBYMUSIC,pressure_affected = FALSE)
		spawn(300)
			SSshuttle.emergency.setTimer(0)
			SSshuttle.emergency.mode = SHUTTLE_DISABLED
			SSsecurity_level.set_level(SEC_LEVEL_DELTA)
			priority_announce("Внимание: эвакуационный шаттл был заблокирован!", "Сбой эвакуационного шаттла", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
			spawn(150)
				show_height_hud = TRUE

	///After start
	if(started_time)
		///Updating or creating hud for everyone playing
		if(show_height_hud)
			for(var/m in GLOB.player_list)
				if(ismob(m)&&!isnewplayer(m))
					var/mob/M = m
					var/datum/hud/H = M.hud_used
					if(!M.hud_used?.ruination_height)
						var/atom/movable/screen/ruination_height/rh = new /atom/movable/screen/ruination_height()
						var/atom/movable/screen/ruination_height_bg/rhbg = new /atom/movable/screen/ruination_height_bg()
						H.ruination_height = rh
						H.ruination_height_bg = rhbg
						H.infodisplay += rh
						H.infodisplay += rhbg
						H.mymob.client.screen += rh
						H.mymob.client.screen += rhbg
					H.ruination_height.update_height()

		///Managing announcements and bluespace translocator ending
		if((started_time + (win_time - 15 MINUTES)) < world.time && announce_stage == 0)
			announce_stage = 1
			priority_announce("Не паниковать!\nМы поняли как спасти станцию, вам необходимо задержать террористов пока активируется блюспейс транслокатор!\n15 минут до активации блюспейс транслокатора", "БЛЮСПЕЙС ТРАНСЛОКАТОР", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
		if((started_time + (win_time - 10 MINUTES)) < world.time && announce_stage == 1)
			announce_stage = 2
			priority_announce("Осталось 10 минут до активации блюспейс транслокатора", "БЛЮСПЕЙС ТРАНСЛОКАТОР", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
		if((started_time + (win_time - 5 MINUTES)) < world.time && announce_stage == 2)
			announce_stage = 3
			priority_announce("Осталось 5 минут до активации блюспейс транслокатора", "БЛЮСПЕЙС ТРАНСЛОКАТОР ", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
		if((started_time + win_time) < world.time && announce_stage == 3)
			announce_stage = 4
			priority_announce("БЛЮСПЕЙС ТРАНСЛОКАТОР АКТИВИРОВАН!", "БЛЮСПЕЙС ТРАНСЛОКАТОР", 'newstuff/nikitauou/sound/trevoga2.ogg', ANNOUNCEMENT_TYPE_PRIORITY)
			SSticker.force_ending = FORCE_END_ROUND
			GLOB.global_forced_parallax = PARALLAX_STANDARD
			for(var/m in GLOB.player_list)
				if(ismob(m)&&!isnewplayer(m))
					var/mob/M = m
					M.hud_used.update_parallax_pref(M)
					shake_camera(M,3,14)

		///Managing parallax and station crush ending
		if(!ended)
			switch(GLOB.ruination_orbit_height)
				if(HEIGHT_OPTIMAL to INFINITY)
					GLOB.global_forced_parallax = PARALLAX_STANDARD
					update_parallax(0)
				if(HEIGHT_DANGER to HEIGHT_OPTIMAL)
					GLOB.global_forced_parallax = PARALLAX_STANDARD
					update_parallax(1)
				if(HEIGHT_CRITICAL to HEIGHT_DANGER)
					GLOB.global_forced_parallax = PARALLAX_STANDARD
					update_parallax(2)
				if(HEIGHT_DEADEND to HEIGHT_CRITICAL)
					GLOB.global_forced_parallax = PARALLAX_CLOUDS
					update_parallax(3)
				if(HEIGHT_CRASH to HEIGHT_DEADEND)
					GLOB.global_forced_parallax = PARALLAX_FALLING
					update_parallax(4)
				else
					if(GLOB.ruination_orbit_height <= HEIGHT_CRASH)
						GLOB.global_forced_parallax = PARALLAX_SURFACE
						update_parallax(5)
						ended = TRUE
						SSticker.force_ending = FORCE_END_ROUND
						for(var/m in GLOB.player_list)
							if(ismob(m)&&!isnewplayer(m))
								var/mob/M = m
								shake_camera(M,5,14)

						for(var/i = 1 to 5)
							var/turf/to_explode = get_random_station_turf()
							explosion(to_explode,17.5,37,39,41)

		///Managing station speed
			var/total_speed = 0
			for(var/obj/structure/pulse_engine/PE in GLOB.pulse_engines)
				total_speed += PE.engine_power * 5
			GLOB.ruination_orbit_height -= total_speed
			GLOB.ruination_orbit_speed = total_speed


/datum/dynamic_ruleset/roundstart/ruination/proc/update_parallax(var/new_stage)
	if(current_stage != new_stage)
		current_stage = new_stage
		for(var/m in GLOB.player_list)
			if(ismob(m)&&!isnewplayer(m))
				var/mob/M = m
				shake_camera(M,3,7)
				M.hud_used.update_parallax_pref(M)

/atom/movable/screen/ruination_height
	icon = 'newstuff/nikitauou/icons/line.png'
	screen_loc = "SOUTH:420, EAST-3:48"
	maptext_y = -4
	maptext_width = 96
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/ruination_height/Initialize()
	. = ..()
	overlays+=icon('newstuff/nikitauou/icons/station.png')

/atom/movable/screen/ruination_height/proc/update_height()
	screen_loc = "SOUTH:[min(round((GLOB.ruination_orbit_height * 0.001), 1)+64, 440)], EAST-3:48"
	maptext = "<span style='color: #A35D5B; font-size: 8px;'>[GLOB.ruination_orbit_height] M</br>[GLOB.ruination_orbit_speed] M/C</span>"

/atom/movable/screen/ruination_height_bg
	icon = 'newstuff/nikitauou/icons/graph.png'
	screen_loc = "SOUTH, EAST-3"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
