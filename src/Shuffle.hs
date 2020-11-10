module Shuffle (run) where

import Control.Monad.Except (MonadError)
import Control.Monad.Random.Class (MonadRandom)
import qualified Data.Text as Text
import Fmt
import Shuffle.Config (Config)
import qualified Shuffle.Config as Config
import qualified Shuffle.Display as Display
import Shuffle.Group (Group)
import qualified Shuffle.Group as Group
import qualified Shuffle.List as List
import Shuffle.Person (Person)
import System.IO (hPutStrLn)
import System.Random.Shuffle (shuffleM)

type Error = String

newtype App a = App
  {runApp :: ExceptT Error IO a}
  deriving
    ( Functor,
      Applicative,
      Monad,
      MonadRandom,
      MonadIO,
      MonadError String
    )

run :: IO ()
run = do
  result <- runExceptT $ runApp loadConfigAndGroup
  printResult result
  exitResult result

loadConfigAndGroup :: (MonadError Error m, MonadRandom m, MonadIO m) => m ()
loadConfigAndGroup = Config.fromFile "config.json" >>= runReaderT shuffleAndGroup

shuffleAndGroup :: (MonadReader Config m, MonadRandom m, MonadIO m) => m ()
shuffleAndGroup =
  allPeople
    >>= shuffleM
    >>= splitIntoGroups
    >>= printGroups

-- Grouping

allPeople :: (MonadReader Config m) => m [Person]
allPeople = Config.people <$> ask

peoplePerGroup :: (MonadReader Config m) => m Int
peoplePerGroup = Config.peoplePerGroup <$> ask

splitIntoGroups :: (MonadReader Config m) => [Person] -> m [Group]
splitIntoGroups people = do
  count <- peoplePerGroup
  return $ Group.new <$> List.chunksOf count people

-- Display

printGroups :: (MonadIO m) => [Group] -> m ()
printGroups = putStrLn . Text.unpack . Display.groupsToString

putErrStrLn :: String -> IO ()
putErrStrLn = hPutStrLn stderr

-- Result

printResult :: Either Error () -> IO ()
printResult (Right _) = return ()
printResult (Left err) = putErrStrLn $ "Error reading config: " +| err |+ ""

exitResult :: Either e a -> IO ()
exitResult (Right _) = exitSuccess
exitResult (Left _) = exitFailure
