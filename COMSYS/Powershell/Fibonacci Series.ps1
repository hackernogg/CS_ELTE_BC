$n = Read-Host

function get-feb ($n) {

$current = 0 ;
$previous = 1;
for ($1=0;$i -le $n; $i++) {
$current;
$current,$previous = ($current+$previous),$current}
}
get-feb ($n)
