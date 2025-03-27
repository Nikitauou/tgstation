///WONDERFULL NIKITKABUILD PAINSYSTEM (TOTALLY ORIGINAL) the most painfull thing in the entire codebase!™
///How pain is measured:
///10 is about as painful as stubbing a toe, 25 is about as painful as getting stabbed by a knife and 100 is about as painful as getting beaten to death

/datum/pain
	//How painful it is?
	var/magnitude = 10
	//How fast the pain will fall off? (Every tick magnitude gets substracted by decay, once magnitude reaches 0 it gets deleted)
	var/decay = 1
	//Will it decay?
	var/temporary = TRUE

/datum/pain/New(magnitude = 10,decay = 1,temporary = TRUE)
	src.magnitude = magnitude
	src.decay = decay
	src.temporary = temporary

/mob/living/carbon/human/proc/add_pain(magnitude=10,decay=1,temporary=TRUE)
	var/datum/pain/pd = new /datum/pain(magnitude,decay,temporary)
	pain_datums += pd
	return pd

/mob/living/carbon/human/proc/remove_pain(var/datum/pain/pain_datum)
	pain_datums -= pain_datum

/mob/living/carbon/human/proc/handle_pain()
	substractpain()

///Updates pain on mob, only call if you want to update pain, but not to update hud for some reason, otherwise - use updatehealth()
/mob/living/carbon/human/proc/updatepain()
	var/limb_pain = 0
	var/organ_pain = 0
	var/datums_pain = 0
	var/wounds_pain = 0

	for(var/obj/item/bodypart/limb in bodyparts)
		if(!limb.can_feel_pain)
			continue
		limb_pain += limb.get_damage()

	for(var/obj/item/organ/organ in organs)
		if(!organ.can_feel_pain)
			continue
		organ_pain += organ.damage

	for(var/datum/pain/pain_datum in pain_datums)
		datums_pain += pain_datum.magnitude

	current_pain = clamp(((limb_pain + (organ_pain/3) + datums_pain + wounds_pain)-current_painkillers*10)/current_painkillers,0,pain_threshold)

	///All the effects of pain
	// if(current_pain >= pain_threshold/1.7 && prob(min(current_pain/20,5)) && COOLDOWN_FINISHED(src,pain_itemdrop_cd))
	// 	COOLDOWN_START(src,pain_itemdrop_cd,10 SECONDS)
	// 	var/obj/item/I = get_active_held_item()
	// 	if(I)
	// 		dropItemToGround(I)
	// 		to_chat(src,span_danger("Из-за боли у тебя из рук выпадает [I]!"))
	// 		balloon_alert(src,"Предмет выпал!")
	// 	INVOKE_ASYNC(src,PROC_REF(emote),"scream")
	// 	flash_pain(current_pain*2)

	// if(current_pain >= pain_threshold/1.5 && prob(min(current_pain/25,5)) && COOLDOWN_FINISHED(src,pain_paralyze_cd))
	// 	COOLDOWN_START(src,pain_paralyze_cd,10 SECONDS)
	// 	to_chat(src,span_danger("Ты падаешь на пол из-за боли!"))
	// 	Paralyze(current_pain/3)
	// 	flash_pain(current_pain*2)

	// if(current_pain >= pain_threshold/1.2 && prob(min(current_pain/30,5)) && COOLDOWN_FINISHED(src,pain_sleep_cd))
	// 	COOLDOWN_START(src,pain_sleep_cd,10 SECONDS)
	// 	to_chat(src,span_danger("Боль настолько сильна, что ты теряешь сознание!"))
	// 	Unconscious(current_pain/3)

	last_pain = current_pain

///SHOULD NOT BE CALLED DIRECTLY, ONLY USED BY carbon/life PROC TO SUBSTRACT PAIN DATUMS AND TO SUBSTRACT current_painkillers.
/mob/living/carbon/human/proc/substractpain()
	var/doupdate = FALSE
	for(var/datum/pain/pain_datum in pain_datums)
		if(pain_datum.temporary)
			pain_datum.magnitude -= pain_datum.decay
			doupdate = TRUE
		if(pain_datum.magnitude <= 0)
			pain_datums -= pain_datum
			qdel(pain_datum)
	if(doupdate)
		updatehealth()

/mob/proc/flash_pain(intensivity)
	intensivity = clamp(intensivity,0,255)
	var/atom/movable/screen/fullscreen/pain/pain_overlay = overlay_fullscreen("pain",/atom/movable/screen/fullscreen/pain)
	animate(pain_overlay, alpha = intensivity, time = 10, easing = ELASTIC_EASING)
	animate(alpha = 0, time = 10)
	spawn(20)
		clear_fullscreen("pain",null)

/atom/movable/screen/fullscreen/pain
	icon = 'newstuff/nikitauou/icons/overlay.dmi'
	icon_state = "pain_flash"
	alpha = 0

/obj/item/pain_tester
	name="PAIN TESTER"
	desc="PAIN IS REAL"

/obj/item/pain_tester/attack_self(mob/user, modifiers)
	. = ..()
	var/mob/living/carbon/human/mobcheg = user
	mobcheg.add_pain(10,1,TRUE)
	// mobcheg.flash_pain(100)
	to_chat(mobcheg,"PAIN ADDED")
