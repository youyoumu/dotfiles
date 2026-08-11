set -l __test_dir (dirname (status --current-filename))
source $__test_dir/test.fish
source $__test_dir/runner.fish

function __test_no_run_file
    set -l dir (__test_mkdtemp)
    set -l old (pwd)
    cd $dir
    set -l out (__fish_run_get_functions)
    cd $old
    assert_empty "$out"
end

function __test_simple_functions
    set -l dir (__test_mkdtemp)
    printf 'function foo\nfunction bar\n' >$dir/run.fish
    set -l old (pwd)
    cd $dir
    set -l out (__fish_run_get_functions | string join ' ')
    cd $old
    assert_eq "$out" "foo bar"
end

function __test_names_with_flags
    set -l dir (__test_mkdtemp)
    printf 'function foo -d "does things"\nfunction bar --wraps=ls\n' >$dir/run.fish
    set -l old (pwd)
    cd $dir
    set -l out (__fish_run_get_functions | string join ' ')
    cd $old
    assert_eq "$out" "foo bar"
end

function __test_indented_functions
    set -l dir (__test_mkdtemp)
    printf 'function foo\n    function bar\n\tfunction baz\n' >$dir/run.fish
    set -l old (pwd)
    cd $dir
    set -l out (__fish_run_get_functions | string join ' ')
    cd $old
    assert_eq "$out" "foo bar baz"
end

function __test_ignores_non_definitions
    set -l dir (__test_mkdtemp)
    printf 'function foo\n# function notthis\nfunctionality\nfunction bar\n' >$dir/run.fish
    set -l old (pwd)
    cd $dir
    set -l out (__fish_run_get_functions | string join ' ')
    cd $old
    assert_eq "$out" "foo bar"
end

function __test_excludes_underscore_functions
    set -l dir (__test_mkdtemp)
    printf 'function _hidden\nfunction bar\nfunction _helper -d "desc"\nfunction baz\n' >$dir/run.fish
    set -l old (pwd)
    cd $dir
    set -l out (__fish_run_get_functions | string join ' ')
    cd $old
    assert_eq "$out" "bar baz"
end

function __make_run_fixture
    set -l dir (__test_mkdtemp)
    printf '#!/usr/bin/env fish\necho $argv\n' >$dir/run.fish
    chmod +x $dir/run.fish
    echo $dir
end

function __test_run_default_arg
    set -l dir (__make_run_fixture)
    set -l old (pwd)
    cd $dir
    set -l out (run)
    cd $old
    assert_eq "$out" default
end

function __test_run_passes_args
    set -l dir (__make_run_fixture)
    set -l old (pwd)
    cd $dir
    set -l out (run foo bar)
    cd $old
    assert_eq "$out" "foo bar"
end

function __test_run_error_without_file
    set -l dir (__test_mkdtemp)
    set -l old (pwd)
    cd $dir
    set -l out (run 2>&1)
    set -l run_status $status
    cd $old
    assert_neq "$run_status" 0
    assert_neq "$out" ""
end

__test_case "no run.fish yields nothing" __test_no_run_file
__test_case "extracts simple function names" __test_simple_functions
__test_case "extracts names with trailing flags" __test_names_with_flags
__test_case "extracts indented definitions" __test_indented_functions
__test_case "ignores non-definition lines" __test_ignores_non_definitions
__test_case "excludes underscore-prefixed functions" __test_excludes_underscore_functions
__test_case "run executes default target" __test_run_default_arg
__test_case "run passes through arguments" __test_run_passes_args
__test_case "run errors without run.fish" __test_run_error_without_file

__test_run
