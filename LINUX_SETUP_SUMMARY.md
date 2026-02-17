# Linux Flutter Setup – Problem & Solution Summary

## The Problems

### 1. Flutter Snap (initial setup)
- **CMake:** “A required package was not found”  
  The `audioplayers_linux` plugin needs system dev packages (GStreamer, GTK). Snap’s CMake couldn’t find them.
- **Linker missing:** “Failed to find any of [ld.lld, ld] in … llvm-10/bin”  
  The Snap’s LLVM directory had no linker (`ld` / `ld.lld`).
- **glibc mismatch:** “undefined reference to … @GLIBC_2.34 / GLIBC_2.38”  
  The Snap uses an older glibc; your system GStreamer/GTK libs need a newer glibc, so linking failed.

### 2. After switching to manual Flutter
- **C++ stdlib:** “/usr/bin/ld: cannot find -lstdc++”  
  The Linux build was using **clang++**, which didn’t find the C++ standard library (and later: “type_traits file not found”).

### 3. Running from the editor
- You wanted to **debug from VS Code/Cursor** (F5, breakpoints) instead of only from the terminal.

---

## The Solutions

### 1. Stop using Flutter Snap
- Removed: `sudo snap remove flutter`
- Installed Flutter manually (e.g. clone into `~/flutter`, add `~/flutter/bin` to `PATH`).  
  This fixed the Snap-related CMake, linker, and glibc issues.

### 2. Install Linux dev packages (if needed)
For `audioplayers_linux` and Linux desktop build:
```bash
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgtk-3-dev libglib2.0-dev
```

### 3. Use g++ for the Linux build
- **Change:** In `linux/CMakeLists.txt`, the C/C++ compiler was forced to **g++/gcc** (before `project(...)`).
- **Why:** So the linker finds `libstdc++` and the compiler finds C++ headers (`type_traits`, etc.), avoiding the clang/libstdc++ issues.

### 4. Debug from VS Code/Cursor
- **`.vscode/launch.json`:** Added a “Flutter (Linux)” configuration with `deviceId: "linux"` so F5 runs and debugs on Linux.
- **`.vscode/settings.json`:** Set `dart.flutterSdkPath` to your manual Flutter path (e.g. `"/home/abdosalah/flutter"`) so the editor uses that SDK.

---

## Result

- Flutter runs from **manual install** (not Snap).
- Linux app **builds** using g++ and system libs.
- You can **run and debug** with F5 in VS Code/Cursor by choosing **“Flutter (Linux)”** in the Run and Debug panel.

More detail (Snap workarounds, bind-mount, etc.) is in `LINUX_SNAP_FIX.md`.
