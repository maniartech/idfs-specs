$word = New-Object -ComObject Word.Application
$word.Visible = $False

# Write-Host "Current directory: $(Get-Location)"
# Write-Host "Opening document: $($args[0])"

# Construct the full path for the Word document
# $wordDocumentPath = Join-Path -Path (Get-Location).Path -ChildPath $args[0]
$wordDocumentPath = $args[0]

if (Test-Path $wordDocumentPath) {
    # print the path of the word document
    # Write-Host "Word document path: $wordDocumentPath"

    $document = $word.Documents.Open($wordDocumentPath)

    # Construct the full path for the PDF output file
    $pdfOutputPath = $wordDocumentPath -replace ".docx$", ".pdf"

    # Save the document as PDF using the constructed path
    $document.SaveAs([ref] $pdfOutputPath, [ref] 17)
    $document.Close()
} else {
    Write-Host "File not found: $($args[0])"
}

$word.Quit()
$null = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word)

Write-Host "PDF file generated at $pdfOutputPath"
