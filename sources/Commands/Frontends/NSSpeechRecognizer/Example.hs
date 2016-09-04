{-# OPTIONS_GHC -fno-warn-missing-signatures #-} -- to test inference
module Commands.Frontends.NSSpeechRecognizer.Example where
import Commands.Frontends.NSSpeechRecognizer

import Pipes (liftIO,Consumer,await,runEffect,(>->))

import Control.Concurrent (forkIO)
import Control.Monad (forever)

{-|
@
stack build && stack exec -- example-commands-frontend-NSSpeechRecognizer
@
-}
main :: IO ()
main = do
 putStrLn "(Commands.Frontends.NSSpeechRecognizer.Example...)"

 (Frontend{..}, p'NSSpeechRecognizer) <- frontendNSSpeechRecognizer asleepState
 -- initialize speech engine

 _ <- forkIO $ do
     runEffect $ fRecognitions >-> useRecognition p'NSSpeechRecognizer
     -- (push-based composition)

 beginRunLoop
 -- activate speech engine

 where
 asleepVocabulary = ["start listening"]
 awakeVocabulary  = ["stop listening" , "hello world"] -- and 1000 more
 asleepState = defaultRecognizerState { rVocabulary = asleepVocabulary }
 awakeState  = defaultRecognizerState { rVocabulary = awakeVocabulary  }

 useRecognition :: P'NSSpeechRecognizer -> Consumer String IO r
 useRecognition p'NSSpeechRecognizer = forever $ do
  recognition <- await
  liftIO $ putStr "[recognized] "
  liftIO $ putStrLn recognition
  -- print each recognition

  case recognition of
  -- toggle between the two vocabularies {asleepVocabulary} and {awakeVocabulary}, upon recognizing "_ listening"

    "start listening" -> do
      liftIO $ p'NSSpeechRecognizer `pokeRecognizerState` awakeState
      -- wake up

    "stop listening"  -> do
      liftIO $ p'NSSpeechRecognizer `pokeRecognizerState` asleepState --TODO thread-safety
      -- go back to sleep

    _ -> return ()
      -- (unreachable)

