module hw10
import StdEnv

:: Tree a = Node a (Tree a) (Tree a) | Leaf

bestTree :: Tree Int
bestTree = Node 10(Node 6(Node 1 Leaf(Node 5(Node 2 Leaf(Node 4(Node 3 Leaf Leaf)Leaf))Leaf))Leaf)(Node 14(Node 11 Leaf(Node 13(Node 12 Leaf Leaf)Leaf))(Node 17(Node 15 Leaf(Node 16 Leaf Leaf))(Node 19(Node 18 Leaf Leaf)(Node 20 Leaf Leaf))))
ourTree :: Tree Int
ourTree = Node 15(Node 3(Node 1 Leaf Leaf)(Node 10(Node 7 Leaf (Node 8 Leaf Leaf))(Node 13 (Node 11 Leaf Leaf) Leaf)))(Node 20 (Node 18 Leaf (Node 19 Leaf Leaf)) (Node 21 Leaf (Node 26 (Node 24 Leaf Leaf) (Node 28 Leaf Leaf))))

extractNode :: (Tree a) -> a
extractNode (Node x l r) = x


goL :: (Tree a) -> (Tree a)
goL (Node x l r) = l
goR :: (Tree a) -> (Tree a)
goR (Node x l r) = r


isLeaf :: (Tree a) -> Bool
isLeaf Leaf = True
isLeaf _ = False

minTree :: (Tree a) -> a | Ord a 
minTree tree
| isLeaf(goL tree)= extractNode tree
= minTree (goL tree)

remMin :: (Tree a) -> (Tree a) | Ord, Eq a
remMin (Node x Leaf r) = r
remMin (Node x l r)
| extractNode l == minTree (Node x l r) = (Node x (goR l) r)
= (Node x (remMin l) r)

remRoot :: (Tree a) -> (Tree a) | Ord, Eq a
remRoot Leaf = Leaf
remRoot (Node x l r)
| isLeaf l && isLeaf r = Leaf
| isLeaf l = r
| isLeaf r = l
= (Node (minTree r) l (remMin r))

Start = remRoot ourTree
//---------------------------------------------
/* Define an instance of the built-in class +
    for a list of tuples [(a,b)] such that, 
    the addition of two lists takes place elementwise 
    (if necessary, the shortest list is extended with zeros to
    obtain two lists of equal length). 
*/

instance + [(a,b)] | +a & +b
 where 
     + [(a,b):c] [] = [(a,b):c]
     + [] [(a1,b1):c1] = [(a1,b1):c1]
     + [(a,b):c] [(a1,b1):c1] = [(a+a1,b+b1)] ++ (c+c1)
Start = [(1,2),(3,4),(7,1)] + [(2,6),(2,1)] 
