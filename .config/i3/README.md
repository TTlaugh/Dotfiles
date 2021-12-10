## Some useful key bindings you might want to use
- See here: [https://faq.i3wm.org/question/3747/enabling-multimedia-keys/?answer=3759#post-id-3759](https://faq.i3wm.org/question/3747/enabling-multimedia-keys/?answer=3759#post-id-3759)

## Theme, cursors, icons
- Arc themes: [https://github.com/horst3180/Arc-theme](https://github.com/horst3180/Arc-theme)
- Cursors themes: [https://www.gnome-look.org/p/1356095](https://www.gnome-look.org/p/1356095)
- Icons themes: [https://www.gnome-look.org/p/1359276](https://www.gnome-look.org/p/1359276)

## Two way to transparent i3bar:
#### 1. You can make i3bar transparency with picom or compton:
```
"75:class_g = 'i3bar'"
```
#### 2. Or you can add this to ~/.config/i3/config:
> NOTE: with this option, all tray icon have a transparent background!
```
bar {
# Use i3bar with transparency
    i3bar_command i3bar --transparency
# Format the color to make it transparent using the last two digits, see below.
    colors {
        background #00000000
        # Change status color to black if you have a white background
        #statusline #000000
        #                  border             background         text
        focused_workspace  #ffffff            #00000000          #ffffff
        inactive_workspace #00000000          #00000000          #676E7D
        urgent_workspace   #E53935            #E53935            #ffffff
        }
}
```
```
i3bar_command i3bar --transparency
```
```
background #00000000
# Change status color to black if you have a white background
#statusline #000000
```
```
focused_workspace  #ffffff            #00000000          #ffffff
inactive_workspace #00000000          #00000000          #676E7D
urgent_workspace   #E53935            #E53935            #ffffff
```
> You can see: [https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4](https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4)

### Optional: You can custom status color in ~/.config/i3/i3status.conf
```
general {
    color_good = "#009e00"
    color_degraded = "#946c00"
    color_bad = "#db0000"
}
```
