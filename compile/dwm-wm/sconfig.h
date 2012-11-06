/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]             = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";
static const char normbordercolor[]  = "#cccccc";
static const char normbgcolor[]      = "#cccccc";
static const char normfgcolor[]      = "#000000";
static const char selbordercolor[]   = "#0066ff";
static const char selbgcolor[]       = "#0066ff";
static const char selfgcolor[]       = "#ffffff";
static const char* colors[][ColLast] = {
    /* border          foreground   background         use */
    { normbordercolor, normfgcolor, normbgcolor },  /* normal */
    { normbordercolor, "#ff0000",   normbgcolor },  /* error */
    { normbordercolor, "#276CC2",   normbgcolor },  /* delim */

    { normbordercolor, "#e0b020",   normbgcolor },  /* artist */
    { normbordercolor, "#e06000",   normbgcolor },  /* title */
    { normbordercolor, "#b10000",   normbgcolor },  /* hot */
    { normbordercolor, "#b15c00",   normbgcolor },  /* medium */
    { normbordercolor, "#6cb100",   normbgcolor },  /* cool */
};
static const unsigned int borderpx   = 0;    /* border pixel of windows */
static const unsigned int snap       = 0;   /* snap pixel */
static const double shade            = 0.9;  /* opacity of unfocussed clients */
static const unsigned int gappx      = 0;    /* gap between clients */
static const Bool showbar            = True; /* False means no bar */
static const Bool topbar             = True; /* False means bottom bar */
static const Bool monobar            = True; /* Draw selected window title not inverse */
static const Bool barline            = True; /* Draw a single line below the statusbar */
static const int nmaster             = 1;    /* default number of clients in the master area */

static const Bool systray_enable     = True; /* Provide a Systray */
static const int systray_spacing     = 1;    /* Pixel between Systray Symbols */

#include "bitmaps.h"

char sstrings[][30] = {
    "^[f276CC2;|^[f;",
    "^[f276CC2;·^[f;",
};

static const Rule rules[] = {
    /* class            instance               title        tags mask     isfloating   monitor  opacity  panel   scratchpad */
    { "Gimp",           NULL,                  NULL,        0,            True,        -1,       -1,     False,  False },
    { "Firefox",        NULL,                  NULL,        1 << 8,       False,       -1,        2,     False,  False }, /* opacity is always 1 when 2 */
    { "URxvt",          NULL,                  NULL,        0,            False,       -1,      0.98,    False,  False }, /* opacity between 0 and 1 overrides default maximum */

    { "DWM-TAG1",       NULL,                  NULL,        1 << 0,       False,       -1,       -1,     False,  False },
    { "DWM-TAG2",       NULL,                  NULL,        1 << 1,       False,       -1,       -1,     False,  False },
    { "DWM-TAG3",       NULL,                  NULL,        1 << 2,       False,       -1,       -1,     False,  False },
    { "DWM-TAG4",       NULL,                  NULL,        1 << 3,       False,       -1,       -1,     False,  False },
    { "DWM-TAG5",       NULL,                  NULL,        1 << 4,       False,       -1,       -1,     False,  False },
    { "DWM-TAG6",       NULL,                  NULL,        1 << 5,       False,       -1,       -1,     False,  False },
    { "DWM-TAG7",       NULL,                  NULL,        1 << 6,       False,       -1,       -1,     False,  False },
    { "DWM-TAG8",       NULL,                  NULL,        1 << 7,       False,       -1,       -1,     False,  False },
    { "DWM-TAG9",       NULL,                  NULL,        1 << 8,       False,       -1,       -1,     False,  False },

    { "stalonetray",    NULL,                  NULL,        ~0,           True,        -1,      1.6,     True,   False }, /* opacity is static when between 1 and 2 */
    { NULL,             "dwm-scratchpad",      NULL,        ~0,           True,        -1,      0.8,     False,  1  } /* multiple scratchpads are possible, just number them */
};

/* layout(s) */
static const float mfact             = 0.55;       /* factor of master area size [0.05..0.95] */
static const Bool resizehints        = True;       /* True means respect size hints in tiled resizals */
static const float attachmode        = AttAsFirst; /* Attach Mode */

/* addons: layouts */
#include "layouts/nbstack.c"       /* bottom stack (tiling) */
#include "layouts/bstackhoriz.c"   /* bottom stack (tower like stack)  */
#include "layouts/grid.c"          /* regular grid */
#include "layouts/gaplessgrid.c"   /* best fitting grid */
#include "layouts/fibonacci.c"     /* spiral like arrangement */

static const Layout layouts[] = {
    /* symbol     gap?    arrange */
    { "[]=",      True,   ntile },       /* Tiled (first entry is default) */
    { "><>",      False,  NULL },        /* Floating */
    { "[M]",      False,  monocle },     /* Monocle */
    { "TTT",      True,   nbstack },     /* Bottom Stack */
    { "###",      True,   gaplessgrid }, /* Non Regular Grid */
    { "+++",      True,   grid },        /* Regular Grid */
    { "===",      True,   bstackhoriz }, /* Bottom Stack with horizontal Stack */
    { "(@)",      True,   spiral },      /* Spiral (like Tiled, but ordered like in golden ratio */
    { "[\\]",     True,   dwindle },     /* Dwindle (Like Spiral, but inverted */
};

/* tagging */
static const Tag tags[] = {
    /* name layout         mfact, showbar, topbar, attachmode, nmaster */
    { "1", &layouts[3],    0.65,  -1,      -1,     -1,         -1 },
    { "2", &layouts[2],     -1,   -1,      -1,     AttBelow,   -1 },
    { "3", &layouts[8],     -1,   -1,      -1,     AttAside,   -1 },
    { "4", &layouts[1],     -1,   -1,      -1,     -1,         -1 },
    { "5", &layouts[0],     -1,   -1,      -1,     -1,         -1 },
    { "6", &layouts[0],     -1,   -1,      -1,     -1,         -1 },
    { "7", &layouts[0],     -1,   -1,      -1,     -1,         -1 },
    { "8", &layouts[0],     -1,   -1,      -1,     -1,         -1 },
    { "9", &layouts[0],     -1,   -1,      -1,     -1,         -1 },
};

/* addons: other */
#include "other/togglemax.c"
#include "other/push.c"

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/zsh", "-c", cmd, NULL } }

/* commands */
static const char *dmenu_cmd[] = { "/bin/zsh", "-c", "/home/gedi/scripts/path_dmenu", NULL };
static const char *term_cmd[]  = { "urxvtc", "-e", "zsh", "-c", "tmux", NULL };
static const char *sleep_cmd[]  = { "/bin/zsh", "-c", "'sudo /usr/sbin/pm-suspend'", NULL };
static const char *email_cmd[]  = { "/bin/zsh", "-c", "'/home/gedi/scripts/email/check_mailbox.sh /home/gedi/accounts.dat'", NULL };
static const char *alsa_cmd[]  = { "urxvtc", "-e", "amixer", NULL };
static const char *ranger_cmd[]  = { "urxvtc", "-e", "ranger", NULL };
static const char *touchpad_toggle_cmd[] = { "/bin/zsh", "-c", "/home/gedi/scripts/touchpad_toggle", NULL };
static const char *print_screen_cmd[] = { "scrot", "'%Y-%m-%d-%H%M%S_$wx$h.png'", "-e", "'mv $f /home/gedi/images/screenshots'", NULL };
static const char *print_screen_area_cmd[] = { "sleep 0.2;", "scrot", "'%Y-%m-%d-%H%M%S_$wx$h.png'", "-e", "'mv $f /home/gedi/images/screenshots'", "-s", NULL };

static Key keys[] = {
    /* modifier                     key        function        argument */
    // command shortcuts
    { MODKEY,                       XK_r,       spawn,          {.v = dmenu_cmd } },
    { MODKEY,                       XK_t,       spawn,          {.v = term_cmd } },
    { MODKEY,                       XK_s,       spawn,          {.v = sleep_cmd } },
    { MODKEY,                       XK_e,       spawn,          {.v = email_cmd } },
    { MODKEY,                       XK_a,       spawn,          {.v = alsa_cmd } },
    { MODKEY,                       XK_w,       spawn,          {.v = ranger_cmd } },
    { 0,                            XK_F12,     spawn,          {.v = touchpad_toggle_cmd } },
    { MODKEY,                       XK_b,       togglebar,      {0} },
    // print screen
    { 0,                            XK_Print,   spawn,          {.v = print_screen_cmd } },
    { ControlMask,                  XK_Print,   spawn,          {.v = print_screen_area_cmd } },
    // window navigation
    { MODKEY,                       XK_j,       focusstack,     {.i = +1 } },
    { MODKEY,                       XK_Tab,     focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,       focusstack,     {.i = -1 } },
    // tiling
    { MODKEY,                       XK_i,       incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_d,       incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,       setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,       setmfact,       {.f = +0.05} },
    // layout actions
    { MODKEY,                       XK_Return,  zoom,           {0} },
    { MODKEY,                       XK_v,       view,           {0} },
    { MODKEY,                       XK_c,       killclient,     {0} },
    { MODKEY|ShiftMask,             XK_m,       setlayout,      {.v = &layouts[0]} },
    { MODKEY|ShiftMask,             XK_t,       setlayout,      {.v = &layouts[1]} },
    { MODKEY|ShiftMask,             XK_f,       setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_space,   setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,   togglefloating, {0} },
    { MODKEY,                       XK_0,       view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,       tag,            {.ui = ~0 } },
    { MODKEY,                       XK_comma,   focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period,  focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,   tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period,  tagmon,         {.i = +1 } },
    // desktop navigation
    TAGKEYS(                        XK_1,                       0)
    TAGKEYS(                        XK_2,                       1)
    TAGKEYS(                        XK_3,                       2)
    TAGKEYS(                        XK_4,                       3)
    TAGKEYS(                        XK_5,                       4)
    TAGKEYS(                        XK_6,                       5)
    TAGKEYS(                        XK_7,                       6)
    TAGKEYS(                        XK_8,                       7)
    TAGKEYS(                        XK_9,                       8)
    // quit X
    { MODKEY|ShiftMask,             XK_q,       quit,           {0} },
    // reload X
    //{ MODKEY|ShiftMask,             XK_r,       reload,         {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = term_cmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

