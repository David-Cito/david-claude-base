#!/bin/bash
# Safety hook to block dangerous bash commands
# This hook is called before any Bash tool execution

# Read the command from stdin (passed by Claude Code)
read -r COMMAND

# List of dangerous patterns to block
DANGEROUS_PATTERNS=(
    "rm -rf /"
    "rm -rf ~"
    "rm -rf ."
    "rm -rf *"
    "sudo rm"
    ":(){:|:&};:"
    "mkfs"
    "dd if="
    "> /dev/sda"
    "chmod -R 777 /"
    "curl.*| bash"
    "wget.*| bash"
    "curl.*| sh"
    "wget.*| sh"
)

# Check each pattern
for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if [[ "$COMMAND" == *"$pattern"* ]]; then
        echo "BLOCKED: Dangerous command pattern detected: $pattern" >&2
        exit 1
    fi
done

# Command is safe, allow execution
exit 0
