# Custom Noir Circuit

This repository is used to test and learn Noir circuits for zero-knowledge proof (ZKP) development.

## Overview

Noir is a domain-specific language for creating zero-knowledge proofs. This project contains custom circuits to experiment with and understand ZKP concepts. The project uses Nargo for circuit development and Barretenberg as the zero-knowledge proof system backend for proof generation and verification.

## Project Structure

```
.
├── Nargo.toml          # Noir project configuration
├── Prover.toml         # Prover configuration
└── src/
    └── main.nr         # Main circuit implementation
```

## Getting Started

### Prerequisites

- [Nargo](https://noir-lang.org/getting_started/installation/) - The Noir package manager
- [Barretenberg](https://github.com/AztecProtocol/barretenberg) - Zero-knowledge proof system backend

### Testing

```bash
# Runs all tests
nargo test
```

### Checking

```bash
# Checks circuit for any errors
nargo check
```

### Compile

```bash
# Compiles circuit to ACIR (Abstract Circuit Intermediate Representation)
nargo compile
```

### Executing

```bash
# Compiles circuit and creates a witness
nargo execute
```

### Barretenberg generate verification key

```bash
# Generates a verification key to verify the proof
bb write_vk -b ./target/custom_noir_circuit.json -o ./verification_keys
```

### Barretenberg generate verification key using keccak for smart contracts

```bash
# Generates a verification key to verify the proof
bb write_vk --oracle_hash keccak -b ./target/custom_noir_circuit.json -o ./verification_keys
```

### Barretenberg generate solidity verifier smart contract

```bash
# Generates a verification key to verify the proof
bb write_solidity_verifier -k ./verification_keys/vk -o ./contracts/Verifier.sol
```

### Barretenberg generate proof

```bash
# Generates a proof using the circuit, witness and verification key
bb prove -b ./target/custom_noir_circuit.json -w ./target/custom_noir_circuit.gz -k ./verification_keys/vk -o ./proofs
```

### Barretenberg verify proof

```bash
# Verifies the proof using the verification key
bb verify -k ./verification_keys/vk -p ./proofs/proof -i ./proofs/public_inputs
```

## Resources

- [Noir Documentation](https://noir-lang.org/)
- [Noir GitHub](https://github.com/noir-lang/noir)
