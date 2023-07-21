import System.Process (callCommand)

import Command

main :: IO ()
main = do
  o <- parse
  if dry o
    then print $ makeCommand o
    else callCommand (makeCommand o)

makeCommand :: Options -> String
makeCommand o = "nixos-rebuild" +-+ show (mode o) +-+ "--flake" +-+ flakeRef o
  where
  (+-+) = (++) . (++ " ")
