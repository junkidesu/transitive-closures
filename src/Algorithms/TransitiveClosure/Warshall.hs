module Algorithms.TransitiveClosure.Warshall (warshall) where

import Data.Bits ((.&.), (.|.))
import Data.Matrix (Matrix, getElem, matrix, nrows)

warshall :: Matrix Int -> Matrix Int
warshall = warshall' 1
 where
  warshall' k w
    | k == n + 1 = w
    | otherwise = warshall' (k + 1) $ matrix n n generator
   where
    n = nrows w
    generator (i, j) =
      let
        wij = getElem i j w
        wik = getElem i k w
        wkj = getElem k j w
       in
        wij .|. (wik .&. wkj)
