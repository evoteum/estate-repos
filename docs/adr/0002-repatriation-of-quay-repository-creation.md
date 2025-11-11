# 2. Repatriation of Quay Repository Creation

Date: 2025-11-11

## Status

Accepted

## Context

Creation of quay.io repositories was moved to the ECS deployment platform module. This turned out to be the wrong layer,
as it prevented other git repositories that need to output containers, but not necessarily to also throw them at ECS,
from being able to create a Quay.io repository.

## Decision

We will create Quay.io repositories as part of the estate-repos git repository provisioning process.

## Consequences

Ensures that all who want a Quay.io repository, are provided with a Quay.io repository.
