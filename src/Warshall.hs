module Warshall (warshall) where

import           Data.Bits   ((.&.), (.|.))
import           Data.Matrix (Matrix, getElem, matrix, nrows)

----------------------------------------------
-- Helper function
----------------------------------------------

warshall' :: Int -> Matrix Int -> Matrix Int
warshall' k w
    | k == n+1    = w
    | otherwise = warshall' (k+1) $ matrix n n generator
    where
        n = nrows w
        generator (i,j) = let wij = getElem i j w
                              wik = getElem i k w
                              wkj = getElem k j w
                          in wij .|. (wik .&. wkj)

------------------------------------------------------------------------
-- Computes the matrix representation
-- of the transitive closure of the relation
-- represented by the given binary matrix
-- Input: Square binary matrix
-- Output: The transitive closure of the relation; square binary matrix
------------------------------------------------------------------------

warshall :: Matrix Int -> Matrix Int
warshall = warshall' 1