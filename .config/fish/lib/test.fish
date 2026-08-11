set -g __test_names
set -g __test_fns
set -g __test_passed 0
set -g __test_failed 0
set -g __test_tmpdirs

function __test_mkdtemp
    set -l dir (mktemp -d)
    set -a __test_tmpdirs $dir
    echo $dir
end

function __test_cleanup
    for dir in $__test_tmpdirs
        if string match -q 'tmp.*' -- (basename $dir); and string match -q '/*' -- $dir
            rm -rf -- $dir
        end
    end
    set -e __test_tmpdirs
end

function __test_cleanup_on_exit --on-event fish_exit
    __test_cleanup
end

function __test_case --argument-names name fn
    set -a __test_names $name
    set -a __test_fns $fn
end

function assert_eq --argument-names actual expected
    test "$actual" = "$expected"
    and return 0
    echo "expected '$expected', got '$actual'" >&2
    return 1
end

function assert_neq --argument-names actual expected
    test "$actual" != "$expected"
    and return 0
    echo "expected not '$expected', got '$actual'" >&2
    return 1
end

function assert_empty --argument-names val
    test -z "$val"
    and return 0
    echo "expected empty, got '$val'" >&2
    return 1
end

function __test_run
    for i in (seq (count $__test_names))
        set -l name $__test_names[$i]
        set -l fn $__test_fns[$i]
        $fn
        if test $status -eq 0
            set -g __test_passed (math $__test_passed + 1)
            echo "  PASS  $name"
        else
            set -g __test_failed (math $__test_failed + 1)
            echo "  FAIL  $name"
        end
    end
    echo
    echo "$__test_passed passed, $__test_failed failed"
    if test $__test_failed -gt 0
        exit 1
    end
end
