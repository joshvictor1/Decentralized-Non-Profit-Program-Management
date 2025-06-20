# Decentralized Non-Profit Program Management

A comprehensive blockchain-based system for managing non-profit organizations, their programs, beneficiaries, impact tracking, and donor reporting using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a transparent, decentralized platform for non-profit organizations to:
- Register and get verified
- Create and manage programs
- Track beneficiaries and services provided
- Record and measure impact
- Generate reports for donors

## Smart Contracts

### 1. Non-Profit Verification Contract (\`nonprofit-verification.clar\`)
Manages the registration and verification of non-profit organizations.

**Key Features:**
- Register new non-profits with name, description, and wallet address
- Verify non-profits (only by contract owner)
- Query non-profit details and verification status

**Main Functions:**
- \`register-nonprofit\`: Register a new non-profit organization
- \`verify-nonprofit\`: Verify a registered non-profit (owner only)
- \`get-nonprofit\`: Get non-profit details by ID
- \`is-nonprofit-verified\`: Check verification status

### 2. Program Coordination Contract (\`program-coordination.clar\`)
Coordinates non-profit programs including creation, funding, and completion.

**Key Features:**
- Create programs with funding goals and target beneficiaries
- Accept funding from donors
- Track program status and completion
- Only verified non-profits can create programs

**Main Functions:**
- \`create-program\`: Create a new program
- \`fund-program\`: Fund an existing program
- \`complete-program\`: Mark a program as completed
- \`get-program\`: Get program details

### 3. Beneficiary Management Contract (\`beneficiary-management.clar\`)
Manages program beneficiaries and tracks services provided.

**Key Features:**
- Register beneficiaries for specific programs
- Update beneficiary status
- Track services provided to each beneficiary
- Link beneficiaries to programs

**Main Functions:**
- \`register-beneficiary\`: Register a new beneficiary
- \`update-beneficiary-status\`: Update beneficiary status
- \`record-service\`: Record a service provided to a beneficiary
- \`get-beneficiary\`: Get beneficiary details

### 4. Impact Tracking Contract (\`impact-tracking.clar\`)
Tracks and records program impact metrics and outcomes.

**Key Features:**
- Record various impact metrics (meals served, people helped, etc.)
- Maintain program impact summaries
- Track beneficiaries served and services provided
- Generate impact data for reporting

**Main Functions:**
- \`record-impact\`: Record an impact metric
- \`update-beneficiaries-served\`: Update beneficiaries count
- \`update-services-provided\`: Update services count
- \`get-program-impact-summary\`: Get impact summary for a program

### 5. Donor Reporting Contract (\`donor-reporting.clar\`)
Generates and manages reports for program donors.

**Key Features:**
- Generate custom reports for donors
- Grant access to donors based on funding
- Provide program summaries to authorized donors
- Track donor engagement with programs

**Main Functions:**
- \`generate-donor-report\`: Generate a report for a specific donor
- \`grant-donor-access\`: Grant access to a donor
- \`get-program-summary-for-donor\`: Get program summary for authorized donors
- \`has-donor-access\`: Check if donor has access to program data

## Contract Interactions

The contracts are designed to work together:

1. **Non-profits** must be registered and verified before they can create programs
2. **Programs** can only be created by verified non-profits
3. **Beneficiaries** are registered for specific programs
4. **Impact metrics** are recorded against programs
5. **Donor reports** are generated based on program data and impact metrics

## Error Codes

Each contract uses specific error codes:
- **100-199**: Non-profit verification errors
- **200-299**: Program coordination errors
- **300-399**: Beneficiary management errors
- **400-499**: Impact tracking errors
- **500-599**: Donor reporting errors

## Getting Started

### Prerequisites
- Stacks blockchain node or access to testnet/mainnet
- Clarity CLI for contract deployment
- Node.js for running tests

### Deployment

1. Deploy contracts in the following order:
   \`\`\`bash
   clarinet deploy nonprofit-verification
   clarinet deploy program-coordination
   clarinet deploy beneficiary-management
   clarinet deploy impact-tracking
   clarinet deploy donor-reporting
   \`\`\`

2. Verify the contract owner has the correct permissions

### Testing

Run the test suite:
\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract deployment and initialization
- Function calls with valid and invalid parameters
- Access control and authorization
- Data integrity and consistency
- Error handling

## Usage Examples

### Registering a Non-Profit
\`\`\`clarity
(contract-call? .nonprofit-verification register-nonprofit
"Food Bank Network"
"Providing food assistance to families in need")
\`\`\`

### Creating a Program
\`\`\`clarity
(contract-call? .program-coordination create-program
"Emergency Food Distribution"
"Distributing food packages to 100 families"
u1  ;; nonprofit-id
u100  ;; target-beneficiaries
u50000  ;; funding-goal in micro-STX
u1000)  ;; start-date (block height)
\`\`\`

### Recording Impact
\`\`\`clarity
(contract-call? .impact-tracking record-impact
u1  ;; program-id
"meals-served"
u500  ;; metric-value
"Served 500 meals to families this week")
\`\`\`

## Security Considerations

- Only verified non-profits can create programs and manage beneficiaries
- Contract owner controls non-profit verification
- Donors can only access reports for programs they've funded
- All transactions are recorded on-chain for transparency
- Access controls prevent unauthorized modifications

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the repository or contact the development team.
\`\`\`

Finally, let's create the PR details file:
