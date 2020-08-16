import Lib
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "fibonacci" $ do
    it "fibonacci 0 = 0" $ fibonacci 0 `shouldBe` 0
    it "fibonacci 1 = 1" $ fibonacci 1 `shouldBe` 1
    it "fibonacci 10 = 55" $ fibonacci 10 `shouldBe` 55
    it "fibonacci 15 = 610" $ fibonacci 15 `shouldBe` 610
    it "fibonacci 20 = 6765" $ fibonacci 20 `shouldBe` 6765
    it "fibonacci 30 = 832040" $ fibonacci 30 `shouldBe` 832040
  describe "myReverse" $ do
    it "reverses an empty list" $ myReverse [] `shouldBe` ([] :: [Int])
    it "reverse `hello`" $ myReverse "hello" `shouldBe` "olleh"
    it "reverses int list" $ myReverse [1,2,3,4,5] `shouldBe` [5,4,3,2,1]
  describe "mySum" $ do
    it "sums empty list to 0" $ mySum [] `shouldBe` 0
    it "sums singleton list" $ mySum [1] `shouldBe` 1
    it "sums longer list" $ mySum [1..10] `shouldBe` 55
  describe "quicksort" $ do
    it "sorts the empty list" $ quicksort [] `shouldBe` ([] :: [Int])
    it "sorts a singleton list" $ quicksort [1] `shouldBe` [1]
    it "sorts a short list" $ quicksort [3,1,5,6] `shouldBe` [1,3,5,6]
    it "sorts a long list" $ quicksort [100,99..0] `shouldBe` [0..100]
