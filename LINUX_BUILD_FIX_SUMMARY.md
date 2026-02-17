# Linux Build Fix Summary

## The Problem

When building Flutter apps on Linux (specifically with `cmake` and `clang` installed), the build often fails with a linker error:

> `/usr/bin/ld: cannot find -lstdc++`
> `clang++: error: linker command failed with exit code 1`

This happens because the default `clang++` configuration on some Linux setups does not correctly locate the standard C++ library (`libstdc++`), whereas `g++` (GCC) finds it without issues.

## The Solutions

### 1. Project-Specific Fix (Applied to `news_app`)

We modified `linux/CMakeLists.txt` to explicitly force the use of `g++` and `gcc` instead of letting CMake pick `clang++`.

```cmake
# linux/CMakeLists.txt
cmake_minimum_required(VERSION 3.13)
# Force GCC/G++
set(CMAKE_CXX_COMPILER "g++" CACHE STRING "C++ compiler" FORCE)
set(CMAKE_C_COMPILER "gcc" CACHE STRING "C compiler" FORCE)
project(runner LANGUAGES CXX)
# ...
```

### 2. Global Fix (Applied to Flutter SDK)

To prevent this issue in **future projects**, we patched the Flutter SDK template itself.
**File:** `flutter/packages/flutter_tools/templates/app/linux.tmpl/CMakeLists.txt.tmpl`

We injected the same compiler forcing code into the template. Now, every new project created with `flutter create` will automatically have the fix.

## Summary

- **Issue:** `clang++` fails to link `libstdc++` on this system.
- **Fix:** Switched the compiler to `g++` (and `gcc` for C).
- **Scope:**
  - Fixed manually in `news_app`.
  - Fixed permanently for new projects by patching the Flutter SDK template.
