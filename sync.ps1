# Sync script for NoteAI Quartz Digital Garden
# Usage: ./sync.ps1 ["Commit message optional"]

param (
    [string]$Message = "Update notes: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
)

Write-Host "🚀 Đang kiểm tra thay đổi trong NoteAI..." -ForegroundColor Cyan

# 1. Kiểm tra build Quartz trước khi sync
Write-Host "🔨 Đang chạy kiểm thử bản build Quartz..." -ForegroundColor Yellow
npx quartz build
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build thất bại! Vui lòng kiểm tra lỗi cú pháp trong các file Markdown." -ForegroundColor Red
    exit 1
}

# 2. Git add, commit, push
Write-Host "📦 Đang lưu trạng thái vào Git..." -ForegroundColor Yellow
git add .
git commit -m $Message

# Kiểm tra xem đã có git remote chưa
$remotes = git remote
if ($remotes) {
    Write-Host "🌐 Đang đồng bộ lên Git Remote (GitHub)..." -ForegroundColor Yellow
    git push
    Write-Host "✅ Đã đồng bộ lên GitHub thành công!" -ForegroundColor Green
} else {
    Write-Host "ℹ️ Chưa có Git Remote. Bạn có thể thêm remote GitHub bằng: git remote add origin <URL-CUA-BAN>" -ForegroundColor Cyan
}

Write-Host "🎉 Hoàn tất!" -ForegroundColor Green
