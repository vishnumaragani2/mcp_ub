Add-Type -AssemblyName System.IO.Compression.FileSystem
$path = 'c:\v\projects\mcp\US\ub_dataflow\UB_VSCode\Documents\Aetna TE Fields and Rules - UB 5.xlsx'
$zip = [System.IO.Compression.ZipFile]::OpenRead($path)

# Read workbook.xml to get sheet names and rIds
$wbEntry = $zip.GetEntry('xl/workbook.xml')
$wbStream = $wbEntry.Open()
$wbReader = New-Object System.IO.StreamReader($wbStream)
[xml]$wbXml = $wbReader.ReadToEnd()
$wbReader.Close(); $wbStream.Close()

# Read workbook.xml.rels to map rId to sheet file
$relEntry = $zip.GetEntry('xl/_rels/workbook.xml.rels')
$relStream = $relEntry.Open()
$relReader = New-Object System.IO.StreamReader($relStream)
[xml]$relXml = $relReader.ReadToEnd()
$relReader.Close(); $relStream.Close()

# Find the target sheet
$sheetName = 'Final Edit Rules'
$ns = New-Object System.Xml.XmlNamespaceManager($wbXml.NameTable)
$ns.AddNamespace('s', 'http://schemas.openxmlformats.org/spreadsheetml/2006/main')
$ns.AddNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships')
$sheetNode = $wbXml.workbook.sheets.sheet | Where-Object { $_.name -eq $sheetName }
$rId = $sheetNode.id

$rel = $relXml.Relationships.Relationship | Where-Object { $_.Id -eq $rId }
$sheetFile = 'xl/' + $rel.Target

# Read shared strings
$ssEntry = $zip.GetEntry('xl/sharedStrings.xml')
$sharedStrings = @()
if ($ssEntry) {
    $ssStream = $ssEntry.Open()
    $ssReader = New-Object System.IO.StreamReader($ssStream)
    [xml]$ssXml = $ssReader.ReadToEnd()
    $ssReader.Close(); $ssStream.Close()
    $sharedStrings = $ssXml.sst.si | ForEach-Object {
        if ($_.t) { if ($_.t -is [string]) { $_.t } else { $_.t.'#text' } }
        elseif ($_.r) { ($_.r | ForEach-Object { $_.t.'#text' }) -join '' }
        else { '' }
    }
}

# Read the sheet data
$shEntry = $zip.GetEntry($sheetFile)
$shStream = $shEntry.Open()
$shReader = New-Object System.IO.StreamReader($shStream)
[xml]$shXml = $shReader.ReadToEnd()
$shReader.Close(); $shStream.Close()
$zip.Dispose()

$rows = $shXml.worksheet.sheetData.row
foreach ($row in $rows) {
    $cells = $row.c
    $values = @()
    foreach ($cell in $cells) {
        $val = $cell.v
        if ($cell.t -eq 's' -and $val -ne $null) {
            $val = $sharedStrings[[int]$val]
        }
        $values += $val
    }
    ($values -join "`t")
}
