module et1
import StdEnv
//2
::University={uniName::String,students::[Student],teachers::[Teacher]}
::Teacher={tname::String,subject::String}
::Student={studentName::String,age::Int,grades::{Int},favoriteTeacher::Teacher}
ELTE::University
ELTE={uniName="ELTE",students=[Marko,Nikola,Josh,Dame],teachers=[Mary,Peter,John]}
BME::University
BME={uniName="BME",students=[Ana,Josh,Sofi,Nikola],teachers=[Viktor,John,Peter]}
EmptyUni::University
EmptyUni={uniName="Empty",students=[],teachers=[]}
Peter::Teacher
Peter={tname="Peter",subject="Functional"}
Viktor::Teacher
Viktor={tname="Viktor",subject="Math"}
Mary::Teacher
Mary={tname="Mary",subject="OOP"}
John::Teacher
John={tname="John",subject="Functional"}
Marko::Student
Marko={studentName="Marko",age=19,grades={4,4,4,5},favoriteTeacher= Mary}
Sofi::Student
Sofi={studentName="Sofi",age=22,grades={5,5,4,5,5},favoriteTeacher=John}
Dame::Student
Dame={studentName="Dame",age=21,grades={2,3,4,5},favoriteTeacher=Peter}
Ana::Student
Ana={studentName="Ana",age=18,grades={5,5,5,5},favoriteTeacher=Viktor}
Nikola::Student
Nikola={studentName="Nikola",age=19,grades={4,4,4,4,2},favoriteTeacher=Peter}
Nik::Student
Nik={studentName="Nik",age=20,grades={4,4,4,4,3},favoriteTeacher=Peter}
Nik2::Student
Nik2={studentName="Nik2",age=22,grades={4,4,4,4,5},favoriteTeacher=Peter}
Josh::Student
Josh={studentName="Josh",age=22,grades={4,5,5},favoriteTeacher=John}
//-----------------------------------------
toList :: {a} -> [a]
toList array = [ x \\ x <-:array]

toArray :: [a] -> {a}
toArray list = {x \\ x<-list}

shorterThan6::University->{String}
shorterThan6 u = toArray ((toList student) ++ (toList teacher))

where
   student = { x.studentName \\ x <-u.students | size(x.studentName) < 6} 
   teacher = { x.tname \\ x <-u.teachers | size(x.tname) < 6}
Start=shorterThan6 BME//{"Ana","Josh","Sofi","John","Peter"}
//------------------------------------------------------
toList :: {a} -> [a]
toList array = [ x \\ x <-:array]

average :: Student -> Real
average s = avg [toReal x \\ x <- (toList s.grades)]

instance toString Student
 where
        (toString) x = x.studentName +++" "+++ toString(average x)+++" "+++ x.favoriteTeacher.tname
Start=toString Nikola

//-----------------------------------------
toList :: {a} -> [a]
toList array = [ x \\ x <-:array]

average :: Student -> Real
average s = avge [toReal x \\ x <- (toList s.grades)]

avgrageUn :: University -> Real
avgrageUn x = avge[average x \\ x <- x.students]

avge :: [Real] -> Real
avge [] = 0.0
avge x = (sum x)/ (toReal(length x))

highest :: [University] -> University
highest [a] = a
highest [a,b]
| (avgrageUn a) > (avgrageUn b) = a
| (avgrageUn a) < (avgrageUn b) = b
| (avgrageUn a) == (avgrageUn b) = a
highest [a,b:xs]
| (avgrageUn a) > (avgrageUn b) = highest [a:xs]
| (avgrageUn a) < (avgrageUn b) = highest [b:xs]
| (avgrageUn a) == (avgrageUn b) = highest [b:xs]



highestGpa::{University}->String

highestGpa x
| size(x) == 0 = "No universities given" 
= (highest(toList x)).uniName



Start=highestGpa {EmptyUni,EmptyUni,BME,ELTE}
//-----------------------------------
maxOfTwo :: {Int} {Int} -> {Int}
maxOfTwo a b = { maxList[x,y] \\ x <-:a & y<-:b}
Start = maxOfTwo {} {} // {2,5,6}
//--------------------------------------
::Person = {fake_name :: String, peopleToLie :: [String]}

getName :: Person -> String
getName x = x.fake_name

getNameList :: [Person] -> [String]
getNameList [x] = [getName x]
getNameList [x:xs]= [getName x] ++ getNameList xs

goodPeople :: [Person] -> [Person]
goodPeople [x]
| isAnyMember ((hd [x]).peopleToLie) (getNameList [x]) == False = [hd [x]]
= []
goodPeople x
| isAnyMember ((hd x).peopleToLie) (getNameList x) == False = [hd x] ++ goodPeople (tl x)
= []

Start = goodPeople [{fake_name = "Rafaat Ismail", peopleToLie = ["Adel","Maggi"]},{fake_name = "Lucifier", peopleToLie = ["Adel","Rafaat Ismail"]},{fake_name = "elkenona", peopleToLie = ["Adel","Lucifier"]}]
//---------------------------------------
toList :: {a} -> [a]
toList array = [ x \\ x <-:array]


countApp :: Int [Int] -> Int
countApp x l = length [a \\ a <- l | a == x]

// Start = f7Aux [1,2,3,1,3,2,2,2]

f7Aux :: [Int] -> [Int]
f7Aux l = map (\x = countApp x l) l

f7 :: {Int} -> Bool
f7 arr = (length [ x \\ x <- (f7Aux l) | x == 1]) == 0
    where
        l = toList arr
//---------------------------------------
:: Tree a = Node a (Tree a) (Tree a) | Leaf

SumTree :: (Tree Int) -> Int
SumTree Leaf = 0
SumTree (Node x l r) = x + (SumTree l) + (SumTree r)

f10::(Tree Int) Int->Int
f10 Leaf a = 0
f10 (Node x l r) a
| x == a = SumTree l + SumTree r
| x <> a = f10 l a + f10 r a
= 0
Start = f10 (Node 2 Leaf Leaf) 3

