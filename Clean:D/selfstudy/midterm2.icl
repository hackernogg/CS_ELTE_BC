module midp2
import StdEnv

f1 :: Int -> Int
f1 x
| x < 10 = 0
= (sequence x)!!((length(sequence x))-2)

sequence :: Int -> [Int]
sequence n
| n == 0 = []
= sequence(n/10) ++ [n rem 10]
Start = f1 12
//----------------------
f2 :: [Int] -> Int
f2 [x:xs]
| [x:xs] == [] = 0
= foldl (-) x xs
Start = f2 [1000,500,250]
//--------------------
f3 :: Int -> [Int]
f3 x
| x == 0 = []
= removeDup(primeMath x 2 [1])

primeMath :: Int Int [Int] -> [Int]
primeMath a b c
| a == 1 = c
| a rem b == 0 = primeMath (a/b) b (c++[b])
= primeMath a (b+1) c
Start = f3 36
//---------------------
f4 :: [(Int, Int)] -> [(Int, Int)]
f4 [] = []
f4 [(a,b):as]
| (a+b) rem 2 == 0 = [(b,a)] ++ f4 as
= [(a,b)] ++ f4 as
Start = f4 [(-1,3),(12,1),(0,0),(-4,-2)]
//-------------------
f5 :: [Int] -> [[Int]]
f5 [] = []
f5 [x:xs]
= [map (\a=a*x) [1..5]]++ f5 xs

Start = f5 [1..3] //[[1,2,3,4,5],[2,4,6,8,10],[3,6,9,12,15]]
//-----------------------
leastfactorial :: Int -> Int
leastfactorial 1 = 1
leastfactorial 0 = 1
leastfactorial x = factorial x 0

factorial :: Int Int -> Int
factorial x y
| x <= (fact y) = (fact y)
= factorial x (y+1)
fact :: Int -> Int //factorial= n!=1x2x3x4...xn??
fact x
| x == 0 = 1
= x * fact (x-1)
Start =  leastfactorial 25 // 120
//---------------------------
f7 :: [Int] -> Bool
f7 [] = False
f7 [x]
= isOdd x
f7 [a,b:xs]
| isOdd a && isEven b = True
= False
Start = f7 []
//--------------------------
f8 :: [Int] -> [Int]
f8 [] = []
f8 [a] = [a]
f8 [a,b:c]
|a==b= f8(dropWhile ((==)a) c)
=[a]++f8[b:c]


Start = f8 [4,5,6,6,8,2,2,2,4,0,0,0,7,0,5,0,0,4]
//----------------------------
f9 ::([Int],[Int],[Int])->[(Int,Int,Int)]
f9 ([a],[b],[c])
| (a * b) == c =[(a,b,c)]
= []
f9 ([a:as],[b:bs],[c:cs])
| (a * b) == c =[(a,b,c)] ++ f9 (as,bs,cs)
= [] ++ f9 (as,bs,cs)
Start = f9 ([1,2,3,4,5],[2,4,6,8,10],[2,8,1,32,45])
//------------------------
f10 :: Int -> Bool
f10 x
| isPrime x == False = False
| twoPowerC x 0 == False = False
=True
//| isPrime x && (twoPowerC x 0)= True
//= False

isPrime :: Int -> Bool
isPrime x
| x < 0 = abort"fuck off"
| x == 0 = False
| x == 1 = False
= checkPrime x (x-1)

checkPrime :: Int Int -> Bool
checkPrime x y
| y == 1 = True
| x rem y == 0 = False//rem
= checkPrime x (y-1)

twoPowerC :: Int Int -> Bool
twoPowerC x y
| (x + 1)< twoP y = False
| (x + 1) == twoP y = True
=twoPowerC x (y+1)
twoP :: Int -> Int
twoP x
= 2^x
Start = f10 2147483647 //True

copyRight Sun Yilong
