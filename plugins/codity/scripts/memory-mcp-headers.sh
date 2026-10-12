#!/bin/sh
# headersHelper for the Codity team-memory MCP server.
# Prints {"Authorization": "Bearer <token>"} on stdout; Claude Code runs it on
# connect, on reconnect, and again after a 401/403 (so an expired token renews).
#
# Token source, in order:
#   1. $CODITY_MEMORY_TOKEN (e.g. export CODITY_MEMORY_TOKEN=$(codity memory mcp-token))
#   2. `codity memory mcp-token`, using the login from `codity login`
#
# Set CODITY_MEMORY_READONLY=1 for a token without memory_propose.
# CODITY_MEMORY_TOKEN_TTL overrides the lifetime (default 8h).
set -eu

token="${CODITY_MEMORY_TOKEN:-}"
if [ -z "$token" ]; then
  if ! command -v codity >/dev/null 2>&1; then
    echo "codity CLI not found on PATH; install it from https://codity.ai or set CODITY_MEMORY_TOKEN" >&2
    exit 1
  fi
  write="--write"
  if [ "${CODITY_MEMORY_READONLY:-0}" = "1" ]; then
    write=""
  fi
  # shellcheck disable=SC2086
  if ! token=$(codity memory mcp-token $write --ttl "${CODITY_MEMORY_TOKEN_TTL:-8h}" </dev/null 2>/dev/null); then
    echo "could not mint a Codity memory token; run 'codity login' (or 'codity memory mcp-token' to see the error)" >&2
    exit 1
  fi
fi

token=$(printf '%s' "$token" | tr -d ' \r\n')
if [ -z "$token" ]; then
  echo "empty Codity memory token" >&2
  exit 1
fi
printf '{"Authorization": "Bearer %s"}\n' "$token"
