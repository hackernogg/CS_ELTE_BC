module midp
import StdEnv

Router :: [(a->b)] [(Int,a)] -> [b]
Router [][(c,d):cs] = []
Router x [] = []
//Router [] [] = []
Router x [(a,b):as]
= [(x!!(a-1)) b] ++ Router x as
Start = Router [isEven,isOdd] [(1,2),(2,4),(1,57)] //[True, False, False]
//----------------------------
Listing :: [Int] -> [Int]
Listing [] = []
Listing [a] = [a rem 2]
Listing [a,b] = [a..b]
Listing [a,b,c] = [a*(b^c)]
Listing [a,b,c,d] = [(a+b),(c+d)]
Start = Listing [1,2,3,4]
//-------------------------
oddCheck :: Int [Int] -> Bool
oddCheck a [x:xs]
|a>=(length[x:xs])=True
= isOdd([x:xs]!!a) && oddCheck (a+2) [x:xs]
evenCheck :: Int [Int] -> Bool
evenCheck a [x:xs]
|a>=(length[x:xs])=True
= isEven([x:xs]!!a) && evenCheck (a+2) [x:xs]
SeqCheck :: [Int] -> Bool
SeqCheck [] = False
SeqCheck [x:xs]
|oddCheck 0 [x:xs] == False = False
|evenCheck 1 [x:xs] == False = False
=True
Start = SeqCheck [1,4,3,8]
//----------------------------------
checkEven :: [Int] -> Bool
checkEven [] = False
checkEven [a,b]
|a==b=True
=False
checkEven [x:xs]
| ((length [x:xs]) rem 2) <> 0 = False
| ((sort[x:xs])!!0) == ((sort[x:xs])!!1)= True && checkEven (drop 2(sort[x:xs]))
=False
Start = checkEven [1,1,2,2,1]
//---------------------
DotProd :: [Int] [Int] -> Int
DotProd [] [] = 0
DotProd [x:xs] [y:ys]
| length[x:xs] <> length[y:ys] = abort"two input list's length need to be equal"
= x * y + DotProd xs ys
Start = DotProd [5,2,6,8,3] [5,-8,5,-3,-5]
//-----------------------
TwoLists :: [Char] -> ([Char],[Char])
TwoLists [] = ([],[])
TwoLists x
=([a\\a<-x,b<-['0'..'9']|a == b],drop (length [a\\a<-x,b<-['0'..'9']|a == b])(sort x))
Start = TwoLists['1', 'a', '2', 'b', '3']
//-----------------------------
Points3 :: [[Int]] -> [(Int, Int, Int)]
Points3 [] = []
Points3 [x:xs]
=[(a,b,c)\\a<-[hd x], b<-[mid x],c<-[last x]] ++ Points3 xs

mid ::[Int] -> Int
mid[x:xs] = [x:xs]!!((length [x:xs] )/2)
Start = Points3 [[1..9], [2..6], [3..11], [1..10]]
//------------------------
trangleCheck :: (Int,Int,Int) -> [(Int,Int,Int)]
trangleCheck (a,b,c)
| a <= 0 = []
| b <= 0 = []
| c <= 0 = []
| ((sort[a,b,c])!!0) rem 3 == 0 && ((sort[a,b,c])!!1) rem 4 == 0 && ((sort[a,b,c])!!2) rem 5 == 0 = [(q,w,e)\\q<-[sort[a,b,c]!!0],w<-[sort[a,b,c]!!1],e<-[sort[a,b,c]!!2]]
= []

f8::[(Int,Int,Int)]->[(Int,Int,Int)]
f8 [] = []
f8 [x:xs]
= removeDup (trangleCheck x ++ f8 xs)
Start = f8 [(3,4,5),(4,5,6),(4,5,3),(6,8,10),(10,5,8),(-3,4,5)]
//-----------------------------------
rootCheck :: Int -> Int
rootCheck x
= toInt((toReal x ^ (0.5))*1000.0)
f9::[Int] -> Bool
f9 [] = True
f9 [x:xs]
|(foldr (rem) (1000) [rootCheck x])<> 0 = False 
=f9 xs
Start = f9 [9,16,25,5]
//---------------------------------
addSum :: [[Int]] -> [[Int]]
addSum [] = []
addSum [x]
= [x++[sum x]]
addSum [x:xs]
= [x++[sum x]] ++ addSum xs
Start = addSum[[1,2], [3,4,5], [6,5,9,7], [], [8]]


copyRight by Sun Yilong
