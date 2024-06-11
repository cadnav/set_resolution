# Set Resolution (xrandr cli wrapper)

## Overview

This repository contains a bash script `set_resolution.sh` that allows users to quickly set their screen resolution using `xrandr`. The script includes command-line options for easy selection of resolutions.

## Features

- Set screen resolution using command-line arguments
- Supports multiple resolutions:
  - 3440x1440
  - 3840x2160
  - 1920x1200
  - 2560x2880
  - 1920x1080
- Includes logging with different verbosity levels

## Usage

### Command-line Arguments

You can set the resolution directly using command-line arguments:

```bash
./set_resolution.sh [option]
```

#### Options

- `-w` or `--3440x1440`: Set resolution to 3440x1440
- `-k` or `--3840x2160`: Set resolution to 3840x2160
- `-m` or `--1920x1200`: Set resolution to 1920x1200
- `-d` or `--2560x2880`: Set resolution to 2560x2880
- `-b` or `--1920x1080`: Set resolution to 1920x1080
- `-h` or `--help`: Show the help screen
- `-v` or `--version`: Show the script version

### Examples

Set the resolution to 3440x1440:

```bash
./set_resolution.sh -w
```

Show the help screen:

```bash
./set_resolution.sh -h
```

## Logging

The script includes a logging function with different verbosity levels:

- `0`: Success
- `1`: Error
- `2`: Warning
- `3`: Info (default)
- `4`: Debug

You can adjust the verbosity level by modifying the script.

## Customization

The script serves as a template and can be customized to suit your needs. You can add more functionality or modify the existing ones.

## Contributing

Feel free to contribute to this project by submitting issues or pull requests. Your contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

