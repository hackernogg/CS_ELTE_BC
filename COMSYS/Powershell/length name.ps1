$fname=$args[0]
$lengthname = Read-Host "Enter the length of the first name"
$file= Get-Content $fname 
if($args.count -eq 1){
if(test-path $fname){
foreach($i in $file ){
$i = $i -replace " .+$"
foreach($s in $i){
if($s.length -gt $lengthname){
write-host $s

}}}}


else{
write-host "You need a filename in the parameter" -ForegroundColor Blue

}
}


else{
write-host "You need one parameter" -ForegroundColor Red

}
