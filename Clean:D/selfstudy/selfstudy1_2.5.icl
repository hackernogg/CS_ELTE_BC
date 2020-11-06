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
