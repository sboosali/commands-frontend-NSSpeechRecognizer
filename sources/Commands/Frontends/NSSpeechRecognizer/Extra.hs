module Commands.Frontends.NSSpeechRecognizer.Extra
 ( module Commands.Frontends.NSSpeechRecognizer.Extra
 , module X
 ) where

import Control.DeepSeq as X (NFData)
import Data.Hashable as X (Hashable)
import Data.Semigroup as X (Semigroup)

import GHC.Generics as X (Generic)
import Data.Data as X (Data)

import Control.Arrow as X ((>>>))
import Data.Function as X ((&))
import Data.Foldable as X (traverse_)

import Pipes (Producer, yield)

import Control.Concurrent.STM (TChan,atomically, readTChan)
import Control.Concurrent (threadDelay)
import Control.Monad.IO.Class (liftIO)
import Control.Monad (forever)

nothing :: (Monad m) => m ()
nothing = return ()

maybe2bool :: Maybe a -> Bool
maybe2bool = maybe False (const True)

either2maybe :: Either e a -> Maybe a
either2maybe = either (const Nothing) Just

either2bool :: Either e a -> Bool
either2bool = either (const False) (const True)

channel2producer :: TChan a -> Producer a IO r
channel2producer channel = forever $ do
  a <- liftIO $ atomically $ readTChan channel
  yield a

-- | busy wait, awaken every second.
hang :: IO a
hang = forever $
   threadDelay 1000000

