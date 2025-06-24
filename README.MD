<div align="center">
  <h1>🖥️ ChathuraOS 🖥️</h1>
  <p>
    <strong>A simple 16-bit Operating System written from scratch in Assembly.</strong>
  </p>
  <p>
    Built for a university project on Computer Architecture and Operating Systems.
  </p>
  <br>
  <p>
    <img src="URL_TO_YOUR_MAIN_SCREENSHOT" alt="ChathuraOS Screenshot" width="80%">
  </p>
</div>

---

## 🚀 Features

This OS was built from the ground up and includes a variety of core features that demonstrate fundamental OS concepts.

| Feature                     | Description                                                                         |
| --------------------------- | ----------------------------------------------------------------------------------- |
| 📀 **Two-Stage Bootloader** | A 512-byte bootloader that loads a larger kernel from a virtual floppy disk.        |
| ⌨️ **Interactive Shell**    | A command-line interface that reads and processes user input.                       |
| ℹ️ **Built-in Commands**    | A suite of commands including `about`, `date`, `time`, `info`, `help`, and `clear`. |
| 🕒 **Hardware Clock**       | Reads the system date and time directly from the hardware RTC.                      |

---

## 📸 Gallery

<table align="center">
  <tr>
    <td align="center"><strong>Welcome Screen & Help</strong></td>
    <td align="center"><strong>System Info & Date/Time</strong></td>
  </tr>
  <tr>
    <td><img src="URL_TO_WELCOME_SCREENSHOT" alt="Welcome Screen" width="100%"></td>
    <td><img src="URL_TO_INFO_SCREENSHOT" alt="Info Screen" width="100%"></td>
  </tr>
</table>

---

## 🛠️ Development Environment

This OS was developed using a standard low-level toolchain.

- **Operating System:** Developed in an Ubuntu environment running inside VirtualBox.
- **Assembler:** **NASM** (The Netwide Assembler)
- **Emulator:** **QEMU**

---

## ⚙️ Building and Running

1.  Ensure you have `nasm` and `qemu-system-x86` installed in your Linux environment.
2.  Clone the repository:
    ```bash
    git clone [https://github.com/your-username/ChathuraOS.git](https://github.com/your-username/ChathuraOS.git)
    cd ChathuraOS
    ```
3.  From the project's root directory, run the build script:
    ```bash
    ./build.sh
    ```
4.  This script will automatically assemble the source code, create the `chathuraos.img` disk image, and launch the OS in QEMU.
