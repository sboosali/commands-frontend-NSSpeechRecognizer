{-|

-}
module Commands.Frontends.NSSpeechRecognizer
 ( module Commands.Frontends.NSSpeechRecognizer
 , module Commands.Frontends.NSSpeechRecognizer.Types
 , module NSSpeechRecognizer
 , module Commands.Frontends.Types
 ) where

import Commands.Frontends.NSSpeechRecognizer.Extra
import Commands.Frontends.NSSpeechRecognizer.Types

import NSSpeechRecognizer
import Commands.Frontends.Types

--import Control.Monad
--import Control.Concurrent hiding (yield)
import Control.Concurrent.STM

{-|

Outputs:

* a producer of recognitions
* a handle to the speech engine (for disabling, updating vocabulary, etc.)

NOTE 'NSSpeechRecognizer' only activates (i.e 'rHandler' begins getting called) once 'beginRunLoop' is called. 'beginRunLoop' must be called on the main thread (TODO issue), and it maintains control (like 'forever').

e.g. see "Commands.Frontends.NSSpeechRecognizer.Example" for an example that
updates the speech recognizer state via recognitions themselves.

-}
frontendNSSpeechRecognizer :: RecognizerState -> IO (FrontendNSSpeechRecognizer, P'NSSpeechRecognizer)
frontendNSSpeechRecognizer rState = do
  channel <- newTChanIO
  let rHandler = channelRecognitionHandler channel

  let recognizer = Recognizer {rState, rHandler}
  h_recognizer <- newNSSpeechRecognizer recognizer

  let fRecognitions = channel2producer channel
  return (Frontend{..}, h_recognizer)

{-old

frontendNSSpeechRecognizer :: FrontendNSSpeechRecognizer
frontendNSSpeechRecognizer = Frontend{..}
 where
 fRecognitions = do
   recognition <- respond Nothing

-}
