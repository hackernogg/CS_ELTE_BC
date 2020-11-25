module hw9
import StdEnv
:: Tree a = Node a (Tree a) (Tree a) | Leaf

minRoot :: Tree Int
minRoot = (Node 4 (Node 10 (Node 11 Leaf Leaf)(Node 16 Leaf Leaf)) (Node 22 (Node 15 Leaf Leaf) Leaf))

minMostLeftLeaf :: Tree Int
minMostLeftLeaf = (Node 4 (Node 10 (Node 11 (Node 2 Leaf Leaf) Leaf) Leaf) (Node 16 (Node 22 (Node 13 (Node 15 Leaf Leaf) Leaf)  Leaf) (Node 100 Leaf Leaf) ))

minMostRightLeaf :: Tree Int
minMostRightLeaf = (Node 4 (Node 10 (Node 11 (Node 2 Leaf Leaf) Leaf) Leaf) (Node 16 (Node 22 (Node 13 (Node 15 Leaf Leaf) Leaf)  Leaf) (Node 100 Leaf (Node 1 Leaf Leaf)) ))

minNode :: Tree Int
minNode = (Node 4 (Node 10 (Node 11 (Node 2 Leaf Leaf) Leaf) Leaf) (Node 16 (Node -12 (Node 13 (Node 15 Leaf Leaf) Leaf)  Leaf) (Node 100 Leaf Leaf) ))

:: University = ELTE | BME | Corvinus
:: Student = {name::String, uni :: University, grades:: [Int]}

Rose::Student
Rose = {name="Rose",uni=ELTE, grades =[5,5,3,4,2,4,5,5]}
Peter::Student
Peter = {name="Peter",uni=BME, grades =[3,2,3,4,2,4,2,1,4,3,2,4]}
Noah::Student
Noah = {name="Noah",uni=Corvinus,grades=[1,2,2,3,1,3,4,2,3,4,2,4,2,1]}
James::Student
James = {name="James",uni=ELTE,grades=[5,5,5,5,3,4,5,4,5]}
Lily::Student
Lily = {name="Lily",uni=BME,grades=[1,2,1,3,1,5,3,3,4,1,3,1,5,1,1]}
Harry::Student
Harry = {name="Harry",uni=Corvinus,grades=[3,4,1,3,4,2,3,5,5]}
Eros::Student
Eros = {name="Eros",uni=Corvinus,grades=[4,2,4,4,4,4,4,5,2]}
Isabella::Student
Isabella = {name="Isabella",uni=BME,grades=[5,5,5,4,5,5,4,5,4,5]}
Oliver::Student
Oliver = {name="Oliver",uni=ELTE,grades=[2,3,3,4,3,2,1,3,2,3]}


selectStudent :: {Student} ->{(String,University,Real)}
selectStudent x
= {checkGPA a \\ a <-: x | (thd3 (checkGPA a)) >= 3.50}

checkGPA :: Student -> (String,University,Real)
checkGPA {name = a,uni = b, grades = c}
= (a,b,((toReal(sum c))/(toReal(length c))))


Start = selectStudent {Rose,Harry,Isabella,Oliver,James,Noah,Lily,Peter,Eros}
//--------------------------------------------------

treeToList :: (Tree a) -> [a]
treeToList Leaf = []
treeToList (Node x l r) = (treeToList l) ++ [x] ++ (treeToList r)

minTree :: (Tree Int) -> Int
minTree x
=minList (treeToList x)

Start = minTree minMostLeftLeaf // 2
//-----------------------------------------------

getNode :: (Tree a) -> a
getNode (Node x l r) = x

sumChildren :: (Tree Int) Int-> Int
sumChildren Leaf a = 0
sumChildren (Node x l r) a
| x == a = getNode l + getNode r + (sumChildren l a) + (sumChildren r a)
= 0 + (sumChildren l a) + (sumChildren r a)


Start = sumChildren (Node 2 (Node 1 Leaf Leaf) (Node 2 (Node 3 Leaf Leaf) (Node 1 Leaf Leaf))) 2 
