module endterm
import StdEnv
import StdEnv
// Please fill the data required below.
//<Sun Yilong>
//<BCFOGS>
//Functional Programming & end-term
//2020.Dec.18
//This solution was submitted and prepared by <Name, Neptun ID> for the end-term assignment of the Functional Programming course.
//I declare that this solution is my own work.
//I have not copied or used third party solutions.
//I have not passed my solution to my classmates, neither  made it public.
//Students’ regulation of Eötvös Loránd University (ELTE Regulations Vol. II. 74/C. § ) states that as long as a student presents another student’s work - 
//or at least the significant part of it - as his/her own performance, it will count as a disciplinary fault. 
//The most serious consequence of a disciplinary fault can be dismissal of the student from the University.
//---------------------------------------------------------------------------------------------

:: Human = {firstName::String, age::Int, height::Int}
Rose :: Human
Rose = {firstName="Rose", age=23, height=172}
Jack :: Human
Jack = {firstName="Jack", age=25, height=193}
Emilia :: Human
Emilia = {firstName="Emilia", age=15, height=160}
Leo :: Human
Leo = {firstName="Leo", age=16, height=175}
Grace::Human
Grace = {firstName="Grace", age=35, height=165}
Harry :: Human
Harry = {firstName="Harry", age=42, height=180}
Harry2 :: Human
Harry2 = {firstName="Harry", age=43, height=177}
Emilia2 :: Human
Emilia2 = {firstName="Emilia", age=15, height=180}
Emilia3 :: Human
Emilia3 = {firstName="Emilia", age=17, height=186}
//--------------------------------------------------------
//1

toPos:: Int -> Int
toPos x
| x < 0 = x * (-1)
= x

f1 :: Human Human -> Bool
f1 x y
| x.firstName == y.firstName && (toPos(x.height - y.height)) == (toPos(3*(x.age - y.age))) = True
= False


instance == Human
 where
   (==) x y = f1 x y
Start = Emilia == Emilia2

//--------------------------------------------------------
//2

f2Plus :: [(Int,Int)] -> [(Int,Int)]
f2Plus [] = []
f2Plus [(a,b)] = [(a,b)]
f2Plus [(a,b),(c,d)] = [(a+c,b+d)]
f2Plus [(a,b),(c,d):xs]
= f2Plus ([(a+c,b+d)]++xs)

f2Mul :: [(Int,Int)] [(Int,Int)] -> [(Int,Int)]
f2Mul [] a = []
f2Mul a [] = []
f2Mul [(a,b)] [(c,d)] = [(a*c,b*d)]
instance * [(Int,Int)]
 where
 (*) x y =  f2Mul (f2Plus x) (f2Plus y)

Start =   [(1,2), (3,4), (5,6)] * [(3,5),(6,2),(4,5),(9,7)]
//----------------------------------------------------------
//3

toPos:: Int -> Int
toPos x
| x < 0 = x * (-1)
= x

toList :: {a} -> [a]
toList array = [ x \\ x <-:array]

toArray :: [a] -> {a}
toArray list = {x \\ x<-list}

getMid::[Int]-> Int
getMid [x:xs]
| length [x:xs] rem 2 == 0 = ((([x:xs]!!(a/2))+([x:xs]!!((a/2)-1)))/2)
=[x:xs]!!(a/2)
where 
    a = length [x:xs]
getDif :: [Int] -> Int
getDif [x:xs] = toPos(maxList[x:xs] - getMid (sort [x:xs]))

f3 :: [[Int]] Int -> [[Int]]
f3 [] y = []
f3 [x] y
| (getDif x) < y = [x]
f3 [a:as] b
| (getDif a) < b = [a] ++ f3 as b
= [] ++ f3 as b

median_max_diff :: {[Int]} Int -> {[Int]}
median_max_diff x y
= toArray(f3(toList x) y)


Start = median_max_diff {[1..10],[5..345]} -3
//----------------------------------------------------
//4

toList :: {a} -> [a]
toList array = [ x \\ x <-:array]

toArray :: [a] -> {a}
toArray list = {x \\ x<-list}

f4 :: [Int] -> [Int]
f4 [] = []
f4 x = [a\\ a<-x | a <> (minList x)]

rem_min :: {Int} -> {Int}
rem_min x = toArray(f4(toList x))

Start = rem_min {1,42,42,52,452,4}
//--------------------------------------------------------------------------------
//7

:: Moral = Happy | Sad

:: Player = {player_name :: String, goals :: [Int], moral :: Moral}

getAvg :: [Int] -> Real
getAvg x = (toReal(sum x))/(toReal(length x))

getMoral :: Moral -> Real
getMoral Happy = 0.1
getMoral Sad = 0.0


best_striker :: [Player] -> String
best_striker [x] = x.player_name
best_striker [a,b:xs]
| (getAvg(a.goals) + getMoral(a.moral)) > (getAvg(b.goals) + getMoral(b.moral)) = best_striker [a:xs]
| (getAvg(a.goals) + getMoral(a.moral)) < (getAvg(b.goals) + getMoral(b.moral)) = best_striker [b:xs]
best_striker [a,b]
| (getAvg(a.goals) + getMoral(a.moral)) == (getAvg(b.goals) + getMoral(b.moral)) && a.player_name == "Messi" = "Messi"
| (getAvg(a.goals) + getMoral(a.moral)) == (getAvg(b.goals) + getMoral(b.moral)) && b.player_name == "Messi" = "Messi"
=a.player_name
//Start = best_striker [{player_name = "Abo Trika", goals = [1,1,0,0,2], moral = Happy}, {player_name = "Ronaldo", goals = [1,1,2,0,2], moral = Sad}, {player_name = "Messi", goals = [1,1,2,1,2,2,0], moral = Happy} ] // Messi
//Start = best_striker [{player_name = "Abo Trika", goals = [2,2], moral = Sad}, {player_name = "Ronaldo", goals = [2,2], moral = Happy}, {player_name = "Messi", goals = [1,1,2,1,2,2,0], moral = Sad} ] // Ronaldo
//Start = best_striker [{player_name = "Ferenc Puskas", goals = [1,1,0,0,2], moral = Happy}, {player_name = "Ronaldo", goals = [2, 2], moral = Happy}, {player_name = "Messi", goals = [2, 2], moral = Happy} ] // Messi
Start = best_striker [{player_name = "Pele", goals = [2, 2, 2], moral = Happy}, {player_name = "Ronaldo", goals = [2, 2], moral = Sad}, {player_name = "Messi", goals = [2, 2], moral = Sad} ] // Pele
//---------------------------------------------------------------------------
//10
:: Gender = Male | Female
:: Uni = ELTE | BME | MIT | TUM | LMU

:: Person = { name :: String
            , gender :: Gender
            , almaMater :: Uni
            }

:: FamilyTree = Member Person FamilyTree FamilyTree | Unknown

p1 = {name="A",gender=Male,almaMater=ELTE}
p2 = {name="B",gender=Female,almaMater=TUM}
p3 = {name="C",gender=Male,almaMater=BME}
p4 = {name="D",gender=Female,almaMater=ELTE}
ftree1 = Member p2 (Member p1 (Member p3 Unknown Unknown) Unknown) (Member p4 (Member p2 Unknown Unknown) (Member p4 Unknown Unknown))
ftree2 = Member p3 ftree1 (Member p3 (Member p1 Unknown ftree1) (Member p4 ftree1 ftree1))
ftree3 = Member p1 (Member p3 ftree2 (Member p4 ftree1 ftree2)) (Member p3 Unknown (Member p4 (Member p3 ftree2 Unknown) ftree2))

checkUn:: FamilyTree -> Int
checkUn Unknown = 0
checkUn (Member x l r) = 1

sizeOfTree:: FamilyTree -> Int
sizeOfTree Unknown = 0
sizeOfTree (Member x l r)
| checkUn r == 0 && checkUn l == 0 = 0
| checkUn l == 0 && checkUn r == 0 = 0
| checkUn l == 0 && checkUn r == 1 && (isElte ((getNode r).almaMater)) == False = 0
| checkUn r == 0 && checkUn l == 1 && (isElte ((getNode l).almaMater)) == False = 0
| checkUn r == 1 && checkUn l == 1 &&(isElte ((getNode l).almaMater)) == False && (isElte ((getNode r).almaMater)) == False = 0
= 1

getNode :: FamilyTree -> Person 
getNode (Member x l r) = x

isElte :: Uni -> Bool
isElte ELTE = True
isElte BME = False
isElte MIT = False
isElte TUM = False
isElte LMU = False

countRelated :: FamilyTree -> Int
countRelated Unknown = 0
countRelated (Member x l r)
= sizeOfTree (Member x l r) + countRelated l + countRelated r

//Start = countRelated ftree1 // 2
//Start = countRelated ftree2 // 9
//Start = countRelated Unknown // 0
Start = countRelated ftree3 // 40

copyRight by Sun Yilong
