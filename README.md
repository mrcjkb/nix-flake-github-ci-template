# Nix flake GitHub Actions CI template

A template for setting up GitHub Actions with [Nix flakes](https://nixos.wiki/wiki/Flakes).

![Nix](https://img.shields.io/badge/nix-0175C2?style=for-the-badge&logo=NixOS&logoColor=white)

## Setup

1. Click on [Use this template](https://github.com/MrcJkb/nix-flake-github-ci-template/generate)
to start a repo based on this template. **Do _not_ fork it.**
2. Set up a [Cachix binary cache](https://app.cachix.org/cache) and add the
`CACHIX_AUTH_TOKEN` variable to the repository.
3. Change the `name` fields in [`nix-build.yaml`](./.github/workflows/nix-build.yml).
4. Add your tests to [`mkTest` in the `ci-overlay.nix`](./nix/ci-overlay.nix).

## Contributing

All contributions are welcome!
See [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

This template is [licensed according to GPL version 2](./LICENSE),
with the following exception:

The license applies only to the Nix CI infrastructure provided by this template
repository, including any modifications made to the infrastructure.
Any software that uses or is derived from this template may be licensed under any
[OSI approved open source license](https://opensource.org/licenses/),
without being subject to the GPL version 2 license of this template.
