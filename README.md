# Building Pulp Containers for Katello - PulpCon 2025

Presentation about Pulp container builds using Konflux for the Katello project.

## Running the Presentation

### Local Development

```bash
npx slidev slides.md
```

The presentation will be available at `http://localhost:3030`

### Using Podman

```bash
podman build -t pulpcon-2025 .
podman run -it --rm -p 3030:3030 pulpcon-2025
```

## Presentation Overview

This presentation covers:

- Pulpcore 3.73 and 3.85 releases in 2025
- Container strategy using RPMs
- pulp-oci-images repository structure
- Konflux integration for secure builds
- Quay registry setup (stage and production)
- Security benefits (SBOM & SLSA 3)
- Branching strategy for multiple versions
- Roadmap for Pulp containers

## Key Resources

- **pulp-oci-images**: https://github.com/theforeman/pulp-oci-images
- **pulpcore-packaging**: https://github.com/theforeman/pulpcore-packaging
- **Stage Registry**: https://quay.io/repository/foreman/pulp-stage
- **Production Registry**: https://quay.io/repository/foreman/pulp
- **Konflux Documentation**: https://konflux-ci.dev/docs/

## Controls

- Press `Space` or `→` to advance slides
- Press `←` to go back
- Press `o` for slide overview
- Press `f` for fullscreen
- Press `d` to toggle dark mode

