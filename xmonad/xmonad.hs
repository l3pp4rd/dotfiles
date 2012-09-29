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
    rightBar <- spawnPipe $ myRightBar width
    xmonad $ withUrgencyHook dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }
           $ defaultConfig
        {
          terminal      = "urxvtc"
        , modMask       = mod1Mask
        , layoutHook    = avoidStruts $ myLayoutHook
        , keys          = newKeys
        , logHook       = dynamicLogWithPP $ myDzenPP dzenPipe
        , manageHook    = myManageHook
        , workspaces    = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        }
        `additionalKeysP` [
        ("C-<Space>", windows W.focusDown)
        , ("M-S-l",   sendMessage NextLayout) -- next layout
        , ("M-o",   spawn "~/.dotfiles/scripts/path_dmenu")
        , ("M-p",   spawn "~/.dotfiles/scripts/path_dmenu")
        , ("<XF86AudioRaiseVolume>",  spawn "amixer -q set Master 2+ unmute")
        , ("<XF86AudioLowerVolume>",  spawn "amixer -q set Master 2- unmute")
        , ("<XF86AudioMute>",  spawn "amixer -q set Master toggle")
        , ("M-r",   spawn "urxvt -e ranger")
        , ("M-m",   spawn "urxvt")
        , ("M-e",   spawn "~/.dotfiles/scripts/email/check_mailbox.sh ~/accounts.dat")
        , ("M-a",   spawn "urxvt -e alsamixer")
        , ("M-S-t", spawn "urxvt -e ~/.tmux/menu")
        , ("M-S-b", spawn "firefox")
        , ("M-s",   spawn "urxvt -e ~/.scripts/music ui")
        , ("M-t",   spawn "urxvt -e ~/.scripts/music toggle")
        , ("M-w",   spawn "urxvt -e wicd-curses")
        , ("C-m",   spawn "~/.dotfiles/scripts/touchpad_toggle")
        , ("M-C-r", spawn "killall dzen2 && xmonad --recompile && xmonad --restart")
        , ("M-S-p", spawn "~/.dotfiles/scripts/screenshot")           -- Take a screenshot
        ]


myLayoutHook = noBorders (Full ||| Accordion)

-- http://www.chipstips.com/?p=488
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "Pidgin"         --> doF (W.shift "2")
    , className =? "Skype"          --> doF (W.shift "2")
    , className =? "Thunderbird"    --> doF (W.shift "9")
    , className =? "Firefox"        --> doF (W.shift "1")
    , manageDocks
    ] <+> manageHook defaultConfig

-- Taken from http://www.haskell.org/haskellwiki/Xmonad/Config_archive/And1%27s_xmonad.hs
-- TODO: https://leohart.wordpress.com/2011/02/20/pomodoro-technique-for-xmonad-users/
-- Color, font and iconpath definitions:
myFont = "InconsolataSansMono:size=11"

myDzenFGColor = "#839496"
myDzenBGColor = "#073642"
myDzenHeight = "18"


myRightBarWidth = 620
myPomodoroBarWidth = 0

-- To read for flexible width: https://bbs.archlinux.org/viewtopic.php?pid=907346#p907346
myStatusBar :: Double -> String
myStatusBar screenWidth = "dzen2 -x '" ++ show myPomodoroBarWidth ++ "' -y '0' -w '" ++ show (screenWidth - (myRightBarWidth + myPomodoroBarWidth)) ++ "' -h '" ++ myDzenHeight ++ "' -ta 'l' -fg '" ++ myDzenFGColor ++ "' -bg '" ++ myDzenBGColor ++ "' -fn '" ++ myFont ++ "' -p -e ''"

myRightBar :: Double -> String
myRightBar screenWidth = "~/.dotfiles/scripts/dzen_status | dzen2 -x '" ++ show (screenWidth - myRightBarWidth) ++ "' -w '" ++ show (myRightBarWidth) ++ "' -y '0' -h '" ++ myDzenHeight ++ "' -ta 'r' -fg '" ++ myDzenFGColor ++ "' -bg '" ++ myDzenBGColor ++ "' -fn '" ++ myFont ++ "' -p -e''"

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

