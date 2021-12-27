import os
import socket
import subprocess

from typing import List  # noqa: F401

from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
# import re
# from libqtile.command import lazy

mod = "mod4"
terminal = guess_terminal()
myterm = "alacritty"

keys = [
    Key([mod], "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
        ),
    Key([mod], "Tab",
        lazy.next_layout(),
        desc="Switch to the next layout"
        ),
    Key([mod, "shift"], "Tab",
        lazy.prev_layout(),
        desc="Switch to the previous layout"
        ),
    Key([mod], "q",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
###
    Key([mod], "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc="Restart Qtile"
        ),
    Key([mod, "shift"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
        ),
###
    Key([mod], "h",
        lazy.layout.left(),
        desc="Move focus to left"
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc="Move focus down"
        ),
    Key([mod], "k",
        lazy.layout.up(),
        desc="Move focus up"
        ),
###
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        lazy.layout.move_left().when(layout='treetab'),
        desc="Move window to the left"
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        lazy.layout.move_right().when(layout='treetab'),
        desc="Move window to the right"
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down().when(layout='treetab'),
        desc="Move window down"
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up().when(layout='treetab'),
        desc="Move window up"
        ),
###
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink().when(layout='monadtall'),
        lazy.layout.decrease_nmaster().when(layout='tile'),
        desc="Grow window to the left"
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow().when(layout='monadtall'),
        lazy.layout.increase_nmaster().when(layout='tile'),
        desc="Grow window to the right"
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        desc="Grow window down"
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        desc="Grow window up"
        ),
###
    Key([mod], "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
        ),
    Key([mod, "shift"], "space",
        lazy.window.toggle_floating(),
        desc='toggle floating'
        ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),
    Key([mod, "shift"], "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"
        ),
    Key([mod, "shift"], "f",
        lazy.layout.rotate().when(layout='stack'),
        lazy.layout.flip().when(layout='monadtall'),
        desc="Switch which side main pane occupies"
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),

    # Sound (pamixer)
    Key([mod, "shift"], "equal",
        lazy.spawn("pamixer -i 5"),
        desc="Increase volume"
        ),
    Key([mod, "shift"], "minus",
        lazy.spawn("pamixer -d 5"),
        desc="Decrease volume"
        ),
    Key([mod, "shift"], "m",
        lazy.spawn("pamixer -t"),
        desc="Decrease volume"
        ),

    # Dunst
    Key([mod], "BackSpace",
        lazy.spawn("dunstctl close"),
        desc="Close notification"
        ),
    Key([mod, "shift"], "BackSpace",
        lazy.spawn("dunstctl close-all"),
        desc="Close all notifications"
        ),
    Key([mod], "backslash",
        lazy.spawn("dunstctl history-pop"),
        desc="Show history notifications"
        ),

    # Screenshot (script)
    Key([], "Print",
        lazy.spawn("screenshot"),
        desc="Take fullscreen capture"
        ),
    Key(["shift"], "Print",
        lazy.spawn("screenshot selected"),
        desc="Capture selected area"
        ),

    # Dmenu scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord([mod], "p", [
        Key([], "k",
            lazy.spawn("dmkill"),
            desc='Kill processes via dmenu'
            ),
        Key([], "m",
            lazy.spawn("dmmount"),
            desc='Mount drive via dmenu'
            ),
        Key(["shift"], "m",
            lazy.spawn("dmunmount"),
            desc='Unmount drive via dmenu'
            ),
        Key([], "b",
            lazy.spawn("dmsetbg ./Wallpapers"),
            desc='Set background via dmenu'
            ),
        Key([], "w",
            lazy.spawn("dmwifi"),
            desc='Connect to wifi via dmenu'
            ),
        Key([], "c",
            lazy.spawn("dmcalc"),
            desc='Simple calculator via dmenu'
            ),
        Key([], "i",
            lazy.spawn("dmicons"),
            desc='Copy icons to clipboard via dmenu'
            ),
        Key([], "r",
            lazy.spawn("dmrecord"),
            desc='Record via dmenu'
            ),
        Key([], "f",
            lazy.spawn("dmvifm 'alacritty -e'"),
            desc='Vifm via dmenu'
            ),
        Key([], "q",
            lazy.spawn("dmpower"),
            desc='Power action via dmenu'
            )
    ]),
    # Launch apps using the key chord SUPER+` followed by 'key'
    KeyChord([mod], "grave", [
        Key([], "1",
            lazy.spawn("chromium"),
            desc='Launch Chromium'
            ),
        Key([], "2",
            lazy.spawn("firefox"),
            desc='Launch Firefox'
            ),
        Key([], "3",
            lazy.spawn("kitty"),
            desc='Launch Kitty'
            )
    ])
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
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

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "e1acff",
                "border_normal": "1d2330"
                }
layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Tile(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
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
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=4,
    background="#282c34"
)
extension_defaults = widget_defaults.copy()

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

def init_widgets_list():
    widgets_list = [
        widget.CurrentLayoutIcon(
                custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                padding = 0,
                scale = 0.7
                ),
        # widget.CurrentLayout(),
        widget.GroupBox(
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
                prompt = prompt,
                foreground = "#00ff44"
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
        widget.CheckUpdates(
                colour_have_updates = "#50fa7b",
                update_interval = 1800,
                distro = "Arch_checkupdates",
                display_format = "{updates} Updates",
                mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myterm + ' -e sudo pacman -Syu')}
                ),
        # widget.Net(
                # foreground = "#f1fa8c",
                # interface = "wlp0s20f0u7",
                # format = '{down}↓↑{up}'
                # ),
        widget.CPU(
                foreground = "#ff79c6",
                format = 'cpu: {load_percent}%',
                mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myterm + ' -e htop')}
                ),
        widget.Memory(
                foreground = "#ff5555",
                measure_mem = 'G',
                format = 'mem: {MemUsed:.2f}{mm}'
                ),
        widget.DF(
                foreground = "#ffb86c",
                format = '{p}: {uf}{m}',
                visible_on_warn = False
                ),
        widget.TextBox(
                foreground = "#8be9fd",
                text = " vol:",
                padding = 0
                ),
        widget.Volume(
                foreground = "#8be9fd"
                ),
        widget.Clock(
                format='%A, %b %d - %H:%M'
                ),
        widget.WidgetBox(
                foreground = "#44475a",
                close_button_location = 'right',
                text_open = '',
                text_closed = '',
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

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
