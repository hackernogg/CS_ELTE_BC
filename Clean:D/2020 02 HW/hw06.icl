module hw6
import StdEnv
/*
LeapYearList :: Int Int -> [Int]
LeapYearList x y
|x<0 = []
|y<0 = []
|y == 0 = []
= [x+(4-(x rem 4))] ++ LeapYearList (x+4) (y-1)


Start = LeapYearList 1997 3 //[2000, 2004, 2008]
*/
//----------------------------------
/*
addProd :: [[Int]] -> [[Int]]
addProd [] = []
addProd [x] = [x ++ [prod x]]
addProd [x:xs]
= [x ++ [prod x]] ++ addProd xs
Start = addProd [[1,2..9], [6,7,1,9], [33,27], [3,5,7,9], [8]]
*/
//----------------------------
check :: [Int] -> [Bool]
check [] = []
check [x:xs]
| (length [x:xs]) rem 2 == 0 = map isEven [x:xs]
= map isOdd [x:xs]
Start = check []

copyRight by Sun Yilong
