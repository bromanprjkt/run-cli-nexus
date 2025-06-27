# 🧠 run-cli-nexus

Script bash untuk menjalankan **Nexus Node CLI** secara otomatis menggunakan Node ID yang kamu input sendiri.  
Cocok buat pengguna VPS atau server Linux yang ingin menjalankan node Nexus tanpa setup ribet.

Bash script to automatically run **Nexus Node CLI** using your own Node ID.  
Perfect for VPS or Linux server users who want to run a Nexus node without complex setup.

---

## ⚙️ Fitur / Features

- ✅ Instalasi otomatis dependensi (Rust, build tools, Nexus CLI)  
- ✅ Jalankan Nexus Node hanya dengan Node ID  
- ✅ Tanpa wallet address / login  
- ✅ Jalan terus tanpa timeout

Auto-installs dependencies (Rust, build tools, Nexus CLI)  
Run Nexus Node by simply entering your Node ID  
No wallet address or login required  
Runs continuously without auto-exit

---

## 🚀 Cara Pakai / How to Use

```bash
git clone https://github.com/bromanprjkt/run-cli-nexus.git
cd run-cli-nexus
chmod +x nexus.sh
./nexus.sh
