module hw3
import StdEnv
//q1

del :: Int [Int] -> [Int]
del a [] = []
del a [x:xs]
|xs == [] = [x]
|x <> (xs!!0) = [x] ++ del a xs
| (x*2) <> ((hd xs)+ a) =[x]++[hd xs]++  del a (tl xs)
|(x*2) == ((hd xs)+ a) = del a (tl xs)

Start = del 1 [1,1,1,1,1,1] 

//q2------------------


smaller :: [Int] [Int] -> Bool
smaller [a:as] [b:bs]
| (length [a:as]) <> (length [b:bs]) = False
| ((a<b) && as == []) = True
| a < b = smaller as bs
| a > b = False





Start = smaller [5..10] [1..4]





//--------------------------
//q3 first way

minimum :: [Int] -> Int

minimum [x:xs]
|xs == [] = x
|xs == [x] = x
|x == (xs!!0) = minimum xs
|x < (xs!!0) = minimum [x:(tl xs)]
|x > (xs!!0) = minimum xs

// second way

minimum :: [Int] -> Int
minimum [x:xs]
= minList x



Start = minimum [5,8,1,999,0,-1] // 1
//Start = minimum [10,9,8,7,6] // 6
