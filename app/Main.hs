import Command

main :: IO ()
main = parse >>= putStrLn . makeCommand

makeCommand :: Options -> String
makeCommand o = "nixos-rebuild" += show (mode o) += "--flake" += flakeRef o
  where
  a += b = a ++ " " ++ b
