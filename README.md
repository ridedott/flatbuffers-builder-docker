# flatbuffers-builder-docker

[![license: MIT](https://img.shields.io/github/license/ridedott/flatbuffers-builder-docker)](https://github.com/ridedott/flatbuffers-builder-docker/blob/master/LICENSE)
[![GitHub Actions Status](https://github.com/ridedott/flatbuffers-builder-docker/workflows/Continuous%20Integration/badge.svg?branch=master)](https://github.com/ridedott/dependabot-auto-merge-action/actions)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)

A Docker image running with FlatBuffers compilers.

## Usage

```bash
docker pull docker.pkg.github.com/ridedott/flatbuffers-builder-docker/flatbuffers-builder:latest
docker run ridedott/flatbuffers-builder:latest
```

## Getting Started

These instructions will get you an instance of the flatbuffers-builder running
on your local machine for testing purposes.

### Prerequisites

Minimal requirements to set up the project:

- [Docker](https://docs.docker.com/install/)
  - Make sure to
    [authenticate to Github Package registry](https://help.github.com/en/articles/configuring-docker-for-use-with-github-package-registry#authenticating-to-github-package-registry).

### Building

```bash
docker build -t ridedott/flatbuffers-builder:latest .
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Built with

### Automation

- [GitHub Actions](https://github.com/features/actions)

## Versioning

This project adheres to [Semantic Versioning](http://semver.org) v2.
