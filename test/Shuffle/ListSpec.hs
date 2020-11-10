module Shuffle.ListSpec (spec) where

import qualified Shuffle.List as List
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Shuffle.List" $
  describe "chunksOf" $ do
    it "returns (items / size) rounded up chunks" $
      property $ \(list :: [Int]) ->
        property $ \(Positive size :: Positive Int) -> do
          let actual = length $ List.chunksOf size list
          let expected = ceiling ((fromIntegral (length list) / fromIntegral size) :: Double)
          actual `shouldBe` expected

    it "the chunks are made up of the original list" $
      property $ \(list :: [Int]) ->
        property $ \(Positive size :: Positive Int) ->
          mconcat (List.chunksOf size list) `shouldBe` list

    it "never returns more than one chunk smaller than the size" $
      property $ \(list :: [Int]) ->
        property $ \(Positive size :: Positive Int) -> do
          let chunkSizes = length <$> List.chunksOf size list
          let smallerChunks = filter (> size) chunkSizes
          length smallerChunks `shouldSatisfy` (<= 1)

    it "never returns a chunk with more elements than size" $
      property $ \(list :: [Int]) ->
        property $ \(Positive size :: Positive Int) -> do
          let chunkSizes = length <$> List.chunksOf size list
          let smallerChunks = filter (> size) chunkSizes
          length smallerChunks `shouldBe` 0

    it "the smallest chunk is always the last" $
      property $ \(list :: [Int]) ->
        property $ \(Positive size :: Positive Int) -> do
          let chunkSizes = length <$> List.chunksOf size list
          let numberOfChunks = length chunkSizes
          let allButLast = take (numberOfChunks - 1) chunkSizes
          allButLast `shouldSatisfy` all (== size)
