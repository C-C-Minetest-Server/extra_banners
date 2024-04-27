-- extra_banners/init.lua
-- Colored variant of large banner
-- Copyright (C) 2015-2024  Pierre-Yves Rollo (pyrollo) and contributors
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = minetest.get_translator("extra_banners")
local mat = xcompat.materials

local banners = {
    blue_large_sign = {
        description = S("Blue Large Banner"),
        from = "signs_road:blue_sign",
        dye = mat.dye_blue,
        font_color = "#fff",
        front_tile = "extra_banners_blue.png",
        inventory_image = "signs_road_blue.png",
    },
    green_large_sign = {
        description = S("Green Large Banner"),
        from = "signs_road:green_sign",
        dye = mat.dye_green,
        font_color = "#fff",
        front_tile = "extra_banners_green.png",
        inventory_image = "signs_road_green.png",
    },
    yellow_large_sign = {
        description = S("Yellow Large Banner"),
        from = "signs_road:yellow_sign",
        dye = mat.dye_yellow,
        font_color = "#fff",
        front_tile = "extra_banners_yellow.png",
        inventory_image = "signs_road_yellow.png",
    },
    red_large_sign = {
        description = S("Red Large Banner"),
        from = "signs_road:red_sign",
        dye = mat.dye_red,
        font_color = "#000",
        front_tile = "extra_banners_red.png",
        inventory_image = "signs_road_red.png",
    },
}

for name, data in pairs(banners) do
    signs_api.register_sign("extra_banners", name, {
        depth = 1 / 16,
        width = 64 / 16,
        height = 12 / 16,
        entity_fields = {
            maxlines = 1,
            color = data.font_color,
        },
        node_fields = {
            visual_scale = 1,
            description = data.description,
            tiles = { "signs_road_sides.png", "signs_road_sides.png",
                "signs_road_sides.png", "signs_road_sides.png",
                "signs_road_sides.png", data.front_tile },
            inventory_image = data.inventory_image,
            use_texture_alpha = "clip",
            groups = { large_banner = 1 },
        },
    })

    minetest.register_craft({
        type = "shapeless",
        output = "extra_banners:" .. name,
        recipe = { data.from, data.from, data.from, data.from },
    })

    minetest.register_craft({
        type = "shapeless",
        output = "extra_banners:" .. name,
        recipe = { "group:large_banner", data.dye },
    })
end

do
    local groups = table.copy(minetest.registered_nodes["signs_road:large_street_sign"].groups)
    groups.large_banner = 1
    minetest.override_item("signs_road:large_street_sign", {
        description = S("White Large Banner"),
        groups = groups
    })

    minetest.register_craft({
        type = "shapeless",
        output = "signs_road:large_street_sign",
        recipe = { "group:large_banner", mat.dye_white },
    })
end
