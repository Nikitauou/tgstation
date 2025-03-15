/obj/item/clothing/head/utility/welding/disco
	name = "Диско сварочная маска"
	desc = "Изобретение какого-то безумца"
	icon = 'newstuff/nikitauou/icons/clothing.dmi'
	worn_icon = 'newstuff/nikitauou/icons/worn.dmi'
	icon_state = "discomask"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	lefthand_file = 'icons/mob/inhands/clothing/masks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/masks_righthand.dmi'
	custom_materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT*1.75, /datum/material/glass=SMALL_MATERIAL_AMOUNT * 4)
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	armor_type = /datum/armor/utility_welding
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	resistance_flags = FIRE_PROOF
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT

/obj/item/clothing/head/utility/welding/disco/equipped(mob/living/user, slot, initial)
	.=..()
	if(slot == ITEM_SLOT_HEAD)
		RegisterSignal(user,COMSIG_MOB_FLASH_PROTECTED, PROC_REF(flash))

/obj/item/clothing/head/utility/welding/disco/dropped(mob/living/user, slot)
	.=..()
	UnregisterSignal(user,COMSIG_MOB_FLASH_PROTECTED)

/obj/item/clothing/head/utility/welding/disco/IsReflect(def_zone)
	if(def_zone != BODY_ZONE_HEAD) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	flash()
	return TRUE

/obj/item/clothing/head/utility/welding/disco/proc/flash()
	SIGNAL_HANDLER

	playsound(loc,'newstuff/nikitauou/sound/peppino-taunt.mp3',50,TRUE)
	var/list/hearers = get_hearers_in_view(view_radius = DEFAULT_MESSAGE_RANGE, source=src)
	for (var/mob/hearer in hearers)
		if(ishuman(hearer))
			if(hearer != src.loc)
				var/mob/living/carbon/human/H = hearer
				if(!istype(H.head, src.type))
					if(H.flash_act(intensity=1,length=1 SECONDS))
						INVOKE_ASYNC(H,TYPE_PROC_REF(/mob,emote),"flip")
						INVOKE_ASYNC(H,TYPE_PROC_REF(/mob,emote),"spin")

/obj/item/clothing/suit/jacket/disco
	actions_types = list(/datum/action/item_action/toggle)
	name="Диско костюм"
	desc="Кто вообще станет носить это?"
	var/TimerId
	var/IsPlaying = FALSE
	var/list/MusicList = list(
		sound('newstuff/nikitauou/sound/music/OingoBoingo_ElevatorMan.mp3'),
		sound('newstuff/nikitauou/sound/music/OingoBoingo_WeirdScience.mp3'),
		sound('newstuff/nikitauou/sound/music/OingoBoingo_NoOneLivesForever.mp3'))

/obj/item/clothing/suit/jacket/disco/equipped(mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_OCLOTHING)
		RegisterSignal(user,COMSIG_LIVING_DEATH,PROC_REF(stopmusic))

/obj/item/clothing/suit/jacket/disco/dropped(mob/living/user)
	user.stop_sound_channel(CHANNEL_JUKEBOX)
	if(TimerId)
		deltimer(TimerId)
	stopmusic()
	..()

/obj/item/clothing/suit/jacket/disco/proc/stopmusic()
	IsPlaying = FALSE
	usr.stop_sound_channel(CHANNEL_JUKEBOX)
	UnregisterSignal(usr,COMSIG_LIVING_DEATH)

/obj/item/clothing/suit/jacket/disco/proc/playmusic(mob/user)
	if(IsPlaying)
		if(TimerId)
			deltimer(TimerId)
		var/sound/CurrentlyPlaying = pick(MusicList)
		CurrentlyPlaying.channel = CHANNEL_JUKEBOX
		var/CurrentSongLen = rustg_sound_length(CurrentlyPlaying.file)
		SEND_SOUND(user,CurrentlyPlaying)
		to_chat(user,text=num2text(CurrentSongLen))
		TimerId = addtimer(CALLBACK(src,PROC_REF(playmusic),list(user)),CurrentSongLen+2 SECONDS,TIMER_STOPPABLE|TIMER_LOOP)


/obj/item/clothing/suit/jacket/disco/ui_action_click(mob/user, actiontype)
	. = ..()
	if(!IsPlaying)
		IsPlaying = TRUE
		SEND_SOUND(user,'sound/items/pen_click.ogg')
		playmusic(user)

	else
		IsPlaying = FALSE
		SEND_SOUND(loc,'sound/items/pen_click.ogg')
		user.stop_sound_channel(CHANNEL_JUKEBOX)
		deltimer(TimerId)


/obj/item/clothing/suit/jacket/disco/proc/flash()
	playsound(loc,'newstuff/nikitauou/sound/peppino-taunt.mp3',50,TRUE)
	var/list/hearers = get_hearers_in_view(view_radius = DEFAULT_MESSAGE_RANGE, source=src)
	for (var/mob/hearer in hearers)
		if(ishuman(hearer))
			if(hearer != src.loc)
				var/mob/living/carbon/human/H = hearer
				if(!istype(H.head, src.type))
					if(H.flash_act(intensity=1,length=1 SECONDS))
						INVOKE_ASYNC(H,TYPE_PROC_REF(/mob,emote),"flip")
						INVOKE_ASYNC(H,TYPE_PROC_REF(/mob,emote),"spin")

/obj/item/clothing/suit/jacket/disco/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	flash()
	return TRUE
