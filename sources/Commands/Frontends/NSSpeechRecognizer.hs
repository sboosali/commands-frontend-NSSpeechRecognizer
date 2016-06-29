module Commands.Frontends.NSSpeechRecognizer
 ( module Commands.Frontends.NSSpeechRecognizer
 , module Commands.Frontends.NSSpeechRecognizer.Types
 ) where

import Commands.Frontends.NSSpeechRecognizer.Types

import NSSpeechRecognizer

import Control.Monad
import Control.Concurrent

hang = forever $
   threadDelay 1000000

 -- = do

 -- let rState = defaultRecognizerState {rVocabulary = ["start listening","stop listening"]}

 -- let rHandler = printerHandler

 -- let recognizer = Recognizer {rState, rHandler}

 -- recognizer_pointer <- newNSSpeechRecognizer recognizer

 -- beginCurrentRunLoop -- NOTE the NSRunLoop *must* be run on the main thread, It seems
