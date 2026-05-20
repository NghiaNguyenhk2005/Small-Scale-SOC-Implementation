# SOC mini model - Wazuh Security Monitoring Lab

## 🚀 Project Overview

This project demonstrates a **miniature Security Operations Center (SOC)** built entirely with open-source tools. The primary goal is to monitor, detect, and automatically respond to common cyber threats using the **Wazuh** SIEM/XDR platform.

The lab environment simulates a real-world enterprise setup, including a centralized Wazuh Server, monitored endpoints (Windows/Linux), and an attacker machine (Kali Linux) to execute test scenarios.

## 🎯 Key Objectives

- Build a functional SOC lab with centralized log collection and analysis.
- Detect **Brute Force attacks** (SSH/RDP) and map them to **MITRE ATT&CK (T1110)** .
- Monitor system integrity using **File Integrity Monitoring (FIM)** .
- Implement **automated incident response** (Active Response) to block attackers via firewall rules.
- Evaluate the system's performance based on false positive rates, alert volume, and detection time.

## 🏗️ System Architecture

![Architecture](https://via.placeholder.com/800x400?text=Kali+Linux+->+Target+Agent+->+Wazuh+Server+->+Dashboard)

| Component          | Role                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **Wazuh Server**   | Central manager for log analysis, rule matching, alert generation.  |
| **Wazuh Agents**   | Installed on Ubuntu & Windows to collect logs (auth, syslog, FIM).   |
| **Kali Linux**     | Attacker machine used to simulate Brute Force and file tampering.   |
| **Dashboard**      | Web interface (Kibana) for visualizing alerts and security events.  |

### Data Flow

1.  **Agent** collects system logs (e.g., `/var/log/auth.log`, file changes).
2.  Logs are encrypted (AES/TLS) and sent to **Wazuh Server** (port 1514/TCP).
3.  **Wazuh Server** decodes, analyzes, and matches logs against rules.
4.  Alerts are generated and displayed on the **Dashboard**.
5.  **Active Response** triggers `firewall-drop` commands to block malicious IPs.

## 🧪 Test Scenarios & Results

### 1. Brute Force Attack (T1110)

- **Attack**: Hydra used to perform SSH brute force against a Linux agent.
- **Detection**: Wazuh detected multiple failed logins (threshold exceeded).
- **Alert Level**: 10 (Critical)
- **MITRE Mapping**: T1110 – Brute Force
- **Result**: ✅ Attacker IP (`192.168.144.1`) identified and alert generated within seconds.

### 2. File Integrity Monitoring (FIM)

- **Attack**: Unauthorized modification of `/etc/passwd` (adding a root-privileged user).
- **Detection**: Real-time FIM detected checksum change and displayed a diff.
- **Result**: ✅ Immediate alert with file path, timestamp, and before/after hash.

### 3. Active Response (Automated Blocking)

- **Trigger**: Brute force rule activation.
- **Action**: Server sent `firewall-drop` command to agent.
- **Result**: ✅ Attacker IP automatically blocked via `iptables` for 60 seconds (validated via `active-responses.log`).

## 📊 Performance Evaluation

| Metric                | Result                                      |
| --------------------- | ------------------------------------------- |
| **False Positive**    | Low – rules triggered only on actual attacks |
| **Alert Volume**      | Spike only during attacks; no noise in idle |
| **Detection Time**    | Near real-time (few seconds for brute force, instant for FIM) |

## 🛠️ Key Configurations

### Wazuh Server (`wazuh_manager.conf` Highlights)

- **Agent Registration**: Dynamic on port 1515 with source IP validation.
- **Vulnerability Detector**: Scans for CVEs every 5 minutes (Canonical & NVD feeds).
- **FIM**: Real-time monitoring on `/etc`, `/usr/bin`, `/usr/sbin`, etc.
- **Active Response**: Auto-block rule IDs 5712, 5763 with 60s timeout.

### Wazuh Agent (`ossec.conf` Highlights)

- **Connection**: TCP to `192.168.1.6:1514` with AES encryption.
- **Rootcheck**: Scans for rootkits, trojans, and anomalies every 12 hours.
- **Syscollector**: Collects hardware, OS, packages, ports, and processes hourly.
- **SCA**: Compliance checks against security benchmarks.


## 🧰 Tools & Technologies

- **Wazuh** (SIEM/XDR)
- **Ubuntu Server** (Wazuh Manager & Linux Agent)
- **Windows 10/11** (Windows Agent)
- **Kali Linux** (Attacker machine)
- **Hydra** (Brute force simulation)
- **MITRE ATT&CK Framework**
- **NIST SP 800-61** (Incident Response guidelines)

## 📚 Lessons Learned

- Wazuh provides enterprise-grade security monitoring **completely free** and open-source.
- Default rules are effective for common attacks (e.g., brute force), reducing the need for extensive custom tuning.
- FIM is critical for detecting **persistence** and **privilege escalation** in real-time.
- Active Response dramatically reduces manual intervention, enabling **automated threat containment**.

## 🔮 Future Improvements

- Integrate **Threat Intelligence** feeds (e.g., MISP, AlienVault OTX) to correlate attacks.
- Add network device logs (firewalls, routers, IDS/IPS) for broader visibility.
- Develop custom rules for **lateral movement** and **data exfiltration**.
- Implement a full **SOAR** (Security Orchestration, Automation, and Response) workflow.

## 👤 Author

**Nguyễn Đức Nghĩa**  
- Full implementation, testing, and documentation based on academic research.  
- [GitHub Profile](https://github.com/yourusername)  

*Project submitted for "Mật mã và An ninh mạng (CO3069)" – Ho Chi Minh City University of Technology (HCMUT), April 2026.*

## 📄 License

This project is for educational purposes. All configurations and scripts are provided under the MIT License.

---

⭐ **Feel free to star this repo if you found it useful for learning SOC and Wazuh!**
