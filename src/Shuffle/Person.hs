module Shuffle.Person (Person, new, name) where

import Data.Aeson (FromJSON)

newtype Person = Person Text deriving (Eq, Generic, Show)

instance FromJSON Person

new :: Text -> Person
new = Person

name :: Person -> Text
name (Person result) = result
