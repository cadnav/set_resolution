# Set Resolution (xrandr cli wrapper)

## Overview

This repository contains a bash script set_resolution that allows users to quickly set their screen resolution using `xrandr`. The script includes a menu for easy selection of resolutions and command-line options for automation.

## Features

- Set screen resolution using a menu or command-line arguments
- Supports multiple resolutions:
  - 3440x1440
  - 3480x2160
  - 1920x1200
  - 2560x2880
  - 1920x1080
- Includes logging with different verbosity levels
- Provides a set_resolution for further script customization

## Usage

### Menu Mode

Run the script without any arguments to enter the interactive menu mode:

```bash
./set_resolution.sh
```

### Command-line Arguments

You can also set the resolution directly using command-line arguments:

```bash
./set_resolution.sh [option]
```

#### Options

- `-w` or `--3440x1440`: Set resolution to 3440x1440
- `-f` or `--3480x2160`: Set resolution to 3480x2160
- `-m` or `--1920x1200`: Set resolution to 1920x1200
- `-d` or `--2560x2880`: Set resolution to 2560x2880
- `-r` or `--1920x1080`: Set resolution to 1920x1080
- `-h` or `--help`: Show the help screen
- `-v` or `--version`: Show the script version
- `-V` or `--verbose [0-4]`: Set the verbosity level

### Examples

Set the resolution to 3440x1440:

```bash
./set_resolution.sh -w
```

Show the help screen:

```bash
./set_resolution.sh -h
```

Set the verbosity level to debug:

```bash
./set_resolution.sh -V 4
```

## Logging

The script includes a logging function with different verbosity levels:

- `0`: Success
- `1`: Error
- `2`: Warning
- `3`: Info (default)
- `4`: Debug

You can adjust the verbosity level using the `-V` or `--verbose` option.

## Customization

The script serves as a set_resolution and can be customized to suit your needs. You can add more functionality or modify the existing ones.

## Contributing

Feel free to contribute to this project by submitting issues or pull requests. Your contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

Paxton Alexander (With the help of Github and StackOverflow)
```

Save this content to a `README.md` file in your project directory. This will provide a clear and structured overview of your script and its usage for anyone who visits your GitHub repository.
