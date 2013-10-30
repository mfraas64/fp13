module Main where

import Test.QuickCheck
import Test.QuickCheck.Gen
import System.Random

-- see http://blog.jb55.com/post/6180072300/using-haskells-quickcheck-to-generate-random-test-data
-- see http://www.haskell.org/haskellwiki/QuickCheck_as_a_test_set_generator

data Serial = Serial String Int

instance Show Serial where
  show (Serial prefix number) = prefix ++ ":" ++ show number

instance Arbitrary Serial where
  arbitrary = do
    prefix <- vectorOf 7 $ elements ['A'..'Z']
    number <- choose (1000, 9999)
    return $ Serial prefix number


serialGen :: Int -> [Serial]
serialGen seed = unGen arbitrary (mkStdGen seed) 9999999

keyValue :: Serial -> (Int, String)
keyValue (Serial prefix number) = (number, prefix)

kvGen :: Int -> Int -> [(Int, String)]
kvGen seed n = take n $ map keyValue $ serialGen seed
-- was ist übrigens die point-free Version von kvGen?

