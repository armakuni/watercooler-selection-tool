module Shuffle.DisplaySpec where

import Test.Hspec

import qualified Shuffle.Group as Group
import qualified Shuffle.Person as Person
import qualified Shuffle.Display as Display

spec :: Spec
spec = describe "Shuffle.Display" $
  describe "groupsToString" $ do
    it "displays the groups as a string" $ do
      let group1 = Group.new [Person.new "Alice", Person.new "Bob"]
      let group2 = Group.new [Person.new "Charlie", Person.new "Davina"]
      let groups = [group1, group2]
      let expected = "Group 1: Alice, Bob\nGroup 2: Charlie, Davina"
      Display.groupsToString groups `shouldBe` expected