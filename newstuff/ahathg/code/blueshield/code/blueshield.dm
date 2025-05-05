/datum/job/blueshield
	title = JOB_BLUESHIELD
	description = "Protect heads of staff, get your fancy gun stolen, cry as the captain touches the supermatter."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command and the Nanotrasen Consultant"
	minimal_player_age = 7
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BLUESHIELD"

	outfit = /datum/outfit/job/blueshield
	plasmaman_outfit = /datum/outfit/plasmaman/blueshield
	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	bounty_types = CIV_JOB_SEC

	department_for_prefs = /datum/job_department/security

	departments_list = list(
		/datum/job_department/security,
	)
	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	family_heirlooms = list(/obj/item/bedsheet/captain, /obj/item/clothing/head/beret/blueshield)

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes/cigars/havana = 10,
		/obj/item/stack/spacecash/c500 = 3,
		/obj/item/disk/nuclear/fake/obvious = 2,
		/obj/item/clothing/head/collectable/captain = 4,
	)

	job_flags = STATION_JOB_FLAGS | JOB_CANNOT_OPEN_SLOTS

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	uniform = /obj/item/clothing/under/rank/blueshield
	suit = /obj/item/clothing/suit/armor/vest/blueshield/jacket
	id = /obj/item/card/id/advanced/centcom/station
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_bs/alt
	implants = list(/obj/item/implant/mindshield)
	backpack_contents = list(
		/obj/item/storage/box/rxglasses/spyglasskit,
	)
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffelbag/blueshield
	messenger = /obj/item/storage/backpack/messenger/blueshield
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit_store = /obj/item/gun/energy/laser/hellgun/blueshield

	head = /obj/item/clothing/head/beret/blueshield
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/modular_computer/pda/security

	id_trim = /datum/id_trim/job/blueshield

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield

/*
	Blueshield's Hellfire is between SC-1 and the Hellfire in terms of Damage and wound output
*/

/// Blueshield's Custom Hellfire
/obj/item/ammo_casing/energy/laser/hellfire/blueshield
	projectile_type = /obj/projectile/beam/laser/hellfire
	e_cost = LASER_SHOTS(13, STANDARD_CELL_CHARGE)
	select_name = "maim"

/obj/item/gun/energy/laser/hellgun/blueshield
	name ="modified hellfire laser gun"
	desc = "A lightly overtuned version of NT's Hellfire Laser rifle, scratches showing its age and the fact it has definitely been owned before. This one is more energy efficient without sacrificing damage."
	icon_state = "hellgun"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire/blueshield)

//obj/item/choice_beacon/blueshield
//	name = "gunset beacon"
//	desc = "A single use beacon to deliver a gunset of your choice. Please only call this in your office"
//	company_source = "Sol Defense Contracting"
//	company_message = span_bold("Supply Pod incoming, please stand by.")

///obj/item/choice_beacon/blueshield/generate_display_names()
//	var/static/list/selectable_gun_types = list(
//		"Custom Hellfire Laser Rifle" = /obj/item/gun/energy/laser/hellgun/blueshield,,
//	)
//
//	return selectable_gun_types

/datum/id_trim/job/blueshield
	assignment = "Blueshield"
	trim_icon = 'newstuff/ahathg/code/blueshield/icons/card.dmi'
	trim_state = "trim_blueshield"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CENTCOM_BLUE // Not the other way around. I think.
	sechud_icon_state = SECHUD_CENTCOM
	extra_access = list(
		ACCESS_BRIG,
		ACCESS_CARGO,
		ACCESS_COURT,
		ACCESS_GATEWAY,
		ACCESS_SECURITY,
	)
	minimal_access = list(
		ACCESS_ALL_PERSONAL_LOCKERS,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CENT_GENERAL,
		ACCESS_COMMAND,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_EVA,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SCIENCE,
		ACCESS_TELEPORTER,
		ACCESS_WEAPONS,
		ACCESS_CAPTAIN,
	)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
	)
	job = /datum/job/blueshield

/obj/item/card/id/advanced/centcom/station
	wildcard_slots = WILDCARD_LIMIT_SILVER

/datum/job_department/central_command
	department_name = DEPARTMENT_CENTRAL_COMMAND
	department_bitflags = DEPARTMENT_BITFLAG_CENTRAL_COMMAND
	department_head = /datum/job/captain
	display_order = 1
	label_class = "command"
	ui_color = "#86ff82"

/obj/item/encryptionkey/heads/blueshield
	name = "\proper the blueshield's encryption key"
	icon_state = "cypherkey_centcom"
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_centcom
	greyscale_colors = "#1d2657#dca01b"

/obj/effect/landmark/start/blueshield
	name = "Blueshield"
	icon_state = "Blueshield"
	icon = 'newstuff/ahathg/code/blueshield/icons/landmarks.dmi'

