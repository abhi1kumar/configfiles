---
name: hoshyari-git-corp
description: How to access git.corp.adobe.com — on laptop use directly, on pluto use proxy via port xxxx
---

On laptop: git.corp works directly, no proxy needed.

Everything below applies to **pluto only**.

## curl

```bash
curl -sf --netrc --proxy socks5h://127.0.0.1:xxxx https://git.corp.adobe.com/api/v3/...
```

## git

The `.gitconfig` already has the proxy configured, so just use git normally:

```bash
git clone https://git.corp.adobe.com/org/repo.git
```

## If it fails

SSH tunnel not active, or port xxxx is stale. Kill ControlMaster (`ssh -O exit <host>`), reconnect.
