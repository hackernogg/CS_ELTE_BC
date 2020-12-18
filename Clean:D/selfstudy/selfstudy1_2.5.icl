//module selfstudy1_2.5
//import StdEnv
//__________________
factorial :: Int -> Int //factorial= n!=1x2x3x4...xn阶乘
factorial x
| x < 0 = abort "fuck off bruh"//abort = 停止并显示“”Stop this function and show up
| x == 0 = 1// tell to stop the loop
= x * factorial (x-1)
Start = factorial -9
------------------
fibo :: Int -> [Int]
fibo x
| x < 0 = []
= listfibo x 0 1

listfibo :: Int Int Int -> [Int]
listfibo x a b
| a > x = []
= [a] ++ listfibo x b (b+a)

Start = fibo 15

//______________________
isPrime :: Int -> Bool
isPrime x
| x < 0 = abort"fuck off"
| x == 0 = False
| x == 1 = False
= checkPrime x (x-1)

checkPrime :: Int Int -> Bool
checkPrime x y
| y == 1 = True
| x rem y == 0 = False//rem余数
= checkPrime x (y-1)

Start =isPrime 55

//_______________

sequence :: Int -> [Int]
sequence n
| n == 0 = []
= sequence(n/10) ++ [n rem 10]

isPalindrone :: Int -> Bool 
isPalindrone n 
| n < 0 = False
= reverse(sequence n) == sequence n//reverse 倒置数列

Start = isPalindrone 733337
//_____________________________
toList :: {a} -> [a]
toList array = [ x \\ x <-:array]

toArray :: [a] -> {a}
toArray list = {x \\ x<-list}

avge :: [Real] -> Real
avge [] = 0.0
avge x = (sum x)/ (toReal(length x))

size(x) <-{}-> x.[0] [] -> x!!0 size("name")==4 
//____________________________
getNode :: (Tree a) -> a
getNode (Node x l r) = x

getLeft :: (Tree a) -> (Tree a)
getLeft (Node x l r) = l

getRight :: (Tree a) -> (Tree a)
getRight (Node x l r) = r

SumTree :: (Tree Int) -> Int
SumTree Leaf = 0
SumTree (Node x l r) = x + (SumTree l) + (SumTree r)

isLeaf :: (Tree a) -> Bool
isLeaf Leaf = True
isLeaf _ = False

getMin :: (Tree a) -> a
getMin (Node x l r)
| isLeaf l = x
= getMin l

getMax :: (Tree a) -> a
getMax (Node x l r)
| isLeaf r = x
= getMax r
