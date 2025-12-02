---
download: true
title: 'Building Pulp Containers for Katello'
theme: seriph
themeConfig:
  primary: '#5d8392'
class: 'text-center'
highlighter: shiki
author: Odilon Sousa
selectable: true
colorSchema: 'dark'
favicon: 'https://pulpproject.org/pulpcore/docs/assets/pulp_logo_big.png'
---

# Building Pulp Containers for Katello

PulpCon 2025

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next page <carbon:arrow-right class="inline"/>
  </span>
</div>

---
layout: default
---

# Recent Pulpcore Releases

Major releases for Katello

<v-clicks>

## Pulpcore 3.73 - First Rebuild of 2025

- **Python 3.12 Migration** - Same version as EL10
- Released early 2025
- Repository: [theforeman/pulpcore-packaging/tree/rpm/3.73](https://github.com/theforeman/pulpcore-packaging/tree/rpm/3.73)
- All plugins rebuilt and tested
- **Built with GitHub Actions** - Traditional CI approach

## Pulpcore 3.85 - Next Generation

- Repository: [theforeman/pulpcore-packaging/tree/rpm/3.85](https://github.com/theforeman/pulpcore-packaging/tree/rpm/3.85)
- Continuous improvement of our tooling and packages used by Pulp
- **Built with Konflux** - Secure supply chain approach
- Stable foundation for container builds

</v-clicks>

<div v-click class="mt-6 p-4 bg-blue-500 bg-opacity-10 rounded text-sm">

**The Transition**: Moving from GitHub Actions (3.73) → Konflux (3.85+) for enhanced security and compliance 🔒

</div>

---
layout: default
---

# The Container Strategy

RPMs → Container Images with Konflux

<v-clicks>

## The Workflow

1. **Build RPMs** - Using our proven pulpcore-packaging automation
2. **Consume RPMs** - Container images built from stable RPM packages
3. **Konflux CI/CD** - Secure, auditable container builds
4. **Deploy to Quay** - Stage and production registries

## Why RPMs First?

- **Proven stability** - RPMs are battle-tested in production
- **Dependency management** - RPM handles complex dependencies
- **Flexibility** - RPMs can be consumed in containers or directly
- **Katello integration** - Seamless integration with existing workflows

</v-clicks>

---
layout: default
---

# pulp-oci-images Repository

Our container build infrastructure

<v-clicks>

## Repository Structure

**Location**: [github.com/theforeman/pulp-oci-images](https://github.com/theforeman/pulp-oci-images)

- Containerfiles for Pulp services
- Consumes RPMs from pulpcore-packaging
- Managed through Konflux
- Automated builds on changes

## Key Features

- **Multi-stage builds** - Optimized image sizes
- **Security scanning** - Automated vulnerability detection
- **SBOM generation** - Complete bill of materials
- **Provenance attestation** - SLSA Level 3 compliance

</v-clicks>

---
layout: default
---

# Konflux for Pulp

Secure supply chain for container images

<v-clicks>

## What Konflux Provides

- **Automated Builds** - Triggered on git commits
- **Enterprise Contract** - Policy enforcement before release
- **Hermetic Builds** - Reproducible, isolated build environment
- **Signed Attestations** - Cryptographic proof of build process
- **SBOM & SLSA 3** - Complete transparency and security

## Component → Application Model

- **Component**: pulp-oci-images (the repository)
- **Applications**: pulp-nightly, pulp-3.85 (version streams)
- **Releases**: Specific versions promoted to production

</v-clicks>

---
layout: default
---

# Quay Repositories

Where our Pulp images live

<div class="grid grid-cols-2 gap-6 mt-8">

<div v-click>

### Stage Registry

**URL**: [quay.io/foreman/pulp-stage](https://quay.io/repository/foreman/pulp-stage)

- **Purpose**: Testing and validation
- **Updates**: Automatic on merge to main
- **Access**: Developers and CI systems
- **Tags**: Includes SHA-based tags

</div>

<div v-click>

### Production Registry

**URL**: [quay.io/foreman/pulp](https://quay.io/repository/foreman/pulp)

- **Purpose**: Production deployments
- **Updates**: Manual release process
- **Access**: Public or controlled access
- **Tags**: Semantic versions (e.g., 3.73, 3.85)

</div>

</div>

<div v-click class="mt-8 p-4 bg-purple-500 bg-opacity-10 rounded">

### The Flow

RPM Release → Container Build → Stage Registry → Enterprise Contract Validation → Production Registry

</div>

---
layout: default
---

# Build Process Deep Dive

From RPM to running container

<div class="grid grid-cols-2 gap-6 mt-6">

<div v-click>

### Step 1: RPM Release

- RPMs built via pulpcore-packaging
- Published to [yum.theforeman.org/pulpcore/](https://yum.theforeman.org/pulpcore/)
- Versioned repositories (3.85, etc.)

</div>

<div v-click>

### Step 2: Container Build

- Konflux detects changes in pulp-oci-images
- Containerfile pulls RPMs from yum repos
- Tekton pipeline executes build
- Tests run automatically

</div>

</div>

<div v-click class="mt-8 p-6 bg-gradient-to-r from-blue-500 to-purple-500 bg-opacity-20 rounded-lg border-2 border-blue-400">

### Step 3: Promotion 🚀

<div class="grid grid-cols-3 gap-4 mt-4 text-center">

<div class="p-3 bg-green-500 bg-opacity-20 rounded">

**Stage Registry**

Successful builds →  
Auto-pushed

</div>

<div class="p-3 bg-yellow-500 bg-opacity-20 rounded">

**Validation**

Manual Release →  
Enterprise Contract

</div>

<div class="p-3 bg-blue-500 bg-opacity-20 rounded">

**Production**

Approved releases →  
Public registry

</div>

</div>

</div>

---
layout: default
---

# Branching Strategy

Managing multiple Pulp versions

<div class="grid grid-cols-2 gap-6 mt-6">

<div v-click>

### Nightly Builds

**Branch**: `main`/`develop`  
**Application**: `pulp-nightly`  
**Strategy**: Auto-release

- Every merge → automatic build
- Latest RPMs consumed
- Continuous testing
- Stage registry only

</div>

<div v-click>

### Release Versions

**Branch**: `3.85`  
**Application**: `pulp-3.85`  
**Strategy**: Manual releases

- Controlled updates
- Point-in-time snapshots
- Enterprise Contract validation
- Production releases (3.85.0, 3.85.1, etc.)

</div>

</div>

<div v-click class="mt-6 p-4 bg-yellow-500 bg-opacity-10 rounded text-sm">

Same branching pattern as pulpcore-packaging - consistency across the stack!

</div>

---
layout: default
---

# Security & Compliance

SBOM and SLSA 3 benefits

<div class="grid grid-cols-3 gap-6 mt-8">

<div v-click>

### Software Bill of Materials

- Complete dependency tree
- Track vulnerabilities
- Rapid response to CVEs
- Audit trail for compliance

</div>

<div v-click>

### SLSA Level 3

- Hermetic builds
- Build provenance signed
- Non-falsifiable attestations
- Supply chain integrity

</div>

<div v-click>

### Enterprise Contract

- Policy enforcement
- Validates before release
- Blocks failing builds
- Ensures compliance

</div>

</div>

<div v-click class="mt-8 p-4 bg-blue-500 bg-opacity-10 rounded text-center">

**Complete security and transparency for all Pulp container images**

</div>

---
layout: default
---

# What's Next?

Roadmap for Pulp containers

<div class="grid grid-cols-2 gap-8 mt-8">

<div v-click>

## Current Focus

**Pulpcore versions**: Nightly/Develop and 3.85 only

- These two streams cover our immediate needs
- Nightly for continuous testing and development
- 3.85 for production Katello deployments

</div>

<div v-click>

## Short Term (2025 Q1-Q2)

1. Complete Konflux setup for Nightly and 3.85
2. Automate nightly builds with auto-release
3. Establish release processes for 3.85 branch
4. Document workflows for contributors

</div>

</div>

---
layout: center
class: text-center
---

# Questions?

<div class="mt-8">

**Resources**

[pulp-oci-images](https://github.com/theforeman/pulp-oci-images) | [pulpcore-packaging](https://github.com/theforeman/pulpcore-packaging) | [Konflux Docs](https://konflux-ci.dev/docs/)

</div>

<div class="mt-8">

**Quay Repositories**

[Stage](https://quay.io/repository/foreman/pulp-stage) | [Production](https://quay.io/repository/foreman/pulp)

</div>

