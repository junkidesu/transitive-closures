module Main (main) where

import Data.Matrix (Matrix, fromLists)
import Warshall (warshall)

--------------------
-- Example matrices
--------------------

m1 :: Matrix Int
m1 = fromLists
  [
    [0,0,1,0,0],
    [0,0,0,1,0],
    [1,0,0,0,0],
    [0,1,0,0,0],
    [0,0,0,1,0]
  ]

m2 :: Matrix Int
m2 = fromLists
  [
    [0,0,0,0,0],
    [0,0,1,0,1],
    [0,0,0,0,1],
    [1,0,0,0,0],
    [0,1,1,0,0]
  ]

main :: IO ()
main = do
  putStrLn "# Example 1:"
  print $ warshall m1

  putStrLn "-------------"

  putStrLn "# Example 2:"
  print $ warshall m2
