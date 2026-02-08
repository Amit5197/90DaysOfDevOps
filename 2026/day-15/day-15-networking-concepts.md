# Networking Concepts: DNS, IP, Subnets & Ports

### Task 1: DNS – How Names Become IPs
1. Explain in 3–4 lines: what happens when you type `google.com` in a browser?

**Answer**
    1- First the browser checks in local cache for the corresponding IP address.
    If not present browser will send request to DNS(Domain Name Service) requesting IP address.
    
    2- Computer sets up a secure connection (HTTPS) with Google’s servers using TCP/IP.
    
    4- The request is routed through Google’s load balancers to the right web server.
    
    4- The web server processes the request, may talk to application servers and databases, 
    and then sends back the webpage you see.
    
2. What are these record types? Write one line each:
   - `A` - Maps a domain name to an IPv4 address.
   - `AAAA` - Maps a domain name to an IPv6 address.
   - `CNAME` - Creates an alias from one domain name to another.
   - `MX` - Specifies mail servers responsible for handling email for the domain.
   - `NS` - Defines the authoritative name servers for the domain.
   
3. Run: `dig google.com` 

![snapshot](dig.png)

`A` record gives IPv4 address - 142.250.67.174
`TTL` Time To Live - 46secs

### Task 2: IP Addressing
1. What is an IPv4 address? How is it structured?

**Answer** - An IP Address is a unique numerical label assigned to each device connected to a computer network 
  that uses the Internet Protocol for communication.
  * IP address is divided into -
    - Network Portion : Identifies the network
    - Host Portion : Identifies the individual device
    - Example : IP 192.168.1.10 
        - Network Portion - 192.168.1.0
        - Host Portion - 10
    
2. Difference between **public** and **private** IPs.

**Public IP**                                           |   **Private IP**
--------------------------------------------------------|--------------------------------------------------------------------
It is assigned by ISP to every device on the internet.  |   Assigned within private networks to identify devices locally.
It is unique across the entire internet.                |   Not routable on the internet.
Example: `192.168.x.x`, `10.x.x.x`,                     |   Example: `103.176.157.29`, `8.8.8.8 (Google DNS)`
    `172.16.x.x – 172.31.x.x`                           |



3. What are the private IP ranges?
   - `10.x.x.x` - Large enterprise networks
   - `172.16.x.x – 172.31.x.x` - Medium-sized organizations
   - `192.168.x.x` - Home & small office networks
   
4. Run: `ip addr show` — identify which of your IPs are private

![snapshot](ip_addr.png)

- 127.0.0.1/8 - Reserved for local host communication
- 192.168.0.113/24 - This is a private IP address.


### Task 3: CIDR & Subnetting
1. What does `/24` mean in `192.168.1.0/24`?

**Answer** - /24 is CIDR notation. It tells us how many bits of the IP address are used for network portion.
            Here first `24` bits (out of 32) are reserved for network. That leaves 8 bits for the host address.
            IP range : (192.168.1.0 - 192.168.1.255) Total :256 IP's
            
2. How many usable hosts in :
 - `/24` : 254
 - `/16` : 65,534
 - `/28` : 14
 
3. Explain in your own words: why do we subnet?
**Answer** - Subnet divides one large network into small, manageable and efficient sub-networks.
 * Improves performance - Local traffic stays within its subnet, reducing congestion.
 * Enhanced Security - Access to one subnet doesn’t automatically expose the entire network.
 * Troubleshooting & Management - Smaller networks are easier to monitor, isolate issues, and maintain.

4. Quick exercise — fill in:

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
|------|-----------------|-----------|--------------|
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16        | 14           |

### Task 4: Ports – The Doors to Services
1. What is a port? Why do we need them?

**Answer** 
- Port is a logical endpoint in networking. 
- IP address identifies the device on a network and port number specifies which service the data goes to on that device. 
- Port is needed to differentiate between services, allowing multiple services to run on the same machine and still be uniquely identified.

2. Document these common ports:

| Port | Service |
|------|---------|
| 22   | SSH     |
| 80   | Nginx   |
| 443  | HTTPS   |
| 53   | DNS     |
| 3306 | MySQL   |
| 6379 | Redis   |
| 27017| MongoDB |

3. Run `ss -tulpn` — match at least 2 listening ports to their services

- Port 22 : Service SSH
- Port 80 : Apache2

### Task 5: Putting It Together

- When you run `curl http://localhost:80`
   * Protocol HTTP
   * Localhost : Resolve to loopback IP it resolves to 127.0.0.1
   * Port 80 : Apache service 
   
- Your app can't reach a database at `10.0.1.50:3306` — what would you check first?
   * `ss -tulpn | grep 3306` - Check if port is open and service is listening.
   * `systemctl status mysql` - Check service status
   * `nc -zv 10.0.1.50 3306` - Check connectivity
   * `journalctl -u mysql` - Check Logs

