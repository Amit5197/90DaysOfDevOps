# Day 14 – Networking Fundamentals & Hands-on Checks

## Task
Get comfortable with core networking concepts and the commands you’ll actually run during troubleshooting.

You will:
- Map the **OSI vs TCP/IP models** in your own words
- Run essential connectivity commands
- Capture a mini network check for a target host/service

Keep it short, real, and repeatable.

---

## Expected Output
- A markdown file: `day-14-networking.md`
- Screenshots (optional) of key command outputs

---

# Quick Concepts Of Networkimng in DevOps.

## OSI vs TCP/IP Model

| OSI Layer (7) | OSI Layer Name   | TCP/IP Layer (4) | Key Concepts / Protocols |
|--------------|------------------|------------------|--------------------------|
| 7 | Application | Application | HTTP, HTTPS, FTP, SMTP, DNS |
| 6 | Presentation | Application | SSL/TLS, Encryption, Compression |
| 5 | Session | Application | Session Management |
| 4 | Transport | Transport | TCP, UDP |
| 3 | Network | Internet | IP, ICMP, IPSec |
| 2 | Data Link | Network/Link | Ethernet, ARP, VLAN, MAC |
| 1 | Physical | Network/Link | Cables, NIC, Signals |

---

#### Where **IP**, **TCP/UDP**, **HTTP/HTTPS**, **DNS** sit in the stack

|    Protocol  |       Layer      |
|--------------|------------------|
|     IP       |  Internet Layer  |
|  TCP/UDP     |  Transport Layer |
| HTTP,HTTPS,DNS|  Application Layer|

---

#### One real example: `curl https://example.com` = App layer over TCP over IP

- Layer 7 (Application): curl creates the HTTP request (GET /index.html).
- Layer 6 (Presentation): Encrypts the data with SSL/TLS (Locked box).
- Layer 5 (Session): Adds Session ID to manage the conversation.
- Layer 4 (Transport): Wraps in TCP for reliability (Port 54321 -> 443).
- Layer 3 (Network): Adds IP addressing (Src: 192.168.1.XX -> Dst: 93.184.216.XX).
- Layer 2 (Data Link): Adds MAC addresses for the local router.
- Layer 1 (Physical): Converts data to electrical signals/radio waves to travel the wire.

 ---

## Hands-on Practical Checklist On AWS EC2
- **Identity:** `hostname -I` (or `ip addr show`)
- Observation: EC2 instance private IP is 172-31-19-105 (internal AWS VPC network).

  <img width="1108" height="432" alt="image" src="https://github.com/user-attachments/assets/73f253ad-cd94-4811-9c70-2edb3790804d" />

---

- **Reachability:** `ping -c 4 google.com`
- Reachability: google.com (0% packet loss).
- Observation: Excellent network connectivity with ~1ms latency**

  <img width="1162" height="262" alt="image" src="https://github.com/user-attachments/assets/ff12aff4-5749-4fcc-902f-39a2365c5904" />

---

- **Path:** `traceroute gogle.com`
- Obervation: Successfully reached the destonation at hop 20,depspite a block of timeouts (* * *) on hops 11-29 caused by network security filtering.
  
 <img width="1471" height="278" alt="image" src="https://github.com/user-attachments/assets/6a73780b-b98a-44b9-8dcf-26537947c4df" />

---

- **Ports:** `ss -tulpn`
- Observation: SSH is listening on port 22 (on 0.0.0.0, meaning it accepts outside connections),and the local DNS resolver is listening on port 53 (on 127.0.0.53, for internal system use only)

  <img width="1606" height="371" alt="image" src="https://github.com/user-attachments/assets/f4add39d-573e-4291-af8d-aa1de7d22fe4" />

---

- **Name resolution:** `dig google.com`
- Observation: The DNS query returned status: NOERROR and successfully resolved google.com to 6 IP addresses: 192.178.218.100,192.178.218.138,192.178.218.113,192.178.218.139,192.178.218.102 and 192.178.218.101

 <img width="777" height="462" alt="image" src="https://github.com/user-attachments/assets/5a6d7578-f393-426f-909f-5165a5200d2f" />

---

- **HTTP check:** `curl -I https://www.gmail.com`
- Observation: Received HTTP status 301 (Moved Permanently), indicating the server is redirecting the request to https://www.gmail.com/

  <img width="672" height="367" alt="image" src="https://github.com/user-attachments/assets/cedc15fb-6fb2-4ed9-a27a-88938c570dd8" />

---

- **Connections snapshot:** `netstat -an | head` — count ESTABLISHED vs LISTEN (rough).
- Observation: Captured 1 ESTABLISHED connection on port 22 (the active SSH session) and multiple ports in LISTEN state.
  
  <img width="848" height="413" alt="image" src="https://github.com/user-attachments/assets/279e01b1-58e7-4e07-a39a-1e45fd3620c0" />

 ---

## Mini Task: Port Probe & Interpret
- Identify one listening port from `ss -tulpn`

- From the same machine, test it: `nc -zv localhost 22`
  
<img width="692" height="91" alt="image" src="https://github.com/user-attachments/assets/376b74fd-beef-45e2-ae81-6a0088cf458d" />

- If not reachable: Next steps would be checking service status (systemctl status ssh) or firewall rules.

  ---

## Reflection 
- Which command gives you the fastest signal when something is broken? ```ping```

- What layer (OSI/TCP-IP) would you inspect next if DNS fails? If HTTP 500 shows up?

- **If DNS Fails**
   - OSI: Layer 7 (Application)
   - TCP-IP: Application layer

  - Reason:
    - DNS is an application-layer protocol
    - Common issues include resolver misconfiguration,DNS service failure,or invalid records
    - If unresolved,move to:`Transport layer`

- **If HTTP 500 Shows Up**
  - OSI: Layer 7 (Application)
  - TCP-IP: Application layer

  - Reason:
    - TCP connection succeeded
    - Request reached the server
    - HTTP 500 indicates a server-side,application error,not a network issue


**Two follow-up checks you’d run in a real incident:**

1. DNS Troubleshooting
```bash
cat /etc/resolv.conf
dig google.com
```
<img width="947" height="597" alt="image" src="https://github.com/user-attachments/assets/bbe8ffdd-4805-4e68-987e-7bdf8ddce411" />

---

2. HTTP 500 Troubleshooting
```bash
tail -f application.log
systemctl status <web-service>
```

