-- ui vars
-- ~~~~~~~
-- ui variables that help theme/init.lua define its properties
-- NOTE:
-- line the returned table, will probably be overwritten by scripts its better not to add/remove 
-- lines above line 16

return {
    -- >> font
    -- * font which which will be used by this setup
    -- * spaces, font size, font-properties are not required
    font = "Roboto",
    titlebar_position = "bottom",
    -- >> gaps
    -- * window gaps, the padding of the opened client(window)
    gaps = 5,
    -- >> border_width
    -- * window border width
    border_width = 2,
    -- >> round_corners
    -- * rounded_corner radius for everything!
    -- * set to 0 for sharp edges
    round_corners = 15,
    bar_size = 54,
    -- >> color_scheme
    -- * variable used to define the current accent/color.
    -- * posibble strings: "grey", "blue", "pink", "green"
    -- * "pink" and "green" are light-themes
    -- * whereas, "blue" and "grey" are dark.
    color_scheme = "dark",
}
