$root = "c:\Users\baode\Downloads\portfolio_legiabao"
$port = 8087
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Portfolio server for Lê Gia Bảo running at http://localhost:$port"
Write-Host "Press Ctrl+C to stop"

$mimeTypes = @{
    '.html' = 'text/html; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.gif'  = 'image/gif'
    '.svg'  = 'image/svg+xml'
    '.ico'  = 'image/x-icon'
    '.pdf'  = 'application/pdf'
    '.docx' = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    '.woff' = 'font/woff'
    '.woff2'= 'font/woff2'
}

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $path = $context.Request.Url.LocalPath
    if ($path -eq '/') { $path = '/index.html' }
    $filePath = Join-Path $root ($path -replace '/', '\')
    
    if (Test-Path $filePath -PathType Leaf) {
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { 'application/octet-stream' }
        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        $context.Response.ContentType = $contentType
        if ($context.Request.HttpMethod -ne 'HEAD') {
            $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        }
    } else {
        $context.Response.StatusCode = 404
        $msg = [System.Text.Encoding]::UTF8.GetBytes("Not Found: $path")
        $context.Response.OutputStream.Write($msg, 0, $msg.Length)
    }
    $context.Response.Close()
    Write-Host "$($context.Request.HttpMethod) $path -> $($context.Response.StatusCode)"
}
