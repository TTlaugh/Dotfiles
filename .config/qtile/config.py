import os
from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Rule, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from time import sleep
@hook.subscribe.startup_once
def start_once():
    sleep(1)

#######################
#----- Variables -----#
#######################
mod = "mod4"
mod1 = "mod1"
terminal = guess_terminal()
myterm = "alacritty"
mybrowser = "chromium"

#########################
#----- Keybindings -----#
#########################
keys = [
# Launch terminal
    #Key([mod], "Return",    lazy.spawn(myterm)),
    Key([mod], "Return",                lazy.spawn(terminal)),
# Launcher
    Key([mod, "shift"], "o",            lazy.spawn("dmenu_run")),
    Key([mod], "o",                     lazy.spawn("rofi -show drun")),
    Key([mod], "w",                     lazy.spawn("rofi -show window")),
# Launch my browser
    Key([mod, "shift"], "Return",       lazy.spawn(mybrowser)),
# Lock screen (with 'lockscreen' script)
    Key([mod], "Escape",                lazy.spawn("lockscreen")),
# Switch to next/previous layout
    Key([mod], "Tab",                   lazy.next_layout()),
    Key([mod, "shift"], "Tab",          lazy.prev_layout()),
# Kill window
    Key([mod], "q",                     lazy.window.kill()),
# Prompt
    Key([mod], "r",                     lazy.spawncmd()),
# Restart/Shutdown Qtile
    Key([mod, "shift"], "r",            lazy.restart()),
    Key([mod, "shift"], "q",            lazy.shutdown()),
# Move focus
    Key([mod], "h",                     lazy.layout.left()),
    Key([mod], "l",                     lazy.layout.right()),
    Key([mod], "j",                     lazy.layout.next(), lazy.layout.down().when(layout='bsp')),
    Key([mod], "k",                     lazy.layout.up()),
# Move window
    Key([mod, "shift"], "h",            lazy.layout.shuffle_left(),
                                        lazy.layout.move_left().when(layout='treetab')),
    Key([mod, "shift"], "l",            lazy.layout.shuffle_right(),
                                        lazy.layout.move_right().when(layout='treetab')),
    Key([mod, "shift"], "j",            lazy.layout.shuffle_down(),
                                        lazy.layout.section_down().when(layout='treetab')),
    Key([mod, "shift"], "k",            lazy.layout.shuffle_up(),
                                        lazy.layout.section_up().when(layout='treetab')),
# Resize window
    Key([mod, "control"], "h",          lazy.layout.grow_left(),
                                        lazy.layout.shrink()),
    Key([mod, "control"], "l",          lazy.layout.grow_right(),
                                        lazy.layout.grow()),
    Key([mod, "control"], "j",          lazy.layout.grow_down()),
    Key([mod, "control"], "k",          lazy.layout.grow_up()),
# window control
    Key([mod], "space",                 lazy.group.next_window()),
    Key([mod, "control"], "space",      lazy.window.bring_to_front()),
    Key([mod, "shift"], "space",        lazy.window.toggle_floating(), lazy.window.center()),
    Key([mod, "control"], "f",          lazy.window.toggle_fullscreen()),
    Key([mod], "i",                     lazy.layout.rotate(),
                                        lazy.layout.flip()),
    Key([mod, "shift"], "s",            lazy.layout.toggle_split()),
    Key([mod], "n",                     lazy.layout.normalize()),
    Key([mod], "m",                     lazy.layout.maximize()),

# Sound (pamixer)
    Key([], "XF86AudioRaiseVolume",     lazy.spawn("pamixer -i 5"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume",     lazy.spawn("pamixer -d 5"), desc="Decrease volume"),
    Key([], "XF86AudioMute",            lazy.spawn("pamixer -t"),   desc="Mute"),

    # Key([mod, "shift"], "equal",        lazy.spawn("pamixer -i 5"), desc="Increase volume"),
    # Key([mod, "shift"], "minus",        lazy.spawn("pamixer -d 5"), desc="Decrease volume"),
    # Key([mod, "shift"], "m",            lazy.spawn("pamixer -t"),   desc="Mute"),

# Backlight
    Key([], "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc 10"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec 10"), desc="Decrease brightness"),

# Dunst
    Key([mod], "BackSpace",             lazy.spawn("dunstctl close"),       desc="Close notification"),
    Key([mod, "shift"], "BackSpace",    lazy.spawn("dunstctl close-all"),   desc="Close all notifications"),
    Key([mod], "backslash",             lazy.spawn("dunstctl history-pop"), desc="Show history notifications"),

# Moc control
    Key([mod1, "control"], "s", lazy.spawn("sh -c 'mocp -S && mocp -p || mocp -p'")),
    Key([mod1, "control"], "x", lazy.spawn("mocp -x")),
    Key([mod1, "control"], "t", lazy.spawn("mocp -G")),
    Key([mod1, "control"], "n", lazy.spawn("mocp -f")),
    Key([mod1, "control"], "p", lazy.spawn("mocp -r")),
    Key([mod1, "control"], "m", lazy.spawn(myterm + ' -e mocp')),

# Open Neomutt
    Key([mod, "shift"], "n", lazy.spawn(myterm + ' -e neomutt')),

# Screenshot (script)
    Key([], "Print",                    lazy.spawn("screenshot"),          desc="Take fullscreen capture"),
    Key(["shift"], "Print",             lazy.spawn("screenshot selected"), desc="Capture selected area"),

# Dmenu scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord([mod], "p", [
        Key([],        "p", lazy.spawn("dmmaim"),        desc='dmenu: Take screenshot with maim'),
        Key([],        "k", lazy.spawn("dmkill"),        desc='dmenu: Kill processes'),
        Key([],        "m", lazy.spawn("dmmount"),       desc='dmenu: Mount drive'),
        Key(["shift"], "m", lazy.spawn("dmunmount"),     desc='dmenu: Unmount drive'),
        Key([],        "b", lazy.spawn("dmsetbg"),       desc='dmenu: Set background'),
        Key([],        "w", lazy.spawn("dmwifi"),        desc='dmenu: Connect to wifi'),
        Key([],        "t", lazy.spawn("dmtranslate"),   desc='dmenu: Translate using Google-Translate'),
        Key([],        "c", lazy.spawn("dmcalc"),        desc='dmenu: Simple calculator'),
        Key([],        "i", lazy.spawn("dmicons"),       desc='dmenu: Copy icons to clipboard'),
        Key([],        "r", lazy.spawn("dmrecord"),      desc='dmenu: Record'),
        Key(["shift"], "r", lazy.spawn("dmrecord kill"), desc='dmenu: Kill existing recording of dmrecord'),
        Key([],        "e", lazy.spawn("dmeditconf"),    desc='dmenu: Edit selected file'),
        Key([],        "s", lazy.spawn("dmwebsearch"),   desc='dmenu: Search in web browser'),
        Key([],        "q", lazy.spawn("dmpower"),       desc='dmenu: Power action')
    ]),

]

###################
#----- Group -----#
###################
#groups = [Group(i) for i in "123456789"]

groups = [Group(i,label='') for i in "asdfg"]

for i in groups:
    keys.extend([
        # mod + letter of group = switch to group
        # Toggle with the last used group:
        # Key([mod], i.name, lazy.group[i.name].toscreen(toggle=True),
            # desc="Switch to group {}".format(i.name)),
        # Or not toggle with the last used group:
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            # desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])

####################
#----- Layout -----#
####################
layout_theme = {"border_width": 2,
                "margin": 5,
                "border_focus": "#2ac3de",
                "border_normal": "#44475a",
                }
layouts = [
    layout.MonadTall(**layout_theme, new_client_position = 'top', ratio = 0.6),
    layout.Max(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Bsp(**layout_theme, border_on_single = True),
    layout.TreeTab(
         font = "Ubuntu Nerd Font",
         fontsize = 10,
         sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
         section_fontsize = 10,
         border_width = 2,
         bg_color = "1c1f24",
         active_bg = "bb9af7",
         active_fg = "000000",
         inactive_bg = "a9a1e1",
         inactive_fg = "1c1f24",
         padding_left = 0,
         padding_x = 0,
         padding_y = 5,
         section_top = 10,
         section_bottom = 20,
         level_shift = 8,
         vspace = 3,
         panel_width = 200
         ),
    # Try more layouts by unleashing below layouts.
    #layout.Columns(**layout_theme),
    #layout.Stack(num_stacks=2, **layout_theme),
    #layout.Tile(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    #layout.Slice(**layout_theme),
]

#####################
#----- Widgets -----#
#####################
widget_defaults = dict(
    font='Ubuntu Nerd Font bold',
    fontsize=12,
    padding=4,
    background="#151924",
)
extension_defaults = widget_defaults.copy()

def upper_left_triangle(bg_color, fg_color):
    return widget.TextBox(
        text=' ',
        padding=0,
        fontsize=20,
        background=bg_color,
        foreground=fg_color)
def upper_right_triangle(bg_color, fg_color):
    return widget.TextBox(
        text=' ',
        padding=0,
        fontsize=20,
        background=bg_color,
        foreground=fg_color)

def init_widgets_list():
    widgets_list = [
        widget.TextBox(
                text = "",
                foreground = "#73daca",
                background = "#414868",
                padding = 10,
                mouse_callbacks = {'Button1': lazy.spawn('rofi -show drun')},
                ),
        widget.CurrentLayoutIcon(
                custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                scale = 0.7,
                background = "#414868",
                mouse_callbacks = {'Button3': lazy.prev_layout()},
                ),
        upper_left_triangle("#373d57", "#414868"),
        widget.CPU(
                format = ' {load_percent}%',
                foreground = "#7dcfff",
                background = "#373d57",
                mouse_callbacks = {'Button1': lazy.spawn(myterm + ' -e htop')},
                ),
        upper_left_triangle("#2e3347", "#373d57"),
        widget.Memory(
                measure_mem = 'G',
                format = ' {MemUsed:.2f}{mm}',
                foreground = "#f7768e",
                background = "#2e3347",
                ),
        upper_left_triangle("#232736", "#2e3347"),
        widget.DF(
                format = ' {uf}{m}',
                visible_on_warn = False,
                foreground = "#ff9e64",
                background = "#232736",
                ),
        upper_left_triangle("#1c202e", "#232736"),
        widget.Prompt(
                font = "sans bold",
                prompt = 'Run: ',
                padding = 10,
                foreground = "#50fa7b",
                background = "#1c202e",
                ),
        widget.GroupBox(
                font = "sans",
                fontsize = 15,
                disable_drag = True,
                borderwidth = 2,
                padding_y = 1,
                padding = 5,
                background = "#1c202e",
                active = "#7dcfff",
                inactive = "#44475a",
                highlight_method = "text",
                this_current_screen_border = "#ff9e64",
                this_screen_border = "#434758",
                other_current_screen_border = "#ff9e64",
                other_screen_border = "#434758",
                ),
        upper_left_triangle("#151924", "#1c202e"),
        widget.WindowName(
                font = "sans",
                foreground = "#565f89",
                ),
        widget.Sep(
                linewidth = 0,
                padding = 10,
                background = "#151924",
                ),
        upper_right_triangle("#151924", "#1c202e"),
        widget.CheckUpdates(
                update_interval = 1800,
                distro = "Arch_checkupdates",
                display_format = " {updates}",
                colour_have_updates = "#b4f9c6",
                background = "#1c202e",
                mouse_callbacks = {'Button1': lazy.spawn(myterm + ' -e sudo pacman -Syu')},
                ),
        upper_right_triangle("#1c202e", "#24283b"),
        widget.Battery(
                format = "{char} BAT {percent:2.0%}",
                discharge_char = "",
                charge_char    = "",
                full_char      = "",
                empty_char     = "",
                unknown_char   = "",
                low_percentage = 0.2,
                show_short_text = False,
                low_foreground = "#ff5555",
                background = "#24283b",
                foreground = "#9ece6a",
                ),
        upper_right_triangle("#24283b", "#2e3347"),
        widget.PulseVolume(
                limit_max_volume = True,
                update_interval = 0.0,
                fmt = 'Vol {}',
                foreground = "#b4f9f8",
                background = "#2e3347",
                ),
        widget.Sep(
                size_percent = 70,
                foreground = "#a9b1d6",
                background = "#2e3347",
                ),
        widget.Backlight(
                backlight_name = "intel_backlight",
                format = "Bri {percent:2.0%}",
                foreground = "#b4f9f8",
                background = "#2e3347",
                ),
        upper_right_triangle("#2e3347", "#373d57"),
        widget.Clock(
                format='%a, %B %d - %H:%M',
                foreground = "#7dcfff",
                background = "#373d57",
                ),
        upper_right_triangle("#373d57", "#414868"),
        widget.TextBox(
                fontsize = 14,
                text = "",
                foreground = "#f7768e",
                background = "#414868",
                padding = 10,
                mouse_callbacks = {'Button1': lazy.spawn(["sh", "-c", "~/.config/qtile/scripts/powermenu"])},
                ),
    ]
    return widgets_list

####################
#----- Screen -----#
####################
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

#def init_widgets_screen2():
    #widgets_screen2 = init_widgets_list()
    #del widgets_screen2[7:8]
    #return widgets_screen2

def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=23, margin=[2, 80, 0, 10],))
        #Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20))
    ]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    #widgets_screen2 = init_widgets_screen2()

###################
#----- Mouse -----#
###################
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2",
        lazy.window.bring_to_front())
]

###################
#----- Other -----#
###################
dgroups_key_binder = None

dgroups_app_rules = [
    #Rule(Match(wm_class=['Chromium']), group="1"), 
    #Rule(Match(wm_class=['Alacritty']), group="2"), 
] # type: List

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    #Match(wm_class='confirmreset'),   # gitk
    #Match(wm_class='makebranch'),     # gitk
    #Match(wm_class='maketag'),        # gitk
    #Match(wm_class='ssh-askpass'),    # ssh-askpass
    #Match(title='branchdialog'),      # gitk
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
], **layout_theme)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wmname = "LG3D"
