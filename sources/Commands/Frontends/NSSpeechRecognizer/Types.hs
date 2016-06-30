{-|

-}
module Commands.Frontends.NSSpeechRecognizer.Types where
import Commands.Frontends.NSSpeechRecognizer.Extra()

--import NSSpeechRecognizer

import Commands.Frontends.Types (Frontend)

type FrontendNSSpeechRecognizer = Frontend 

{-old

type FrontendNSSpeechRecognizer = Frontend Recognizer [String] 

-}
