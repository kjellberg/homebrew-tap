# Homebrew Formula for `mrsk`

This repository contains a Homebrew formula for [mrsk](https://github.com/mrsked/mrsk).

The formula will pull the latest `mrsk` docker image and create a 'mrsk' binary that can be run from the command line.

## Installation

To install `mrsk` using Homebrew, run the following command:

```console
brew tap mrsked/tap
brew install mrsk
```

This will install the latest version of [MRSK](https://github.com/mrsked/mrsk). 

you can verify that `mrsk` is working properly by running the following command:

```console
mrsk version
```

This should output the version number of the installed `mrsk`.


### Upgrade

```console
brew update && brew upgrade mrsk
```

## Usage

To deploy your web app using `mrsk`, first create a configuration file using the `mrsk init` command:

```console
mrsk init
```

This will create a new configuration file at the specified path with some default settings.

Read more at [https://github.com/mrsked/mrsk](https://github.com/mrsked/mrsk)

## Contributing

If you encounter any issues with the formula, or if you would like to contribute to its development, please feel free to open an issue or pull request on this repository.

## License

This formula is released under the MIT License. See [LICENSE](LICENSE) for details.
