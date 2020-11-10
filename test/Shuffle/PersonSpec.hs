{-# OPTIONS_GHC -Wno-unused-imports #-}

module Shuffle.PersonSpec (spec) where

import Data.Text.Arbitrary
import qualified Shuffle.Person as Person
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Shuffle.Person" $
  describe "name" $
    it "returns the name of the person" $
      property $ \n ->
        Person.name (Person.new n) `shouldBe` n
