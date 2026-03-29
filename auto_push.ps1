# Auto Push Script for Immergency
# Watches for file changes and auto-commits + pushes every 60 seconds
# Run: powershell -ExecutionPolicy Bypass -File .\auto_push.ps1
# Stop: Press Ctrl+C

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Auto-Push Script Started" -ForegroundColor Cyan
Write-Host "  Watching for changes every 60 seconds" -ForegroundColor Cyan
Write-Host "  Press Ctrl+C to stop" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

while ($true) {
    git add .
    $status = git status --porcelain
    if ($status) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        git commit -m "auto-save: $timestamp"
        $pushResult = git push 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] Pushed at $timestamp" -ForegroundColor Green
        } else {
            Write-Host "[ERR] Push failed at $timestamp : $pushResult" -ForegroundColor Red
        }
    } else {
        $timestamp = Get-Date -Format "HH:mm:ss"
        Write-Host "[$timestamp] No changes detected." -ForegroundColor DarkGray
    }
    Start-Sleep -Seconds 60
}
