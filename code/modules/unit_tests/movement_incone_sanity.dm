/datum/mock_client
	var/list/hidden_images = list()

/datum/unit_test/movement_incone_sanity/Run()
	if(MIN_GLIDE_SIZE != 1)
		Fail("MIN_GLIDE_SIZE is [MIN_GLIDE_SIZE], expected 1")
	if(MAX_GLIDE_SIZE != world.icon_size)
		Fail("MAX_GLIDE_SIZE is [MAX_GLIDE_SIZE], expected [world.icon_size]")

	// config.txt (FPS/TICKLAG) must not silently downgrade the 60 FPS world:
	// a runtime tickrate change desyncs SSinput/SSincone, move delays and glide_size.
	var/configured_fps = CONFIG_GET(number/fps)
	// BYOND quantizes tick_lag to 0.01: FPS 60 => tick_lag 0.16, reported as 63 FPS.
	// Allow that tolerance; a real desync (e.g. TICKLAG 0.5 => 20 FPS) is far larger.
	var/expected_tick_lag = 10 / configured_fps
	var/tick_diff = world.tick_lag - expected_tick_lag
	if(tick_diff > 0.02 || tick_diff < -0.02)
		Fail("world tick_lag ([world.tick_lag], [world.fps] FPS) does not match configured [configured_fps] FPS (expected about [expected_tick_lag]); check FPS/TICKLAG in config/config.txt")

	var/prev_fps = world.fps
	world.fps = 60
	var/calculated = DELAY_TO_GLIDE_SIZE(2)
	var/calculated_3 = DELAY_TO_GLIDE_SIZE(3)
	world.fps = prev_fps

	if(calculated >= 3.0)
		Fail("DELAY_TO_GLIDE_SIZE(2) at 60 FPS clamped prematurely: got [calculated], expected ~2.67")
	if(calculated < 2.5 || calculated > 2.8)
		Fail("DELAY_TO_GLIDE_SIZE(2) out of expected range (2.5 to 2.8): got [calculated]")

	if(calculated_3 < 1.6 || calculated_3 > 1.9)
		Fail("DELAY_TO_GLIDE_SIZE(3) out of expected range (1.6 to 1.9): got [calculated_3]")

	// Movement delays must land on a whole tick, otherwise steps alternate
	// between N and N+1 ticks and holding a movement key feels jerky.
	var/aligned_walk = TICK_ALIGN_DELAY(3)
	var/aligned_ticks = aligned_walk / world.tick_lag
	if(abs(aligned_ticks - round(aligned_ticks)) > 0.001)
		Fail("TICK_ALIGN_DELAY(3) = [aligned_walk] is not a whole number of ticks ([aligned_ticks])")
	if(aligned_walk < 3)
		Fail("TICK_ALIGN_DELAY(3) shortened the walk delay to [aligned_walk]")

	if(!(SSincone.flags & SS_TICKER))
		Fail("SSincone does not have SS_TICKER flag: flags = [SSincone.flags]")

	if(!(SSincone.runlevels & RUNLEVEL_LOBBY))
		Fail("SSincone does not have RUNLEVEL_LOBBY in runlevels")
	if(!(SSincone.runlevels & RUNLEVEL_GAME))
		Fail("SSincone does not have RUNLEVEL_GAME in runlevels")

	if(!SStime_track.initialized)
		Fail("SStime_track is not initialized")

	// SStime_track must not oscillate this at runtime: DELAY_TO_GLIDE_SIZE()
	// reads it on every step, so a changing multiplier makes walking visibly
	// speed up and slow down while the step delay stays constant.
	if(GLOB.glide_size_multiplier != 1.0)
		Fail("GLOB.glide_size_multiplier is [GLOB.glide_size_multiplier], expected a fixed 1.0")

	var/mob/living/L = new(run_loc_bottom_left)
	var/datum/mock_client/MC = new
	var/image/test_img = image(loc = L)
	test_img.glide_size = 1
	MC.hidden_images += test_img
	L.client = MC

	L.set_glide_size(5)
	if(test_img.glide_size != 5)
		Fail("set_glide_size failed to update hidden_images glide_size: got [test_img.glide_size], expected 5")

	MC.hidden_images += null
	L.set_glide_size(8)
	if(test_img.glide_size != 8)
		Fail("set_glide_size failed with null image in hidden_images")

	L.setDir(EAST)
	L.update_vision_cone()

	var/datum/preferences/test_pref = new /datum/preferences(null)
	if(!test_pref)
		Fail("Failed to instantiate preferences without client")
	qdel(test_pref)

	L.client = null
	qdel(test_img)
	qdel(MC)
	if(Master && Master.sleep_delta != 1)
		Fail("Master.sleep_delta is [Master.sleep_delta], expected 1")

	var/list/test_keys_held = list()
	test_keys_held["W"] = world.time
	test_keys_held["Ctrl"] = world.time
	if(!test_keys_held["Ctrl"])
		Fail("test_keys_held Ctrl should be truthy when set")
	test_keys_held["Ctrl"] = FALSE
	test_keys_held -= "Ctrl"
	if(test_keys_held["Ctrl"])
		Fail("test_keys_held Ctrl should be falsy after release")
	test_keys_held["W"] = FALSE
	test_keys_held -= "W"
	if(test_keys_held.len != 0)
		Fail("test_keys_held len should be 0 after releasing all keys, got [test_keys_held.len]")

	qdel(L)
