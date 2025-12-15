---
title: "HTB: Spooky Pass Challenge"
date: 2025-12-14
categories: [HackTheBox, Challenges]
tags: [reverse_engineering, HTB, challenge]
diffficulty: Very Easy
author: memegamer138
---

This is my writeup for the SpookyPass challenge on HTB.

After downloading and extracting the ZIP file using the password *hackthebox*, you will see a single file called *pass*.
Let's run it.

![alt text](/assets/challenges/spookyPass/image.png)

Let's have a look at the file through a reverse engineering tool. I'm going to use ghidra.

![alt text](/assets/challenges/spookyPass/image-1.png)

After adding *pass*, we can analyze it.

![alt text](/assets/challenges/spookyPass/image-2.png)

We have a general idea of how the file works, it gives the prompt for password first, you enter something, then it verifies it. This means that the actual password has to be stored in the file somewhere. Based on this intuition, let's analyze the defined strings in the file.

![alt text](/assets/challenges/spookyPass/image-3.png)

And there you go. After browsing through the defined strings, we can see the correct password. Let's verify it.

![alt text](/assets/challenges/spookyPass/image-4.png)