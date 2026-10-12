# PDF Lab

PDF Lab puts every PDF tool in one place: merge, split, organize, rotate, edit and convert. It runs on your own computer and your files never leave it.

## Get the app

### Mac
**The easy way, one command.** Open the app **Terminal** (press Cmd+Space, type Terminal, press Return), paste this line and press Return:

```bash
curl -fsSL https://raw.githubusercontent.com/TaousSalim/PDF-Lab/main/install-mac.sh | bash
```

It downloads PDF Lab, puts it into Applications, adds Google Chrome if the Mac has none, and opens the app. PDF Lab then asks once for its username and password.

**Or by hand:**
1. Download **[PDF-Lab-Mac.zip](https://github.com/TaousSalim/PDF-Lab/releases/latest/download/PDF-Lab-Mac.zip)** and open it.
2. Drag **PDF Lab** into your **Applications** folder, then open it.
3. The first time, macOS says it cannot check the app. Open **System Settings**, **Privacy & Security**, scroll down and click **Open Anyway**.
4. PDF Lab asks once for its username and password. After that it opens directly.

Works on every Mac, Apple Silicon and Intel, with macOS 14.4 or newer. Word to PDF and Image to PDF also need Google Chrome. In English, French and German.

### Windows
Open the folder [updates](https://github.com/TaousSalim/PDF-Lab/tree/main/updates), click the newest `PDF-Lab-Setup-<version>.exe`, download it and run it. Needs Google Chrome.

## Updates
An installed PDF Lab looks here at its start. When a newer version exists it offers to install it, in one click.

- `updates/windows.json` and `updates/mac.json`: the newest version for each system, the name of its download, its size and its SHA-256.
- `updates/PDF-Lab-Setup-<version>.exe`: the Windows installer.
- `updates/PDF-Lab-Mac-Update-<version>.zip`: the files of the Mac app.

Versions are dates: `year.month.day.hourminute`.
