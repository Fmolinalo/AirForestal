<#
Interactive PowerShell script to initialize a Git repository, create a .gitignore if missing,
make an initial commit, and add a remote named 'origin' pointing to the repository AirForestal.

Usage: from the project folder run: .\setup-git.ps1
#>

param()

function Write-Info($msg) { Write-Host $msg -ForegroundColor Cyan }
function Write-Err($msg) { Write-Host $msg -ForegroundColor Red }

$proj = Get-Location
Write-Info "Proyecto: $proj"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Err "Git no está instalado o no está en PATH. Instala Git antes de continuar. https://git-scm.com/downloads"
    exit 1
}

# Initialize repo if needed
if (-not (Test-Path .git)) {
    Write-Info "Inicializando repositorio Git..."
    git init
} else {
    Write-Info "Repositorio Git ya inicializado."
}

# Ensure .gitignore exists
if (-not (Test-Path .gitignore)) {
    Write-Info "Creando .gitignore básico..."
    @"
node_modules/
dist/
build/
.env
.vscode/
*.log
"@ | Out-File -Encoding UTF8 .gitignore
} else {
    Write-Info ".gitignore ya existe, no se sobrescribirá."
}

# Stage files
Write-Info "Añadiendo archivos al índice (git add .)..."
git add .

# Commit
try {
    git commit -m "Inicial commit: añadir proyecto AirForestal" -q
    Write-Info "Commit realizado."
} catch {
    Write-Info "No se realizó commit (posible que no hubiera cambios nuevos)."
}

# Ask for remote details
$defaultHttps = "https://github.com/<TU_USUARIO>/AirForestal.git"
Write-Host "Introduce la URL remota del repositorio 'AirForestal' o presiona Enter para usar (reemplaza <TU_USUARIO>): $defaultHttps"
$remoteUrl = Read-Host "Remote URL"
if ([string]::IsNullOrWhiteSpace($remoteUrl)) {
    $remoteUrl = $defaultHttps
}

if (-not $remoteUrl) { Write-Err "No se proporcionó URL remota. Saliendo."; exit 1 }

# Add remote
try {
    git remote remove origin 2>$null
} catch {}

git remote add origin $remoteUrl
Write-Info "Remote 'origin' configurado -> $remoteUrl"

# Push
Write-Info "Estableciendo rama principal a 'main' y empujando al remoto..."
git branch -M main
try {
    git push -u origin main
    Write-Info "Push completado."
} catch {
    Write-Err "Push fallido. Comprueba tus credenciales o la existencia del repo remoto. Puedes reintentar: git push -u origin main"
}

Write-Info "Listo. Puedes verificar con: git remote -v; git status; git log --oneline -n 5"
