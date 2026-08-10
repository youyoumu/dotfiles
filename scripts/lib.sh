#!/usr/bin/env bash

pass=0
fail=0

assert_eq() {
    local label="$1" expected="$2" actual="$3"
    if [ "$expected" = "$actual" ]; then
        echo "  ✓ $label"
        ((pass++))
    else
        echo "  ✗ $label (expected='$expected', got='$actual')"
        ((fail++))
    fi
}

assert_contains() {
    local label="$1" needle="$2" haystack="$3"
    if [[ "$haystack" == *"$needle"* ]]; then
        echo "  ✓ $label"
        ((pass++))
    else
        echo "  ✗ $label (expected to contain '$needle')"
        ((fail++))
    fi
}

print_results() {
    echo ""
    echo "Results: $pass passed, $fail failed"
    [ "$fail" -eq 0 ] && exit 0 || exit 1
}
