import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Run (spawnPipe)

import System.Exit (exitSuccess)
import Control.Monad (void)

import qualified XMonad.StackSet as W

import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (killAll)

myTerminal = "alacritty"
myBrowser  = "firefox"

-- TODO: Missing keybindings:
-- - PrintScr -> flameshot gui
-- - Super + PrintScr -> flameshot full -c
-- - Super + Escape -> Turn off computer script
-- - Super + Display -> Monitor selection script
-- - Super + Enter -> Open with same CWD as focused window
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

	, ("<XF86AudioMute>",        spawn "amixer set Master toggle")
	, ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
	, ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
	, ("<XF86AudioMicMute>",     spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
  ]

-- TODO: Turn into module
-- Inspiration: https://github.com/srid/nixos-config/tree/master/features/desktopish/xmonad/xmonad-srid
main :: IO ()
main = do
	-- TODO Put logging of xmobar into logHook
	-- https://gitlab.com/dwt1/dotfiles/-/blob/master/.xmonad/xmonad.hs#L531-535
	void $ spawnPipe $ "xmobar $HOME/.config/nixpkgs/xmobarrc"
	xmonad $ def
		{ terminal = myTerminal
		, modMask = mod4Mask
		} `additionalKeysP` myKeys
