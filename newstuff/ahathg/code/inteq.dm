/obj/structure/sign/flag/inteq
	name = "flag of PMC InteQ"
	desc = "Коричнево-Оранжевый флаг с щитом по центру. Флаг пахнет кровью."
	icon = 'newstuff/ahathg/icons/inteq_flag.dmi'
	icon_state = "full"
	var/datum/proximity_monitor/advanced/demoraliser/demotivator

/obj/item/sign/flag/inteq
	name = "folded flag of the PMC InteQ"
	desc = "Сложенный флаг ЧВК 'InteQ'."
	icon = 'newstuff/ahathg/icons/inteq_flag.dmi'
	icon_state = "mini"
	sign_path = /obj/structure/sign/flag/inteq

/obj/item/poster/random_inteq
	name = "random InteQ poster"
	poster_type = /obj/structure/sign/poster/contraband/inteq/random
	icon_state = "poster_inteq"

/obj/item/storage/box/inteq_box/posters
	name = "InteQ Posters Box"
	desc = "Каробочка. Крутая."

/obj/item/storage/box/inteq_box/posters/PopulateContents()
	new	/obj/item/poster/random_inteq(src)
	new	/obj/item/poster/random_inteq(src)
	new	/obj/item/poster/random_inteq(src)
	new	/obj/item/poster/random_inteq(src)
	new	/obj/item/poster/random_inteq(src)
	new	/obj/item/poster/random_inteq(src)
	new	/obj/item/poster/random_inteq(src)

/obj/structure/sign/poster/contraband/inteq/random
	name = "random contraband poster"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband/inteq

/obj/structure/sign/poster/contraband/inteq/inteq_recruitment
	name = "InteQ Recruitment"
	desc = "Увидь Галактику! Заработай денег! Вступай сегодня!"
	icon = 'newstuff/ahathg/icons/poster.dmi'
	icon_state = "poster_inteq"

/obj/structure/sign/poster/contraband/inteq/inteq_sign
	name = "InteQ poster"
	desc = "Частная Военная Компания, занимающаяся обороной частных предприятий и выполнением заказов."
	icon = 'newstuff/ahathg/icons/poster.dmi'
	icon_state = "poster_inteq_baza"

/obj/structure/sign/poster/contraband/inteq/inteq_better_dead
	name = "Better Dead!"
	desc = "Сокрушим врагов!"
	icon = 'newstuff/ahathg/icons/poster.dmi'
	icon_state = "poster_inteq_better_dead"

/obj/structure/sign/poster/contraband/inteq/inteq_no_peace
	name = "No peace!"
	desc = "Не имей сто друзей, а имей сто рублей, Вступай в ЧВК 'InteQ'!"
	icon = 'newstuff/ahathg/icons/poster.dmi'
	icon_state = "poster_inteq_no_love"

/obj/structure/sign/poster/contraband/inteq/inteq_no_sex
	name = "No SEX"
	desc = "Хватит дрочить, вступай в ЧВК 'InteQ'!"
	icon = 'newstuff/ahathg/icons/poster.dmi'
	icon_state = "poster_inteq_no_sex"

/obj/structure/sign/poster/contraband/inteq/inteq_vulp
	name = "InteQ Recruitment"
	desc = "Коричневый постер. На нём написано: 'Даже если ты дрочишь на фелинидов, вступай в ЧВК 'InteQ'. Сокрушим врагов вместе!'."
	icon = 'newstuff/ahathg/icons/poster.dmi'
	icon_state = "poster_inteq_vulp"