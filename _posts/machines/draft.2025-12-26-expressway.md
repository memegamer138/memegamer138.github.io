---
title: "HTB: Expressway"
date: 2025-12-24
categories: [HackTheBox, Machines]
tags: [Linux, HTB, machine, SSH]
diffficulty: Easy
layout: post
author: Shakthi Vel
github_username: Shakthi Vel
---

## Executive Summary


## Tools Used


## Reconnaissance
A basic nmap scan revealed an open port 22 receiving SSH connections. Upon further investigating the port, I got its version.

```bash
nmap -p 22 -sV -sC 10.10.11.87
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-26 07:36 PST
Host is up (0.088s latency).

PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 10.0p2 Debian 8 (protocol 2.0)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

Quite weird that only port 22 is open. Let's try UDP enumeration.

This actually showed another open port.

```bash
PORT      STATE  SERVICE
500/udp   open   isakmp
```

