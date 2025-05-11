---
title: "Blueprints"
draft: false
featured: true
weight: 2
---

A curated collection of Terraform modules that implement security and compliance best practices by default, with embedded metadata, audit-ready documentation, and cloud-agnostic design patterns.
<!--more-->

# Ataides Blueprints

Infrastructure as Code should build more than resources, it should build trust. **Ataides Blueprints** is a curated collection of Terraform modules that implement security and compliance best practices by default, with embedded metadata for audit mapping.

## Why It Exists

Cloud teams often reimplement the same patterns, but without clear alignment to regulatory expectations. Ataides Blueprint gives your teams a composable, auditable starting point for secure-by-design infrastructure.

## Core Principles

- ✅ Compliance by design, not afterthought
- 📎 Embedded control metadata (e.g., `compliance: ["iso-27001:A.9.2.3", "nist:AC-6"]`)
- 🧱 Modular, versioned, and cloud-agnostic
- 🧰 Minimal external dependencies
- 📖 Automatic documentation generation for auditors

## Modules (Work in Progress)

- IAM architecture (least privilege baseline)
- Centralized logging pipelines
- Encryption enforcement (S3, KMS, DBs)
- Backup lifecycle + validation hooks
- VPC and subnet baseline with flow logs

## Use Cases

- Start new environments with guardrails built-in
- Accelerate compliance efforts for SOC 2, ISO 27001, NIST CSF
- Prove alignment between infrastructure and policy
- Reduce overhead in control documentation

## How It Works

Each module includes:

- Terraform source code
- Metadata in JSON/YAML describing mapped controls
- Output documentation artifacts
- Optional integration with Vaultum for evidence collection

## Get Involved

Ataides Blueprints is open-source and licensed under Apache 2.0.

[→ View Repository](https://github.com/ataides-cti/blueprint)
