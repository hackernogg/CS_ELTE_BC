module hw021
import StdEnv
splitNum :: Int -> [Int]
splitNum x
| x == 0 = []
| x < 10 = [x]
=  splitNum (x/10) ++ [x rem 10] 
Start = splitNum 5418
//-------------------------------------
module hw022
import StdEnv
modify :: [Int] -> [Int]
modify [] = []
modify [x:xs]
| x == 0 = [0] ++ modify xs
=  [x rem 2] ++ modify xs
Start = modify [0,6,8,0,1,5,7]
//-------------------------------------
module hw023
import StdEnv

reverseLists :: [[Int]] -> [[Int]]
reverseLists [] = []
reverseLists [x:xs]
| (length x) rem 2 == 0 = [x] ++ reverseLists xs
| (length x) rem 2 == 1 = [reverse x] ++ reverseLists xs

Start = reverseLists [[1..10],[4..10],[5,4,3,2,1]]

copyRight Sun Yilong
