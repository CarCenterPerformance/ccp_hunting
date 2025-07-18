Config = {}

-- Erlaubte Waffen
Config.AllowedWeapons = {
    [`WEAPON_KNIFE`] = true,
    [`WEAPON_DAGGER`] = true
}

-- Tiermodelle und die Items, die sie geben
Config.Animals = {
    [`a_c_deer`] = {
        items = {
            {item = "fleisch", count = 3},
            {item = "leder", count = 1}
        }
    },
    [`a_c_cow`] = {
        items = {
            {item = "meat_beef", count = 5},
            {item = "skin_leather", count = 2}
        }
    },
    [`a_c_boar`] = {
        items = {
            {item = "fleisch", count = 4},
            {item = "leder", count = 1}
        }
    }
}
