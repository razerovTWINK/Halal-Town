//The minimum for glide_size to be clamped to.
#define MIN_GLIDE_SIZE 1
//The maximum for glide_size to be clamped to.
//This shouldn't be higher than the icon size, and generally you shouldn't be changing this, but it's here just in case.
#define MAX_GLIDE_SIZE world.icon_size

//This is a global so it can be changed in game, if you want to make this a bit faster you can make it a constant/define directly in the code
//GLOBAL_VAR_INIT(glide_size_multiplier, 1.25)

GLOBAL_VAR_INIT(glide_size_multiplier, 1.0)

///Broken down, here's what this does:
/// divides the world icon_size (32) by delay divided by ticklag to get the number of pixels something should be moving each tick.
/// The division result is given a min value of 1 to prevent obscenely slow glide sizes from being set
/// Then that's multiplied by the global glide size multiplier. 1.25 by default feels pretty close to spot on. This is just to try to get byond to behave.
/// The whole result is then clamped to within the range above.
/// Not very readable but it works
#define DELAY_TO_GLIDE_SIZE(delay) (clamp(((world.icon_size / max((delay) / world.tick_lag, 1)) * GLOB.glide_size_multiplier), MIN_GLIDE_SIZE, MAX_GLIDE_SIZE))

// Snap a movement delay (deciseconds) up to a whole number of server ticks.
// At 60 FPS tick_lag is 0.16, so WALK_DELAY 3 is 18.75 ticks. world.time only
// advances in whole ticks, so an unaligned move_delay makes consecutive steps
// alternate between 18 and 19 ticks: holding a key feels jerky. Aligned delays
// also keep glide_size in sync with the number of ticks per tile.
#define TICK_ALIGN_DELAY(delay) (max(world.tick_lag, CEILING((delay), world.tick_lag)))
