module Shuffle.Config
  ( Config,
    fromFile,
    fromJSON,
    mkConfig,
    peoplePerGroup,
    people,
  )
where

import Control.Monad.Except (MonadError, liftEither)
import Data.Aeson (FromJSON (..), (.:))
import qualified Data.Aeson as Aeson
import qualified Data.ByteString.Lazy.Char8 as LBS
import qualified Data.Text as Text
import Shuffle.Person (Person)

data Config = Config
  { peoplePerGroup :: Int,
    people :: [Person]
  }
  deriving (Eq, Show)

instance FromJSON Config where
  parseJSON = Aeson.withObject "Config" $ \v ->
    Config
      <$> v .: "peoplePerGroup"
      <*> v .: "people"

mkConfig :: Int -> [Person] -> Config
mkConfig peoplePerGroup people = Config {..}

fromJSON :: Text -> Either String Config
fromJSON = Aeson.eitherDecode' . LBS.pack . Text.unpack

fromFile :: (MonadIO m, MonadError String m) => FilePath -> m Config
fromFile filePath = loadFile filePath >>= liftEither . fromJSON

loadFile :: (MonadIO m, MonadError String m) => FilePath -> m Text
loadFile filePath = Text.pack <$> readFile filePath
