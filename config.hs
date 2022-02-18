import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import System.Exit (exitSuccess)

import qualified XMonad.StackSet as W

import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (killAll)

myTerminal = "alacritty"
myBrowser  = "firefox"

myKeys :: [(String, X ())]
myKeys =
  [ ("M-S-r", spawn "xmonad --restart")        -- Restart xmonad
  , ("M-S-q", io exitSuccess)                  -- Quit xmonad

  , ("M-S-c", kill1)                           -- Kill focused window
  , ("M-S-a", killAll)                         -- Kill all windows in workspace

  , ("M-j",   windows W.focusDown)             -- Move to the next window
  , ("M-k",   windows W.focusUp)               -- Move to the prev window
  , ("M-S-j", windows W.swapDown)              -- Swap focused with next
  , ("M-S-k", windows W.swapUp)                -- Swap focused with prev  

  , ("M-d",        spawn "dmenu_run -i -p \"Run: \"") -- Run app picker
  , ("M-<Return>", spawn myTerminal)                  -- Run terminal
  , ("M-w",        spawn myBrowser)                   -- Run browser
  ]

main :: IO ()
main = xmonad $ def 
  { terminal = myTerminal
  , modMask = mod4Mask
  } `additionalKeysP` myKeys
