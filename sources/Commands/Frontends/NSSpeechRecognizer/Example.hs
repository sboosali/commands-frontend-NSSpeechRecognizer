{-# OPTIONS_GHC -fno-warn-missing-signatures #-} -- to test inference
module Commands.Frontends.NSSpeechRecognizer.Example where
import NSSpeechRecognizer()

{-|
@
stack build && stack exec -- example-commands-frontends-NSSpeechRecognizer
@
-}
main :: IO ()
main = do
 putStrLn "(Commands.Frontends.NSSpeechRecognizer.Example...)"

