function Remove-UnnessecaryContent {
    [cmdletBinding()]
    param(
        [string] $Content,
        [Array] $Rules
    )
    foreach ($Rule in $Rules) {
        $Content = $Content -replace $Rule
    }
    $Content
}