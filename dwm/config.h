#include <X11/XF86keysym.h>
/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 8;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char col_gray0[]       = "#000000";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#aaaaaa";
static const char col_gray4[]       = "#eeeeee";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray0 },
	[SchemeSel]  = { col_gray4, col_gray1, col_gray2  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ NULL,       NULL,       NULL,       0,            0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "|",        tile },    /* first entry is default */
	{ "[ ]",      monocle },
	{ "---",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define ALTKEY Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static const char *brightup[]   = { "brightnessctl", "set", "8%+", NULL };
static const char *brightdown[] = { "brightnessctl", "set", "8%-", NULL };
static const char *volup[]      = { "amixer", "set", "Master", "5%+", NULL };
static const char *voldown[]    = { "amixer", "set", "Master", "5%-", NULL };
static const char *screenshot[] = { "sh", "-c", "scrot -s -e 'xclip -selection clipboard -t image/png -i $f'", NULL };
static const char *terminal[]   = { "x-terminal-emulator", NULL };
static const char *dmenurun[]   = { "dmenu_run", "-l", "5", NULL };
static const char *rofi[]       = { "rofi", "-show", "drun", NULL };
static const char *lockscreen[] = { "slock", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ 0,             XF86XK_MonBrightnessUp,   spawn,          {.v = brightup } },
	{ 0,             XF86XK_MonBrightnessDown, spawn,          {.v = brightdown } },
	{ 0,             XF86XK_AudioRaiseVolume,  spawn,          {.v = volup } },
	{ 0,             XF86XK_AudioLowerVolume,  spawn,          {.v = voldown } },
	{ MODKEY,                       XK_equal,  spawn,          {.v = volup } },
	{ MODKEY,                       XK_minus,  spawn,          {.v = voldown } },
	{ 0,                            XK_Print,  spawn,          {.v = screenshot } },
	{ MODKEY,                       XK_t,      spawn,          {.v = terminal } },
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenurun } },
	{ MODKEY,                       XK_a,      spawn,          {.v = rofi } },
	{ MODKEY,                       XK_l,      spawn,          {.v = lockscreen } },
    
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ ALTKEY,                       XK_Tab,    focusstack,     {.i = +1 } },
	{ ALTKEY|ShiftMask,             XK_Tab,    focusstack,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_Tab,    focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Tab,    focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_Return, setlayout,      {0} },
	{ MODKEY,                       XK_Up,     setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_Down,   setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_Left,   zoom,           {0} },
	{ MODKEY,                       XK_Right,  zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_Up,     incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Down,   incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Left,   setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_Right,  setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask,           XK_Left,   tagmon,         {.i = -1 } },
	{ MODKEY|ControlMask,           XK_Right,  tagmon,         {.i = +1 } },
	{ ALTKEY,                       XK_F4,     killclient,     {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ ControlMask|ALTKEY,           XK_Delete, quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkRootWin,           0,              Button1,        spawn,          {.v = rofi } },
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button4,        setlayout,      {.v = &layouts[0]} },
	{ ClkLtSymbol,          0,              Button5,        setlayout,      {.v = &layouts[1]} },
	{ ClkLtSymbol,          0,              Button2,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        movemouse,      {0} },
	{ ClkWinTitle,          0,              Button2,        killclient,     {0} },
	{ ClkWinTitle,          0,              Button3,        togglefloating, {0} },
	{ ClkWinTitle,          0,              Button5,        focusstack,     {.i = +1 } },
	{ ClkWinTitle,          0,              Button4,        focusstack,     {.i = -1 } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = lockscreen } },
	{ ClkStatusText,        0,              Button4,        spawn,          {.v = volup } },
	{ ClkStatusText,        0,              Button5,        spawn,          {.v = voldown } },
	{ ClkStatusText,        MODKEY,         Button4,        spawn,          {.v = brightup } },
	{ ClkStatusText,        MODKEY,         Button5,        spawn,          {.v = brightdown } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
