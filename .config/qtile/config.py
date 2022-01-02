import os
import subprocess
from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


#######################
#----- Variables -----#
#######################
mod = "mod4"
terminal = guess_terminal()
myterm = "alacritty"
mybrowser = "chromium"

#####################
#----- Startup -----#
#####################
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

#####################
#----- Hotkeys -----#
#####################
keys = [
# Launch terminal
    # Key([mod], "Return",    lazy.spawn(myterm)),
    Key([mod], "Return",                lazy.spawn(terminal)),
    Key([mod], "o",                     lazy.spawn("dmenu_run")),
# Show all keybindings
    Key([mod, "shift"], "b",            lazy.spawn(terminal+" -e sh -c '$HOME/.config/qtile/kb.py | less'")),
# Launch my browser
    Key([mod, "shift"], "Return",       lazy.spawn(mybrowser)),
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
    Key([mod], "j",                     lazy.layout.next()),
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
    Key([mod, "shift"], "space",        lazy.window.toggle_floating()),
    Key([mod], "f",                     lazy.window.toggle_fullscreen()),
    Key([mod], "i",                     lazy.layout.rotate(),
                                        lazy.layout.flip()),
    Key([mod, "shift"], "s",            lazy.layout.toggle_split()),
    Key([mod], "n",                     lazy.layout.normalize()),
    Key([mod], "m",                     lazy.layout.maximize()),

# Sound (pamixer)
    Key([mod, "shift"], "equal",        lazy.spawn("pamixer -i 5"), desc="Increase volume"),
    Key([mod, "shift"], "minus",        lazy.spawn("pamixer -d 5"), desc="Decrease volume"),
    Key([mod, "shift"], "m",            lazy.spawn("pamixer -t"),   desc="Decrease volume"),
# Dunst
    Key([mod], "BackSpace",             lazy.spawn("dunstctl close"),       desc="Close notification"),
    Key([mod, "shift"], "BackSpace",    lazy.spawn("dunstctl close-all"),   desc="Close all notifications"),
    Key([mod], "backslash",             lazy.spawn("dunstctl history-pop"), desc="Show history notifications"),
# Screenshot (script)
    Key([], "Print",                    lazy.spawn("screenshot"),          desc="Take fullscreen capture"),
    Key(["shift"], "Print",             lazy.spawn("screenshot selected"), desc="Capture selected area"),

# Dmenu scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord([mod], "p", [
        Key([],        "k", lazy.spawn("dmkill"),        desc='Kill processes via dmenu'),
        Key([],        "m", lazy.spawn("dmmount"),       desc='Mount drive via dmenu'),
        Key(["shift"], "m", lazy.spawn("dmunmount"),     desc='Unmount drive via dmenu'),
        Key([],        "b", lazy.spawn("dmsetbg"),       desc='Set background via dmenu'),
        Key([],        "w", lazy.spawn("dmwifi"),        desc='Connect to wifi via dmenu'),
        Key([],        "c", lazy.spawn("dmcalc"),        desc='Simple calculator via dmenu'),
        Key([],        "i", lazy.spawn("dmicons"),       desc='Copy icons to clipboard via dmenu'),
        Key([],        "r", lazy.spawn("dmrecord"),      desc='Record via dmenu'),
        Key(["shift"], "r", lazy.spawn("dmrecord kill"), desc='Kill existing recording of dmrecord'),
        Key([],        "e", lazy.spawn('dmeditconf'),    desc='Edit selected file via dmenu'),
        Key([],        "s", lazy.spawn('dmwebsearch'),   desc='Search in web browser via dmenu'),
        Key([],        "q", lazy.spawn("dmpower"),       desc='Power action via dmenu')
    ])
]

###################
#----- Group -----#
###################
groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        # Toggle with the last used group:
        # Key([mod], i.name, lazy.group[i.name].toscreen(toggle=True),
            # desc="Switch to group {}".format(i.name)),
        # Or not toggle with the last used group:
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            # desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])

####################
#----- Layout -----#
####################
layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "e1acff",
                "border_normal": "1d2330"
                }
layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.Floating(**layout_theme),
    layout.TreeTab(
         font = "Ubuntu",
         fontsize = 10,
         sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
         section_fontsize = 10,
         border_width = 2,
         bg_color = "1c1f24",
         active_bg = "c678dd",
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
    # layout.Tile(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    # layout.Slice(**layout_theme),
]

#####################
#----- Widgets -----#
#####################
widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=4,
    background="#282c34"
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
        widget.CurrentLayoutIcon(
                custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                scale = 0.7,
                padding = 0
                ),
        # widget.CurrentLayout(),
        widget.GroupBox(
                disable_drag = True,
                borderwidth = 2,
                active = "#ffffff",
                inactive = "#44475a",
                highlight_method = "block",
                this_current_screen_border = "#e193f9",
                this_screen_border = "#434758",
                other_current_screen_border = "#e193f9",
                other_screen_border = "#434758"
                ),
        widget.Prompt(
                prompt = 'Run: ',
                foreground = "#50fa7b"
                ),
        widget.Sep(
                linewidth = 0,
                padding = 40
                ),
        widget.WindowName(
                foreground = "#6272a4"
                ),
        widget.Sep(
                linewidth = 0,
                padding = 40
                ),
        # widget.Net(
                # interface = "wlp0s20f0u7",
                # format = '{down}↓↑{up}',
                # foreground = "#f1fa8c"
                # ),
        widget.CPU(
                format = 'cpu: {load_percent}%',
                foreground = "#ff79c6",
                mouse_callbacks = {'Button1': lazy.spawn(myterm + ' -e htop')}
                ),
        widget.Memory(
                measure_mem = 'G',
                format = 'mem: {MemUsed:.2f}{mm}',
                foreground = "#ff5555"
                ),
        widget.DF(
                format = '{p}: {uf}{m}',
                visible_on_warn = False,
                foreground = "#ffb86c"
                ),
        widget.TextBox(
                text = " vol:",
                foreground = "#8be9fd",
                padding = 0
                ),
        widget.Volume(
                foreground = "#8be9fd"
                ),
        widget.CheckUpdates(
                update_interval = 1800,
                distro = "Arch_checkupdates",
                colour_have_updates = "#70ff94",
                mouse_callbacks = {'Button1': lazy.spawn(myterm + ' -e sudo pacman -Syu')}
                ),
        widget.Clock(
                format='%A, %b %d - %H:%M',
                foreground = "#bd93f9"
                ),
        widget.WidgetBox(
                close_button_location = 'right',
                text_open = '',
                text_closed = '',
                foreground = "#44475a",
                widgets=[
                    widget.Wlan(
                        interface = 'wlp0s20f0u7',
                        format = '({essid})'
                        )
                    ]
                ),
        widget.Systray(),
    ]
    return widgets_list

####################
#----- Screen -----#
####################
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

# def init_widgets_screen2():
    # widgets_screen2 = init_widgets_list()
    # del widgets_screen2[7:8]
    # return widgets_screen2

def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))
        # Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20))
    ]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    # widgets_screen2 = init_widgets_screen2()

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
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    # Match(wm_class='confirmreset'),  # gitk
    # Match(wm_class='makebranch'),  # gitk
    # Match(wm_class='maketag'),  # gitk
    # Match(wm_class='ssh-askpass'),  # ssh-askpass
    # Match(title='branchdialog'),  # gitk
    # Match(title='pinentry'),  # GPG key password entry
], **layout_theme)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
