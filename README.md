# Tokenized Agriculture Food Traceability System

A blockchain-based food traceability system built on Stacks using Clarity smart contracts. This system enables end-to-end tracking of agricultural products from farm to consumer, ensuring transparency, quality, and safety throughout the supply chain.

## Overview

The Tokenized Agriculture Food Traceability System consists of five interconnected smart contracts that work together to provide comprehensive food tracking and verification:

- **Producer Verification Contract**: Validates and manages food producers
- **Supply Chain Tracking Contract**: Tracks food products through the entire supply chain
- **Quality Certification Contract**: Manages quality certifications and standards
- **Safety Monitoring Contract**: Monitors and records food safety metrics
- **Consumer Information Contract**: Provides accessible food information to end consumers

## Features

- 🌾 **Producer Verification**: Authenticate and validate food producers
- 📦 **Supply Chain Tracking**: Real-time tracking of products through distribution
- ✅ **Quality Certification**: Digital certificates for quality standards
- 🛡️ **Safety Monitoring**: Continuous monitoring of food safety parameters
- 📱 **Consumer Access**: Easy access to product information for consumers
- 🔒 **Blockchain Security**: Immutable records on Stacks blockchain
- 🏷️ **Tokenization**: NFT-based product identification and ownership

## Project Structure

```
├── contracts/
│   ├── producer-verification.clar
│   ├── supply-chain-tracking.clar
│   ├── quality-certification.clar
│   ├── safety-monitoring.clar
│   └── consumer-information.clar
├── tests/
│   ├── producer-verification.test.js
│   ├── supply-chain-tracking.test.js
│   ├── quality-certification.test.js
│   ├── safety-monitoring.test.js
│   └── consumer-information.test.js
├── docs/
│   └── PR-details.md
└── README.md
```

## Smart Contracts

### Producer Verification Contract
Manages the registration and verification of food producers, ensuring only authorized entities can add products to the system.

### Supply Chain Tracking Contract
Tracks products through each stage of the supply chain, from production to retail, maintaining a complete audit trail.

### Quality Certification Contract
Handles quality certifications, standards compliance, and quality assurance processes.

### Safety Monitoring Contract
Monitors food safety parameters, temperature logs, contamination checks, and safety compliance.

### Consumer Information Contract
Provides consumers with easy access to product information, including origin, quality, and safety data.

## Getting Started

### Prerequisites

- Node.js (v16 or higher)
- Clarinet CLI
- Stacks Wallet

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd tokenized-agriculture-traceability
```

2. Install dependencies:
```bash
npm install
```

3. Initialize Clarinet project:
```bash
clarinet new .
```

### Testing

The project uses Vitest for testing. Tests are written in pure JavaScript without external Stacks dependencies.

Run all tests:
```bash
npm test
```

Run specific contract tests:
```bash
npm test producer-verification
npm test supply-chain-tracking
npm test quality-certification
npm test safety-monitoring
npm test consumer-information
```

### Deployment

1. Check contract syntax:
```bash
clarinet check
```

2. Deploy to testnet:
```bash
clarinet deploy --testnet
```

3. Deploy to mainnet:
```bash
clarinet deploy --mainnet
```

## Usage

### For Producers
1. Register as a verified producer
2. Add products to the system
3. Update product status throughout production

### For Supply Chain Partners
1. Receive products from previous stage
2. Update location and handling information
3. Transfer to next stage in chain

### For Quality Inspectors
1. Perform quality checks
2. Issue quality certificates
3. Update quality status

### For Safety Monitors
1. Record safety parameters
2. Monitor compliance
3. Issue safety alerts if needed

### For Consumers
1. Scan product QR code or enter product ID
2. View complete traceability information
3. Verify authenticity and quality

## API Reference

### Producer Verification
- `register-producer`: Register a new producer
- `verify-producer`: Verify producer credentials
- `get-producer-info`: Retrieve producer information

### Supply Chain Tracking
- `create-product`: Create new product entry
- `update-location`: Update product location
- `transfer-custody`: Transfer product custody
- `get-product-history`: Get complete product history

### Quality Certification
- `issue-certificate`: Issue quality certificate
- `verify-quality`: Verify product quality
- `get-certifications`: Get product certifications

### Safety Monitoring
- `record-safety-check`: Record safety inspection
- `update-safety-status`: Update safety status
- `get-safety-history`: Get safety monitoring history

### Consumer Information
- `get-product-info`: Get consumer-friendly product info
- `verify-authenticity`: Verify product authenticity
- `get-traceability-report`: Get complete traceability report

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## Security Considerations

- All contracts implement proper access controls
- Producer verification prevents unauthorized entries
- Immutable blockchain records ensure data integrity
- Multi-signature requirements for critical operations

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions, issues, or contributions, please:
- Open an issue on GitHub
- Contact the development team
- Check the documentation in the `docs/` folder

## Roadmap

- [ ] Mobile app integration
- [ ] IoT sensor integration
- [ ] Advanced analytics dashboard
- [ ] Multi-chain compatibility
- [ ] AI-powered quality prediction
- [ ] Consumer rewards program

---

Built with ❤️ for a more transparent and secure food supply chain.
```

