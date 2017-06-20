# realm-object-server
# Table of Contents

- [introduction](#introduction)
- [installation](#installation)
- [quick-start](#quick-start)
- [shell-access](#shell-access)

# Introduction

Dockerfile to build a jd-backend container image.
Run a container based on this image.

# installation

```bash
docker build -t realm-object-server .
```

# Quick Start

Run the jd-backend image
```bash
docker run --rm --name realm-object-server -p 9080:9080 realm-object-server
```

# Shell Access

```bash
docker exec -it realm-object-server bash
```
