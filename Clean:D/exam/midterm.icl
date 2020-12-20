module realmid
import StdEnv
//1

removeDiv10No4::[Int]->[Int]
removeDiv10No4 [] = []
removeDiv10No4 [x:xs]
| x rem 10 == 0 && x rem 4 <> 0 = [x] ++ removeDiv10No4 xs
= [] ++ removeDiv10No4 xs
Start = removeDiv10No4 [4,8..30]
//-----------------------------
//2

binaryToDecimal :: Int -> Int
binaryToDecimal 1 = 1
binaryToDecimal 0 = 0
binaryToDecimal x
= sum(prodTwo(sequence x))

prodTwo :: [Int] -> [Int]
prodTwo [x]
= [x*(2^((length [x])-1))]
prodTwo [x:xs]
= [x*(2^((length [x:xs])-1))] ++ prodTwo xs

sequence :: Int -> [Int]
sequence n
| n == 0 = []
= sequence(n/10) ++ [n rem 10]
Start = binaryToDecimal 0
//-------------------------------

//3

extract :: [[Int]] -> [(Int,Int,Int)]
extract [[]] = []
extract [] = []
extract [x:xs]
= [(a,b,c)\\a<-[minList x],b<-[(sort x)!!((length x)/2)],c<-[maxList x]]++ extract  xs      
Start = extract [[1..9], [2..6], [3..11], [1..10]] 
//--------------------------------------
//6

smList:: [Int] Int-> [Int]
smList [] a = []
smList [x] a
|x < a = [x]
= []
smList [x:xs] a
| x < a = [x]++ smList xs a
= [] ++ smList xs a

maxLessThanN::[[Int]] Int ->[Int]
maxLessThanN [] b = []
maxLessThanN [x:xs] b
= [maxList (smList x b)] ++ maxLessThanN xs b
Start =  maxLessThanN [[5,2,3,5,2,3,7],[2],[2,3,2,1],[-12,5,7]] 3
//------------------------------------
//7

fibo :: Int -> [Int]
fibo x
| x == 0 = [1]
| x == 1 = [1]
| x < 0 = []
= listfibo 1 1 x

listfibo :: Int Int Int -> [Int]
listfibo a b c
| c == 0 = []
= [a] ++ listfibo  (a+b) a (c-1)


generateFib :: [Int] -> [(Int, Int)]
generateFib [] = []
generateFib [x]
=[(a,b)\\a<-[last(fibo x)],b<-[prod(fibo x)]]
generateFib [x:xs]
=[(a,b)\\a<-[last(fibo x)],b<-[prod(fibo x)]] ++ generateFib xs

Start = generateFib [4..10] // [(1,1),(1,1),(2,2)]
//------------------------------------
//5

findDistance :: [(Real,Real)] -> [Real]
findDistance [] = []
findDistance [(a,b)] = []

findDistance [(a,b),(c,d):xs]
=removeDup([((a - c)^2.0 + (b - d)^2.0)^(1.0/2.0)] ++ findDistance [(a,b):xs] ++ findDistance[(c,d):xs])


Start = findDistance [(1.0,1.0),(4.0,5.0),(1.0, ~6.0),(~1.0,~3.0)]


copyRight by Sun Yilong
