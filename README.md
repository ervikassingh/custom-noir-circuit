# Custom Noir Circuit

This repository is used to test and learn Noir circuits for zero-knowledge proof (ZKP) development.

## Overview

Noir is a domain-specific language for creating zero-knowledge proofs. This project contains custom circuits to experiment with and understand ZKP concepts.

## Project Structure

```
.
├── Nargo.toml          # Noir project configuration
└── src/
    └── main.nr         # Main circuit implementation
```

## Getting Started

### Prerequisites

- [Nargo](https://noir-lang.org/getting_started/installation/) - The Noir package manager

### Building

```bash
nargo build
```

### Testing

```bash
nargo test
```

### Proving

```bash
nargo prove
```

### Verifying

```bash
nargo verify
```

## Resources

- [Noir Documentation](https://noir-lang.org/)
- [Noir GitHub](https://github.com/noir-lang/noir)
