# Deduplication Tool

A Business Central extension for identifying and managing duplicate data records.

## Overview

This extension provides comprehensive tools to detect duplicate records in your Microsoft Dynamics 365 Business Central database. It includes visual diff capabilities to help users compare and merge similar entries, making data cleanup more efficient and user-friendly.

## Features

- **Source Data Management**: Tables and pages for managing source data records
- **Deduplication Engines**: Configurable engines for different deduplication strategies (combined fields, etc.)
- **Visual Diff Control**: Control add-in with LCS algorithm for highlighting differences between records
- **Setup and Configuration**: Dedicated setup page for configuring deduplication parameters
- **Permission Management**: Granular permission sets for read, edit, and object access
- **Utility Functions**: Text processing and data manipulation utilities

## Requirements

- Microsoft Dynamics 365 Business Central 2025 Wave 1 (version 27.0.0.0 or later)
- AL Language extension for Visual Studio Code
- Business Central development environment

## Installation

1. Clone this repository to your local machine
2. Open the `app` folder in Visual Studio Code with the AL Language extension installed
3. Configure your launch.json for your BC environment
4. Publish the app to your Business Central sandbox or production environment
5. For testing: Open the `test` folder and publish the test app

## Usage

### Setup

1. Navigate to the **Deduplication Setup** page in Business Central
2. Configure your deduplication rules and parameters
3. Set up engine entries and field mappings

### Data Management

1. Use the **Source Data** pages to import and manage your data records
2. Access the **Source Data Matches** to view potential duplicates
3. Utilize the **Diff Control** page to visually compare records with highlighted differences

### Permissions

Assign appropriate permission sets:

- **DedupeRead**: Read-only access
- **DedupeEdit**: Edit access for data management
- **DedupeObj**: Full object access for administrators

## Testing

The `test` folder contains comprehensive unit tests for the extension functionality. To run tests:

1. Publish the test app to your BC environment
2. Use the Test Runner to execute the test suite
3. Tests cover text utilities, deduplication logic, and control add-in functionality

## Architecture

### Key Components

- **Data Layer**: Tables for source data, matches, and setup
- **Engine Layer**: Codeunits implementing different deduplication algorithms
- **UI Layer**: Pages and control add-ins for user interaction
- **Utility Layer**: Helper codeunits for text processing and data manipulation

### Control Add-in

The HighlightDifferences control add-in provides visual diff functionality using:

- JavaScript implementation of Longest Common Subsequence (LCS) algorithm
- CSS styling compliant with Business Central design guidelines
- JSON data exchange between AL and JavaScript

## Contributing

1. Follow AL development best practices and Microsoft guidelines
2. Include XML documentation for all public functions
3. Add unit tests for new features
4. Ensure code follows the established naming conventions and patterns
5. Test in both sandbox and production-like environments

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or contributions, please create an issue in this repository or contact the maintainers.
