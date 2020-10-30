module hw5
import StdEnv

smallCheck:: (Int,Int) -> Bool
smallCheck (a,b)
|a<b = True
= False

isSmaller :: [(Int,Int)]-> Bool
isSmaller [] = False
isSmaller [x]
| smallCheck x == True = True
= False
isSmaller [x:xs]
| smallCheck x == True = True && isSmaller xs
= False

Start = isSmaller []

//-----------------------------

numKeep::(Int,Bool)-> [Int]
numKeep (a,b)
|b == True = [a]
=[]

keepTrue:: [(Int,Bool)] -> [Int]
keepTrue [] = []
keepTrue [x]
= numKeep x
keepTrue [x:xs]
= numKeep x++ keepTrue xs
Start = keepTrue [(1,True)]

//-------------------
generateFib :: [Int] -> [Int]
generateFib []=[]
generateFib [x]
= [fib x]
generateFib [x:xs]
= [fib x] ++ generateFib xs

fib :: Int -> Int
fib x = fibn 1 1 x


fibn :: Int Int Int -> Int
fibn a b 0 = a
fibn a b c = fibn b (a+b) (c-1)

Start = generateFib [4]

copyRight by Sun Yilong
