# Perl Redis Micro
<div style="display: flex; align-items: center;">
<img src="https://media.charlesleifer.com/blog/photos/redis-logo.png" alt="Redis Banner"/>
</div>

<div style="display: flex; align-items: center;" >
A simple key-value storage system with Redis using Perl, which runs in the terminal.
</div>

## What's Redis?
Redis (*Remote Dictionary Server*) is a **super-fast in-memory database** used as a cache, message broker, or temporary database.

### Feature
- Auto Backup
- Time to Live
- Terminal Color
- Built in Documentation

### Install Module

```bash
cpan JSON::PP Term::ANSIColor
```

### Run Script
```bash
chmod +x perlminiredis.pl
./perlminiredis.pl
```

### Output Program

```bash
>> SET nama "Fadhli" 10
>> TTL nama
>> SAVE
```

---

### Next Update

- AUTH Password
- Encrypt Data

---
