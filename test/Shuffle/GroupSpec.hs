{-# OPTIONS_GHC -Wno-orphans #-}

module Shuffle.GroupSpec where

import qualified Data.Text as Text
import qualified Shuffle.Group as Group
import Shuffle.Person (Person)
import qualified Shuffle.Person as Person
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Shuffle.Group" $
  describe "members" $ do
    it "returns the members" $
      property $ \(people :: [Person]) ->
        Group.members (Group.new people) `shouldBe` people

instance Arbitrary Person where
  arbitrary = Person.new . Text.pack <$> arbitrary
