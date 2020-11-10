module Shuffle.ConfigSpec (spec) where

import qualified Shuffle.Config as Config
import qualified Shuffle.Person as Person
import Test.Hspec

spec :: Spec
spec = describe "Shuffle.Config" $ do
  describe "fromJSON" $ do
    it "returns Config created from json" $ do
      let json = "{\"peoplePerGroup\": 2, \"people\": [\"Alice\", \"Bob\"]}"
      let expected = Config.mkConfig 2 [Person.new "Alice", Person.new "Bob"]
      Config.fromJSON json `shouldBe` Right expected

    it "returns an error for bad json" $ do
      let json = "Broken { JSON"
      let message = "Error in $: Failed reading: not a valid json value at 'Broken{JSON'"
      Config.fromJSON json `shouldBe` Left message

