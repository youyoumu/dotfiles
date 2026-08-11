# Runner: execute a per-directory run.fish script.
#
# The `run` command looks for a run.fish in the current working directory and
# executes it, defaulting to the `default` target when no arguments are given.
# It is a lightweight project-local task runner: any directory can define its
# own run.fish with a set of function targets.

# Run the local run.fish with the given arguments (or the `default` target).
function run --description "Run local run.fish file"
    if test -f ./run.fish
        if test (count $argv) -eq 0
            ./run.fish default
        else
            ./run.fish $argv
        end
    else
        echo "Error: No ./run.fish found in $(pwd)" >&2
        return 1
    end
end

# List the function names defined in the local run.fish, used to complete the
# available targets for the `run` command. Underscore-prefixed functions are
# treated as private helpers and excluded from the suggestions.
function __fish_run_get_functions
    set -l script_path "./run.fish"
    if test -f $script_path
        # Capture each "function <name>" definition, matching any indentation,
        # then drop names that start with an underscore.
        string match -rg '^\s*function\s+([^\s]+)' <$script_path \
            | string match -rv '^_'
    end
end

# Suggest the run.fish targets when completing `run` in a directory.
complete -c run -f -a "(__fish_run_get_functions)"
