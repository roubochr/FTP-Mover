<#
    config.ps1 - STL Mover Service Configuration
    
    All settings for StlMover.ps1 are configured here.
    See README.md for detailed documentation.
#>

# ===================== MODE & POLLING =========================

$Mode         = "Ftp"      # Options: "Ftp", "Local", "Smb"
$PollInterval = 2          # Seconds between checks

# ===================== FILE TYPES TO PROCESS ==================

# Extensions to process (comma-separated, no dots)
# Everything else goes to Scrap folder
$ProcessFileTypes = "stl,obj,dcm,ply"

# ===================== LOCAL & SMB SOURCES ====================

$SourceDirLocal = ""       # Local mode: e.g., "D:\Incoming"
$SourceDirSmb   = ""       # SMB mode: e.g., "\\SERVER\Share\Files"

# ===================== FTP CONNECTION SETTINGS ================

$FtpHost     = "127.0.0.1"
$FtpUser     = "username"
$FtpPassword = "password"

# FTP Security & Connection
$FtpUseExplicitTls          = $false    # Enable TLS encryption (AUTH TLS)
$FtpTlsFingerprint          = ""        # SHA-256 cert fingerprint for pinning (optional)
$FtpAcceptAnyTlsCertificate = $false    # Allow self-signed certs (testing only)

# ===================== FTP MONITORING SETTINGS ================

$FtpRemoteDir = "/"        # Root folder to monitor on FTP server
                          # This folder itself will NEVER be deleted (safety)

$FtpMinAgeSeconds = 15    # Only download files older than this
                          # Ensures uploads are complete before processing

# ===================== FTP BEHAVIOR ==========================

$FtpDeleteAfterDownload = $true     # Delete files from FTP after download?
                                    # Requires write permissions

$FtpSkipPreviouslySeen  = $true     # Skip files downloaded before?
                                    # Only works when FtpDeleteAfterDownload = $false

# ===================== FTP FOLDER CLEANUP ====================

$FtpMarkFolderAsReceived = $false   # Rename folders to "<name>_RECEIVED"?
$FtpDeleteSourceFolder   = $false   # Delete folders after processing?
                                    # NOTE: Requires RMD command support
                                    # FileZilla Server 1.x blocks this even with write access

# ===================== FILE ORGANIZATION ======================

$KeepProcessedSubfolders = $false   # true  = Preserve folder structure
                                    # false = Flatten with smart conflict resolution

# ===================== DUPLICATE DETECTION ====================

$EnableDuplicateDetection = $true   # Hash-based duplicate checking (SHA-256)
$HashRetentionDays        = 2       # Days to keep hash records

# ===================== LOGGING SETTINGS =======================

$LogLevel         = "DEBUG"         # Options: DEBUG, INFO, WARN, ERROR
$LogRetentionDays = 7               # Auto-cleanup logs older than this

# ===================== COMMON SCENARIOS ======================
#
# Read-Only FTP (files accumulate):
#   $FtpDeleteAfterDownload = $false
#   $FtpSkipPreviouslySeen = $true
#
# FTP with Auto-Delete (clean server):
#   $FtpDeleteAfterDownload = $true
#   $FtpSkipPreviouslySeen = $false  # Ignored when delete = true
#
# Local Folder Processing:
#   $Mode = "Local"
#   $SourceDirLocal = "D:\Incoming"
#   $KeepProcessedSubfolders = $false
#
# Network Share Processing:
#   $Mode = "Smb"
#   $SourceDirSmb = "\\SERVER\Medical\Scans"
#   $KeepProcessedSubfolders = $true
#
# ============================================================
# See README.md for complete documentation and troubleshooting
