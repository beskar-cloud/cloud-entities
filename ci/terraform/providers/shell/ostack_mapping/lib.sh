
# constants
SCHEMA_JSON='{"name": "%s", "local-mapping-rules-sha256sum": "%s", "ostack-mapping-rules-sha256sum": "%s"}'

# functions

# at_exit()
#   at exit callback function handling stderr state logging
function at_exit() {
    local step_name="${STEP_NAME:-"unknown"}"

    if [ "${step_name}" != "Succeeded" ]; then
        echo "Step \"${step_name}\" failed!" >&2
        set | grep -E '^(IN|ID|STEP_NAME|mapping_).*=' >&2
        exit "${STEP_FAIL_EXIT_CODE:-10}"
    fi
}

# get_checksum <file>
# stream | get_checksum
#   compute checksum from file or pipe
function get_checksum() {
    if [ "$#" == "0" ]; then
        cat | sha256sum | awk '{printf $1}'
    else
        cat "$1" | sha256sum | awk '{printf $1}'
    fi
}
