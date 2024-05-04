# Transitive Closures CLI

This CLI tool can compute the matrix representation of the transitive closure of a finite binary relation. This tool is written in Haskell.

## Libraries Used

- [matrix](https://hackage.haskell.org/package/matrix) (Relation representation)
- [vector](https://hackage.haskell.org/package/vector)
- [optparse-applicative](https://hackage.haskell.org/package/optparse-applicative) (CLI)

## Getting Started

First and foremost, clone the repository on your local machine:

```sh
$ git clone https://github.com/junkidesu/learning-junkie-api
```

### Prerequisites

To build the tool locally, ensure that the following are installed:

- [Stack](https://docs.haskellstack.org/en/stable/)
- [Cabal](https://cabal.readthedocs.io/en/stable/)

Stack and Cabal can be installed either independently or with the [GHCup](https://www.haskell.org/ghcup/) tool.

### Installation

At the root of the repository, run

```sh
$ stack install
```

To ensure that the tool is installed, run

```sh
$ transitive-closures-exe --help
```

## Usage

Finite binary relations can be represented with zero-one matrices. These matrices, in turn, can be represented programmatically as lists of lists. This CLI tool accepts such a representation as input. It can be supplied either directly to the executable, or with a text file.

### Matrix supplied directly

```
$ transitive-closures-exe -m "[[1, 0, 1], [0, 1, 0], [1, 1, 0]]"
```

### Matrix supplied through a text file

```
$ transitive-closures-exe -f matrix.txt
```

Contents of `matrix.txt`:

```
[
    [1, 0, 1],
    [0, 1, 0],
    [1, 1, 0]
]
```

### Algorithm

Naive algorithm is used by default. To use Warshall algorithm, provide the `--warshall` flag.
