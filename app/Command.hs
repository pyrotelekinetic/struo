module Command (Options (..), parse) where

import Options.Applicative

data Options = Opts
  { flakeRef :: String
  , mode :: Mode
  , dry :: Bool
  }

data Mode = Switch | Boot | Test
instance Show Mode where
  show Switch = "switch"
  show Boot = "boot"
  show Test = "test"

refP :: Parser String
refP = strArgument
  $ metavar "FLAKE"
  <> help "The flake containing the configuration to build"
  <> value "system"
  <> showDefault

modeP :: Parser Mode
modeP = bootP <|> testP <|> switchP
  where
  bootP = flag' Boot
    $ long "boot"
    <> short 'b'
    <> help "Activate configuration on next boot"
    <> hidden
  testP = flag' Test
    $ long "test"
    <> short 't'
    <> help "Activate configuration after rebuild, but do not link generation"
    <> hidden
  switchP = flag Switch Switch
    $ long "switch"
    <> short 's'
    <> help "Activate configuration after rebuild (Default)"
    <> hidden

dryP :: Parser Bool
dryP = switch
  $ long "dry-run"
  <> short 'd'
  <> help "Show what commands would be run, instead of running them"

optsP :: Parser Options
optsP = Opts <$> refP <*> modeP <*> dryP <**> helper

parse :: IO Options
parse = execParser . info optsP $ fullDesc <> description
  where
  description = progDesc "Build and activate a NixOS configuration."
