import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Actions.CycleWS
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import Graphics.X11.ExtraTypes.XF86

import qualified Data.Map as M
import qualified XMonad.StackSet as W

import Dzen (DzenConf(..), TextAlign(..), defaultDzenXft,
                spawnDzen, spawnToDzen, screenWidth)

main = do
    -- Some help from IRC: http://hpaste.org/65912#line8
    width    <- screenWidth 0
    dzenPipe <- spawnPipe $ myStatusBar width
    stalproc <- spawnPipe myStaloneTrayBar
    rightBar <- spawnPipe $ myRightBar width
    xmonad $ withUrgencyHook dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }
           $ defaultConfig
        {
          terminal      = "urxvtc"
        , modMask       = mod1Mask
        , borderWidth   = 0
        , layoutHook    = myLayoutHook
        , keys          = newKeys
        , logHook       = dynamicLogWithPP $ myDzenPP dzenPipe
        , manageHook    = myManageHook
        , workspaces    = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        }
        `additionalKeysP` [
        ("C-<Space>", windows W.focusDown)
        , ("M-S-l", sendMessage NextLayout) -- next layout
        , ("M-o",   spawn "~/scripts/path_dmenu")
        , ("M-p",   spawn "~/scripts/path_dmenu")
        , ("M-s",   spawn "sudo /usr/sbin/pm-suspend")
        , ("M-r",   spawn "urxvt -e ranger")
        , ("M-m",   spawn "urxvt")
        , ("M-c",   kill)  -- close focused window shortcut
        , ("M-e",   spawn "~/scripts/email/check_mailbox.sh ~/accounts.dat")
        , ("M-a",   spawn "urxvt -e alsamixer")
        , ("M-w",   spawn "urxvt -e wicd-curses")
        , ("M-b",   sendMessage $ ToggleStrut U) -- toggle top bar
        , ("C-m",   spawn "~/scripts/touchpad_toggle")
        , ("M-C-r", spawn "killall dzen2 stalonetray && xmonad --recompile && xmonad --restart")
        , ("<Print>", spawn "scrot '%Y-%m-%d-%H%M%S_$wx$h.png' -e 'mv $f ~/images/screenshots'")  -- Take a screenshot
        ]


myLayoutHook = avoidStruts (noBorders Full ||| noBorders tiled) ||| noBorders Full
    where
      -- default tiling algorithm partitions the screen into two panes
      tiled = Tall nmaster delta ratio

      -- The default number of windows in the master pane
      nmaster = 1

      -- Default proportion of screen occupied by master pane
      ratio = 1/2

      -- Percent of screen to increment by when resizing panes
      delta = 3/100

-- http://www.chipstips.com/?p=488
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "Pidgin"         --> doF (W.shift "9")
    , className =? "Skype"          --> doF (W.shift "3")
    , className =? "Thunderbird"    --> doF (W.shift "9")
    , className =? "Firefox"        --> doF (W.shift "1")
    , className =? "stalonetray"    --> doIgnore
    , manageDocks
    ] <+> manageHook defaultConfig

-- Taken from http://www.haskell.org/haskellwiki/Xmonad/Config_archive/And1%27s_xmonad.hs
-- TODO: https://leohart.wordpress.com/2011/02/20/pomodoro-technique-for-xmonad-users/
-- Color, font and iconpath definitions:
myFont = "InconsolataSansMono:size=11"

myBarFGColor = "#839496"
myBarBGColor = "#073642"
myBarHeight = "18"

myRightBarWidth = 620
myStaloneTrayWidth = 190

-- To read for flexible width: https://bbs.archlinux.org/viewtopic.php?pid=907346#p907346
myStatusBar :: Double -> String
myStatusBar screenWidth = "dzen2 -x '" ++ show myStaloneTrayWidth ++ "' -y '0' -w '" ++ show (screenWidth - (myRightBarWidth + myStaloneTrayWidth)) ++ "' -h '" ++ myBarHeight ++ "' -ta 'l' -fg '" ++ myBarFGColor ++ "' -bg '" ++ myBarBGColor ++ "' -fn '" ++ myFont ++ "' -p -e ''"

myRightBar :: Double -> String
myRightBar screenWidth = "~/scripts/dzen_status | dzen2 -x '" ++ show (screenWidth - myRightBarWidth) ++ "' -w '" ++ show (myRightBarWidth) ++ "' -y '0' -h '" ++ myBarHeight ++ "' -ta 'r' -fg '" ++ myBarFGColor ++ "' -bg '" ++ myBarBGColor ++ "' -fn '" ++ myFont ++ "' -p -e''"

-- Stalonetray pipe def
myStaloneTrayBar :: String
myStaloneTrayBar = "stalonetray -f 0 --sticky -bg '" ++ myBarBGColor ++ "' -i 8 -geometry " ++ myBarHeight ++ "x" ++ show (myStaloneTrayWidth) ++ "+0+0 &>/dev/null"

-- Customize the display of xmonad informations
myDzenPP outputPipe =
    defaultPP { ppOutput    = hPutStrLn outputPipe
              -- Only display worspace and discard layout name 'l' and
              -- window title name 't'
              , ppOrder     = \(ws:l:t:_)   -> [ws,t]
              }


newKeys x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) =
    [
    ]

