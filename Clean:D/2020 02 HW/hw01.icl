/ 1. Given a number. Check if it is a divisor of 10. /
module prac1
import StdEnv
power10 :: Int -> Bool
power10 x
|x rem 10 == 0 = True
|x rem 10 <> 0 = False
Start = power10 20
-----------------------
/ 2. Given three numbers a,b,c , compute the discriminant of the quadratic formula. Discriminant : D=b^2+4ac /
module hw102
import StdEnv
discriminant :: Int Int Int -> Int
discriminant a b c
=b * b + 4 * a * c
Start = discriminant 4 1 2
----------------------
/ 3. Given a number n, find the sum of the squares of all numbers from 1 to n. If n is smaller than 1 then the output should be 0. /
module hw103
import StdEnv
sumOfSquares :: Int -> Int
sumOfSquares x
| x < 0 = 0
| x == 1 = 1
= x * x + sumOfSquares (x - 1)

squares :: Int -> Int
squares a
= a * a
Start = sumOfSquares 5

copyright By SunYilong
