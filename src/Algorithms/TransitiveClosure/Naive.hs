module Algorithms.TransitiveClosure.Naive (join, meet, (|*|), (|^|), transitiveClosure) where

import Data.Bits (Bits, zeroBits, (.&.), (.|.))
import Data.Matrix
import qualified Data.Vector as V

join :: (Bits a) => Matrix a -> Matrix a -> Matrix a
join = elementwise (.|.)

meet :: (Bits a) => Matrix a -> Matrix a -> Matrix a
meet = elementwise (.&.)

(|*|) :: (Bits a) => Matrix a -> Matrix a -> Matrix a
m1 |*| m2 = matrix (nrows m1) (ncols m2) $ helper m1 m2
 where
  helper x y (i, j) =
    foldr
      (.|.)
      zeroBits
      $ V.zipWith (.&.) (getRow i x) (getCol j y)

(|^|) :: (Bits a) => Matrix a -> Int -> Matrix a
m |^| 1 = m
m |^| n = (m |^| (n - 1)) |*| m

transitiveClosure :: (Bits a, Num a) => Matrix a -> Matrix a
transitiveClosure m = foldr (join . (m |^|)) (zero n n) [1 .. n]
 where
  n = nrows m
