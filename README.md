# Sudoku Solver & Visualizer

A professional-grade Sudoku solver application built with Flutter that visualizes the solving process step by step. This desktop application allows users to input puzzles, view the solving logic in real-time, and interact with the solving process.

## Features

- Interactive Sudoku board for puzzle input
- Step-by-step visualization of solving logic
- Manual number input and pencil marks
- Clean, modern UI designed for desktop
- Comprehensive test coverage
- Detailed solving strategy explanations

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- macOS for development and testing

### Installation

1. Clone the repository:

```bash
git clone https://github.com/jtknox91/sudoku.git
```
2. Navigate to the project directory:

```bash
cd sudoku
```

3. Install dependencies:

```bash
flutter run -d macos
```

4. Run the application:

## Project Structure
lib/
├── core/ # Core functionality and utilities
├── models/ # Data models (eg. board, group, cell)
├── solvers/ # Solving algorithms
├── ui/ # UI components
└── main.dart # Application entry point
test/
├── unit/ # Unit tests
├── widget/ # Widget tests
└── integration/ # Integration tests

## Development

### Code Style

This project follows the official Dart style guide and enforces consistent coding standards using `dart analyze` and `flutter_lints`.

### Testing

Run tests using:

```bash
flutter test
```
### Building

To build the macOS application:

```bash
flutter build macos
```
## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add some new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
