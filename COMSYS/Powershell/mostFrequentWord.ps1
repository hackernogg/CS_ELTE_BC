if ($args.Count -eq 1)
{
    if (!(Test-Path $args[0]))
    {
        Write-Output "The file is not exist"
        exit 1
    }
}
else
{
    Write-Output "The first parameter must be given: the filename"
    exit 1
}
$file=Get-Content $args[0]

$biggest=0
$biggestWord=""
for($i=0;$i -lt $file.Length;$i++)
{
    $words=$file[$i].Split(" ")
    for ($k=0;$k -lt $words.Count;$k++)
    {
        $word=$words[$k]
        $numberOfOccurencesForCurrentWord= (( $file | Select-String $word -AllMatches).Matches.Count)
        if ($numberOfOccurencesForCurrentWord -gt $biggest)
        {
            $biggest=$numberOfOccurencesForCurrentWord
            $biggestWord=$word
        }
    }
}
Write-Output "The word that was contained the most frequently is: $biggestWord"
Write-Output "I found it $biggest times in the file."
