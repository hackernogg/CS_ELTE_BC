module hw7
import StdEnv
//----------------
addOrMult :: [(Int,Int,Bool)] -> [Int]
addOrMult [] = []
addOrMult [x:xs]
| thd3 x == True = [(fst3 x) + (snd3 x)]++addOrMult xs
| thd3 x == False = [(fst3 x) * (snd3 x)]++addOrMult xs
Start = addOrMult [(1,2,False)]
//--------------------
isHalf::Int->Bool
isHalf x
| x < 10 = False
|(length (numList x))rem 2 <>0 = False
|(take ((length (numList x))/2)(numList x)) == (drop ((length (numList x))/2)(numList x)) = True
=False

numList :: Int -> [Int]
numList x
|x < 10 = [x]
= numList (x/10) ++ [x rem 10]
Start = isHalf 11
//---------------------

keep3s :: [Int] -> [Int]
keep3s [] = []
keep3s [x]
| (length(check3s x)) rem 2 == 0 = [x]
= []
keep3s [x:xs]
| (length(check3s x)) rem 2 == 0 = [x] ++ keep3s xs
= []++ keep3s xs


check3s :: Int -> [Int]

check3s x
= [a\\a<-(numList x)|a==3]


numList :: Int -> [Int]
numList x
|x < 10 = [x]
= numList (x/10) ++ [x rem 10]
Start = keep3s [32,323,3233,3223,32323,1,191,299,40]

copyRight by Sun Yilong
