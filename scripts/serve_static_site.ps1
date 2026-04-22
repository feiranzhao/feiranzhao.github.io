param(
  [string]$Root = "_site",
  [int]$Port = 4000
)

$ErrorActionPreference = "Stop"

function Get-ContentType([string]$Path) {
  switch ([System.IO.Path]::GetExtension($Path).ToLowerInvariant()) {
    ".html" { "text/html; charset=utf-8" }
    ".css" { "text/css; charset=utf-8" }
    ".js" { "application/javascript; charset=utf-8" }
    ".json" { "application/json; charset=utf-8" }
    ".xml" { "application/xml; charset=utf-8" }
    ".svg" { "image/svg+xml" }
    ".png" { "image/png" }
    ".jpg" { "image/jpeg" }
    ".jpeg" { "image/jpeg" }
    ".gif" { "image/gif" }
    ".webp" { "image/webp" }
    ".woff" { "font/woff" }
    ".woff2" { "font/woff2" }
    ".ttf" { "font/ttf" }
    default { "application/octet-stream" }
  }
}

$resolvedRoot = (Resolve-Path $Root).Path
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse("127.0.0.1"), $Port)
$listener.Start()

Write-Output "Serving $resolvedRoot at http://127.0.0.1:$Port/"

try {
  while ($true) {
    $client = $listener.AcceptTcpClient()

    try {
      $stream = $client.GetStream()
      $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII, $false, 1024, $true)
      $requestLine = $reader.ReadLine()
      if ([string]::IsNullOrWhiteSpace($requestLine)) {
        $client.Close()
        continue
      }

      while (($line = $reader.ReadLine()) -ne "") {
        if ($null -eq $line) { break }
      }

      $parts = $requestLine.Split(" ")
      $pathPart = if ($parts.Length -ge 2) { $parts[1] } else { "/" }
      $requestPath = [System.Uri]::UnescapeDataString($pathPart.TrimStart("/"))
      if ([string]::IsNullOrWhiteSpace($requestPath)) {
        $requestPath = "index.html"
      }

      $localPath = Join-Path $resolvedRoot $requestPath
      if ((Test-Path $localPath) -and (Get-Item $localPath).PSIsContainer) {
        $localPath = Join-Path $localPath "index.html"
      }

      if (-not (Test-Path $localPath)) {
        $body = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
        $header = "HTTP/1.1 404 Not Found`r`nContent-Type: text/plain; charset=utf-8`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
        $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
        $stream.Write($headerBytes, 0, $headerBytes.Length)
        $stream.Write($body, 0, $body.Length)
        $stream.Flush()
        $client.Close()
        continue
      }

      $body = [System.IO.File]::ReadAllBytes($localPath)
      $contentType = Get-ContentType $localPath
      $header = "HTTP/1.1 200 OK`r`nContent-Type: $contentType`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
      $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
      $stream.Write($headerBytes, 0, $headerBytes.Length)
      $stream.Write($body, 0, $body.Length)
      $stream.Flush()
      $client.Close()
    }
    catch {
      $client.Close()
    }
  }
}
finally {
  $listener.Stop()
}
