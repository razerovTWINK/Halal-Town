SUBSYSTEM_DEF(time_track)
	name = "Time Tracking"
	wait = 100
	flags = SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT

	var/time_dilation_current = 0

	var/time_dilation_avg_fast = 0
	var/time_dilation_avg = 0
	var/time_dilation_avg_slow = 0

	var/first_run = TRUE

	var/last_tick_realtime = 0
	var/last_tick_byond_time = 0
	var/last_tick_tickcount = 0

/datum/controller/subsystem/time_track/Initialize()
	last_tick_realtime = REALTIMEOFDAY
	last_tick_byond_time = world.time
	last_tick_tickcount = world.time/world.tick_lag
	first_run = TRUE
	GLOB.glide_size_multiplier = 1.0
	return ..()

/datum/controller/subsystem/time_track/fire()

	var/current_realtime = REALTIMEOFDAY
	var/current_byondtime = world.time
	var/current_tickcount = world.time/world.tick_lag

	if (!first_run && (current_realtime - last_tick_realtime <= 150))
		var/tick_drift = max(0, (((current_realtime - last_tick_realtime) - (current_byondtime - last_tick_byond_time)) / world.tick_lag))

		time_dilation_current = tick_drift / (current_tickcount - last_tick_tickcount) * 100

		time_dilation_avg_fast = MC_AVERAGE_FAST(time_dilation_avg_fast, time_dilation_current)
		time_dilation_avg = MC_AVERAGE(time_dilation_avg, time_dilation_avg_fast)
		time_dilation_avg_slow = MC_AVERAGE_SLOW(time_dilation_avg_slow, time_dilation_avg)
		// Intentionally do NOT derive GLOB.glide_size_multiplier from the tick
		// ratio here. It used to jump between 0.75 and 1.25 every 10 seconds;
		// DELAY_TO_GLIDE_SIZE() reads it on every step, so walking visibly sped
		// up and slowed down while move_delay stayed constant. Time dilation is
		// still measured/recorded above as telemetry; glide stays deterministic
		// at 1.0 now that step delays are aligned to whole ticks (TICK_ALIGN_DELAY).
	else
		first_run = FALSE
		GLOB.glide_size_multiplier = 1.0
	last_tick_realtime = current_realtime
	last_tick_byond_time = current_byondtime
	last_tick_tickcount = current_tickcount
	SSblackbox.record_feedback("associative", "time_dilation_current", 1, list("[SQLtime()]" = list("current" = "[time_dilation_current]", "avg_fast" = "[time_dilation_avg_fast]", "avg" = "[time_dilation_avg]", "avg_slow" = "[time_dilation_avg_slow]")))
