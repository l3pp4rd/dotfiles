import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.EwmhDesktops
import XMonad.Config.Desktop
import System.IO

-- initially created with help of: http://www.haskell.org/haskellwiki/Xmonad/Config_archive/John_Goerzen%27s_Configuration
-- use "xmonad --recompile" to check it's syntactically correct if making changes (better than just modQ)
    -- list of key codes http://haskell.org/haskellwiki/Xmonad/Key_codes
    -- may also prove useful for some keys and commands http://hackage.haskell.org/packages/archive/X11/1.4.5/doc/html/Graphics-X11-Types.html
        -- may want to encorporate: http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-GridSelect.html
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "pidgin"    --> doFloat
    , className =? "skype"     --> doFloat
    , className =? "vlc"       --> doFloat
    , className =? "guake"     --> doFloat
    ]
--[ "sleep 1 && /usr/bin/tint2 /home/gedi/.config/tint2/tint2rc"
--                        , "percellite -d"
--                        , "volumeicon"
--                        , "tidybattery"
--                        ]
main = do
    xprocm <- spawnPipe "sleep 1 && /usr/bin/tint2 /home/gedi/.config/tint2/tint2rc"
    xmonad $ ewmh desktopConfig
        { manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook desktopConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , terminal = "urxvt"
        , borderWidth = 0
        } `additionalKeys`
        [ ((mod4Mask, xK_F4), spawn "close")
        , ((mod4Mask, xK_f), spawn "firefox")
        , ((mod4Mask, xK_F6), spawn "xkill")
        , ((mod4Mask, xK_t), spawn "thunar")
        , ((mod4Mask, xK_o), sendMessage ToggleStruts) -- toggle panel visability.
        , ((mod4Mask .|. controlMask, xK_o), spawn "pkill tint2 && tint2") -- restart panel.
        , ((mod4Mask, xK_p), spawn "dmenu_run")
        , ((mod4Mask, xK_q), spawn "xmonad --restart")
        , ((0, xK_Print), spawn "scrot '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f ~/images/screenshots/ &amp; gpicview ~/images/screenshots/$f'")
        ]
