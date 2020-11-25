module hw8
import StdEnv

f :: {Int} -> {(Int, Bool)}
f x
= {f1 a\\ a <-:x}

f1 :: Int -> (Int, Bool)
f1 x
| (length(toList x))rem 2 <> 0 = (x, False)
| checkReal x == True = (x, True)
=(x, False)

checkReal :: Int -> Bool
checkReal x
| (take ((length(toList x))/2) (toList x))==(drop ((length(toList x))/2) (toList x)) = True
= False

toList :: Int -> [Int]
toList x
| x<10= [x]
= toList (x/10) ++ [x rem 10]

Start = f {312, 1001, 1010}
//---------------------------------
::Person={name::String, height::Real}

ChangeHeight :: Person Real  -> Person
ChangeHeight {name = a , height = b} c
={name = a , height = c}

Start = ChangeHeight {name = "Rose", height= 1.73} 1.62

copyRight by Sun Yilong
