# PDF Lab

PDF Lab puts every PDF tool in one place: merge, split, organize, rotate, edit and convert. It runs on your own computer and your files never leave it.

## Get the app

### Mac
**The easy way, one command.** Open the app **Terminal** (press Cmd+Space, type Terminal, press Return), paste this line and press Return:

```bash
curl -fsSL https://raw.githubusercontent.com/TaousSalim/PDF-Lab/main/install-mac.sh | bash
```

It downloads PDF Lab, puts it into Applications, and opens the app. If the Mac has neither Brave nor Chrome (nor Edge), it adds Google Chrome, which two of the tools need. PDF Lab then asks for its licence key (see below).

**Or by hand:**
1. Download **[PDF-Lab-Mac.zip](https://github.com/TaousSalim/PDF-Lab/releases/latest/download/PDF-Lab-Mac.zip)** and open it.
2. Drag **PDF Lab** into your **Applications** folder, then open it.
3. The first time, macOS says it cannot check the app. Open **System Settings**, **Privacy & Security**, scroll down and click **Open Anyway**.
4. PDF Lab asks for its licence key (see below). After that it opens directly.

Works on every Mac, Apple Silicon and Intel, with macOS 14.4 or newer. Word to PDF and Image to PDF also need Brave or Google Chrome to be installed (it is never opened). In English, French and German.

### Windows
Open the folder [updates](https://github.com/TaousSalim/PDF-Lab/tree/main/updates), click the newest `PDF-Lab-Setup-<version>.exe`, download it and run it. Needs Google Chrome.

## Licence key
PDF Lab needs a licence key, made for your computer:

1. Open PDF Lab. It shows **Your computer code** (it looks like `ABCD-EFGH-IJKL-MNOP`). Click **Copy**.
2. Send that code to the person who gave you PDF Lab.
3. You receive a key that starts with `PDFLAB-`. Paste it into PDF Lab and click **Activate**.

A key works on that one computer only. A trial key stops PDF Lab on its last day; a licence key lasts for its period, or for life.

## Updates
An installed PDF Lab looks here at its start. When a newer version exists it offers to install it, in one click.

- `updates/windows.json` and `updates/mac.json`: the newest version for each system, the name of its download, its size and its SHA-256.
- `updates/PDF-Lab-Setup-<version>.exe`: the Windows installer.
- `updates/PDF-Lab-Mac-Update-<version>.zip`: the files of the Mac app.

Versions are dates: `year.month.day.hourminute`.
