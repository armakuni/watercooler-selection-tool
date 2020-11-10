module Shuffle.Display (groupsToString) where

import qualified Data.Text as Text
import Fmt
import Shuffle.Group (Group)
import qualified Shuffle.Group as Group
import qualified Shuffle.Person as Person

groupsToString :: [Group] -> Text
groupsToString groups = Text.intercalate "\n" $ zipWith (flip groupToString) groups [1 ..]

groupToString :: Int -> Group -> Text
groupToString number grp =
  let memberList = Text.intercalate ", " (Person.name <$> Group.members grp)
   in "Group " +| number |+ ": " +| memberList |+ ""
