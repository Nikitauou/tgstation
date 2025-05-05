//Blueshield

//Uniform items are in command.dm

/obj/item/radio/headset/headset_bs
	name = "\proper the blueshield's headset"
	icon = 'newstuff/ahathg/code/blueshield/icons/radio.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/ears.dmi'
	icon_state = "bshield_headset"
	worn_icon_state = "bshield_headset"
	keyslot = /obj/item/encryptionkey/heads/blueshield
	keyslot2 = /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/headset_bs/alt
	icon_state = "bshield_headset_alt"
	worn_icon_state = "bshield_headset_alt"

/obj/item/radio/headset/headset_bs/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/clothing/head/helmet/space/plasmaman/blueshield
	name = "blueshield envirosuit helmet"
	desc = "A plasmaman containment helmet designed for certified blueshields, who's job guarding heads should not include self-combustion... most of the time."
	icon = 'newstuff/ahathg/code/blueshield/icons/plasmaman_hats.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/plasmaman_headM.dmi'
	icon_state = "bs_envirohelm"

/obj/item/clothing/under/plasmaman/blueshield
	name = "blueshield envirosuit"
	desc = "A plasmaman containment suit designed for certified blueshields, offering a limited amount of extra protection."
	icon = 'newstuff/ahathg/code/blueshield/icons/plasmaman.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/plasmamanM.dmi'
	icon_state = "bs_envirosuit"
	armor_type = /datum/armor/clothing_under/under_plasmaman_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/datum/armor/clothing_under/under_plasmaman_blueshield
	melee = 10
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/head/beret/blueshield
	name = "blueshield's beret"
	desc = "A blue beret made of durathread with a genuine golden badge, denoting its owner as a Blueshield Lieuteneant. It seems to be padded with nano-kevlar, making it tougher than standard reinforced berets."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3A4E7D#DEB63D"
	icon_state = "beret_badge"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/beret/blueshield/navy
	name = "navy blueshield's beret"
	desc = "A navy-blue beret made of durathread with a silver badge, denoting its owner as a Blueshield Lieuteneant. It seems to be padded with nano-kevlar, making it tougher than standard reinforced berets."
	greyscale_colors = "#3C485A#BBBBBB"

/obj/item/storage/backpack/blueshield
	name = "blueshield backpack"
	desc = "A robust backpack issued to Nanotrasen's finest."
	icon = 'newstuff/ahathg/code/blueshield/icons/backpacks.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/back.dmi'
	lefthand_file = 'newstuff/ahathg/code/blueshield/icons/backpack_lefthand.dmi'
	righthand_file = 'newstuff/ahathg/code/blueshield/icons/backpack_righthand.dmi'
	icon_state = "backpack_blueshield"
	inhand_icon_state = "backpack_blueshield"

/obj/item/storage/backpack/satchel/blueshield
	name = "blueshield satchel"
	desc = "A robust satchel issued to Nanotrasen's finest."
	icon = 'newstuff/ahathg/code/blueshield/icons/backpacks.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/back.dmi'
	lefthand_file = 'newstuff/ahathg/code/blueshield/icons/backpack_lefthand.dmi'
	righthand_file = 'newstuff/ahathg/code/blueshield/icons/backpack_righthand.dmi'
	icon_state = "satchel_blueshield"
	inhand_icon_state = "satchel_blueshield"

/obj/item/storage/backpack/duffelbag/blueshield
	name = "blueshield duffelbag"
	desc = "A robust duffelbag issued to Nanotrasen's finest."
	icon = 'newstuff/ahathg/code/blueshield/icons/backpacks.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/back.dmi'
	lefthand_file = 'newstuff/ahathg/code/blueshield/icons/backpack_lefthand.dmi'
	righthand_file = 'newstuff/ahathg/code/blueshield/icons/backpack_righthand.dmi'
	icon_state = "duffel_blueshield"
	inhand_icon_state = "duffel_blueshield"

//blueshield armor
/obj/item/clothing/suit/armor/vest/blueshield
	icon = 'newstuff/ahathg/code/blueshield/icons/armor.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/armorM.dmi'
	name = "blueshield's armor"
	desc = "A tight-fitting kevlar-lined vest with a blue badge on the chest of it."
	icon_state = "blueshieldarmor"
	body_parts_covered = CHEST

/obj/item/clothing/suit/armor/vest/blueshield/jacket
	name = "blueshield's jacket"
	desc = "An expensive kevlar-lined jacket with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks."
	icon_state = "blueshield"
	body_parts_covered = CHEST|ARMS
	unique_reskin = null

/obj/item/clothing/suit/armor/vest/blueshield/jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/mod/control/pre_equipped/blueshield
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/worn_praetorian.dmi'
	icon = 'newstuff/ahathg/code/blueshield/icons/praetorian.dmi'
	icon_state = "praetorian-control"
	theme = /datum/mod_theme/blueshield
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/holster,
	)

/obj/item/clothing/neck/mantle/bsmantle
	name = "\proper the blueshield's mantle"
	desc = "A plated mantle with command colors. Suitable for the one assigned to making sure they're still breathing."
	icon = 'newstuff/ahathg/code/blueshield/icons/neck.dmi'
	worn_icon = 'newstuff/ahathg/code/blueshield/icons/neck.dmi'
	icon_state = "bsmantle"

/obj/item/storage/backpack/messenger/blueshield
	name = "blueshield's messenger bag'"
	desc = "A robust messenger bag issued to Nanotrasen's finest guard dogs, with extra TACTICAL POCKETS. Whatever that even means."
	icon_state = "messenger_blueshield"
	inhand_icon_state = "messenger_blueshield"

