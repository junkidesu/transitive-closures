module TransitiveClosure (join,meet,(|*|),(|^|),transitiveClosure) where

import           Data.Bits   (Bits, zeroBits, (.&.), (.|.))
import           Data.Matrix (Matrix, elementwise, getCol, getRow, matrix,
                              ncols, nrows, zero)
import qualified Data.Vector as V

------------------------------------------
-- Naive algorithm to find the transitive
-- closure of a relation on a finite set.
------------------------------------------

join :: (Bits a) => Matrix a -> Matrix a -> Matrix a
join = elementwise (.|.)

meet :: (Bits a) => Matrix a -> Matrix a -> Matrix a
meet = elementwise (.&.)

---------------------------------------------------
-- Boolean product of two binary matrices
-- Input: Logical matrices `m1` and `m2`
--  such that their Boolean product is defined
-- Output: The Boolean product of `m1` and `m2`
-- Time complexity: O(n^3)
---------------------------------------------------

(|*|) :: (Bits a) => Matrix a -> Matrix a -> Matrix a
m1 |*| m2 = matrix (nrows m1) (ncols m2) $ helper m1 m2
    where
        helper :: (Bits a) => Matrix a -> Matrix a -> (Int, Int) -> a
        helper x y (i,j) = foldr (.|.) zeroBits $ V.zipWith (.&.) (getRow i x) (getCol j y)
--------------------------------------------------------------
-- Raising a square binary matrix to a positive integer power
-- Input: A square logical matrix `m`; an integer `n`
-- Output: The matrix `m` to the power `n`, defined in terms
--  of the Boolean product
--------------------------------------------------------------

(|^|) :: (Bits a) => Matrix a -> Int -> Matrix a
m |^| 1 = m
m |^| n = (m |^| (n-1)) |*| m

----------------------------------------------------------------------------
-- This function computes the matrix representation of
-- the transitive closure of a relation on a finite set
-- Input: A logical matrix `m`
-- Output: The transitive closure of `m`; a logical matrix of the same size
----------------------------------------------------------------------------

transitiveClosure :: (Bits a, Num a) => Matrix a -> Matrix a
transitiveClosure m = foldr (join . (m |^|)) (zero n n) [1..n]
    where n = nrows m
