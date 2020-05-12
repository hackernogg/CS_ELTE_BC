# Write-Output "hello world"
# Write-Output $args
# $args
# to a specific parameter:
# $args[0]
# the number of the parameters
# $args.Count
#variables
$a="apple,banana,orange,panda,bear"

#string functions
$a.Substring(2,3)
#$a.Split(",")
$a.Split(",")[0]
------------------------------------------
#statemnets and loops
if ($args.length -ne 0){
     Write-Output" the script should note called out"
     exit 1
     }
#counting loop
for ($1=0;$i -le 10; $i++)
{
 Get-Random -Minimum 1 -Maximum 100
 }
#while loop
$i=0
while ( $i -le 10) {
  Get-Random
  $i++
  }
  #iterate through an array
  $array=Get-Content something.txt
  #in shell would be: array=`cat something.exe`
  for($i=0;$i -lt $array.length;$i++){
    $array[$i]
    }
  ------------------------------------------------
  #get lines from a file which contains apple
#Get-Content .\apple.txt | Select-String "apple"

# the alternate for wc
# cound how many lines we have that contains the apple keyword
#Get-Content .\apple.txt | Select-String "apple" | Measure-Object

# Count things from files that contains numbers
(Get-Content .\number.txt | Measure-Object -Maximum).Maximum
----------------------------------------------------
$a=5
$b=10

$c=$a+$b
$c++
$c

if ($c % 2 -eq 0)
{
echo " the $a + $b is even"
}
else
{
echo " it is odd"
}
----------------------------------------
$file=Get-Content $args[0]
$even=0
$odd=0
for($1=0;$i -lt $file.Length;$i++)
{
$sumInline=$file[$i].Split(" ")
for($k=0;$k -lt$sumInline.Length;$k++)
{
 if($sumInline[$k] % 2 -eq 0)
 {
   $even=$even+$sumInline[$k]
   }
   else
   {
   $odd=$odd+$sumInline[$k]
   }
   }
   }
   $even
   $odd
   --------------------------------
   $name=Read-Host "hi, what is ur name?"
Write-Output "Hi $name, Glad to see u again"
