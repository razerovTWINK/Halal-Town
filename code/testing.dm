#ifdef TESTING
	#define FASTLOAD
	#define DEPLOY_TEST
//	#define ROGUEWORLD
#endif

// FASTBUILD uses the small test map (158 KB instead of 770 KB).
// Map size is the main factor in world initialization time.
#ifdef FASTBUILD
	#define FASTLOAD
#endif

// FORCE_MAP may already be defined by code/rt.dm or _compile_options.dm.
// Undefine it first to avoid a macro redefinition warning.
#undef FORCE_MAP
#ifdef FASTLOAD
	#define FORCE_MAP "_maps/roguetest.json"
#else
	#define FORCE_MAP "_maps/roguetown.json"
#endif

//#define WARTIME
