module hw4
import StdEnv

multi :: Int [Int] -> [Int]
multi a [] = []
multi a [x]
|x == a = [x*10]
=[x]
multi a [x:xs]
|x == a = [x*10] ++ multi a xs
|x <> a = [x] ++ multi a xs

Start = multi 6 [6,5,4,3,6,8,6]
//-----------------------------------

select :: [[Real]] Int -> [Real]
select [[]] n = []
select [x:xs] n
| xs == [] = less3 x n
= less3 ([minList x] ++ select xs n) n
less3 :: [Real] Int -> [Real]
less3 [a] n
|a<(toReal n)=[a]
=[]
less3  [a:as] n

|a<(toReal n)=[a]++ less3 as n
=less3 as n
Start = select [[]] 1
//--------------------------------
avg :: [Real] -> Real
avg [] = 0.0
avg [x:xs]
= (foldr (+) 0.0 [x:xs])/(toReal(length[x:xs]))
Start = avg [5.5,6.6]
