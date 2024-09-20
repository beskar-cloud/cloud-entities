#!/usr/bin/env bash

# deploy infrastructure (using terraform)
# Usage: infra-deploy.sh [manifest-dir] [deploy-steps] [terraform-http-backend-url] [terraform-import-arguments]

set -eo pipefail

SCRIPT_DIR=$(dirname $(readlink -f $0))
MANIFEST_DIR="$1"
TERRAFORM_IMPORT_ARGS="${4:-"${TERRAFORM_IMPORT_ARGS}"}"

function expand_import_actions() {
    local actions=""
    [ -n "${TERRAFORM_IMPORT_ARGS}" ] && \
      actions="import,"
    for indx in {1..10}; do
        i_env="TERRAFORM_IMPORT${indx}_ARGS"
        [ -n "${!i_env}" ] && \
          actions="${actions}import-${indx},"
    done
    [ -n "${actions}" ] && \
      echo -n "${actions}plan," || \
      return 0
}

function tf_plan_tee_grep() {
    local out_file="$1"
    cat | tee "${out_file}" | grep -Ev "^(.\[0m.\[1m)?[a-zA-Z0-9_.]+: "
}

export DEPLOY_STEPS="${2:-"init,version,validate,providers,graph,state-list-if-exists,plan,$(expand_import_actions)apply,state-list,show"}"
STAGE_NAME='define variables'
TERRAFORM=${TERRAFORM:-"terraform"}
TERRAFORM_PLAN_FILE="deploy.tfplan"
# action commands
declare -A DEPLOY_STEPS_ARR
DEPLOY_STEPS_ARR[init]="${TERRAFORM} init"
DEPLOY_STEPS_ARR[version]="${TERRAFORM} version"
DEPLOY_STEPS_ARR[validate]="${TERRAFORM} validate"
DEPLOY_STEPS_ARR[providers]="${TERRAFORM} providers"
DEPLOY_STEPS_ARR[graph]="${TERRAFORM} graph"
DEPLOY_STEPS_ARR[plan]="${TERRAFORM} plan --out=${TERRAFORM_PLAN_FILE}"
DEPLOY_STEPS_ARR[apply]="${TERRAFORM} apply --auto-approve ${TERRAFORM_PLAN_FILE}"
DEPLOY_STEPS_ARR[import]="${TERRAFORM} import ${TERRAFORM_IMPORT_ARGS}"
DEPLOY_STEPS_ARR[import-1]="${TERRAFORM} import ${TERRAFORM_IMPORT1_ARGS}"
DEPLOY_STEPS_ARR[import-2]="${TERRAFORM} import ${TERRAFORM_IMPORT2_ARGS}"
DEPLOY_STEPS_ARR[import-3]="${TERRAFORM} import ${TERRAFORM_IMPORT3_ARGS}"
DEPLOY_STEPS_ARR[import-4]="${TERRAFORM} import ${TERRAFORM_IMPORT4_ARGS}"
DEPLOY_STEPS_ARR[import-5]="${TERRAFORM} import ${TERRAFORM_IMPORT5_ARGS}"
DEPLOY_STEPS_ARR[import-6]="${TERRAFORM} import ${TERRAFORM_IMPORT6_ARGS}"
DEPLOY_STEPS_ARR[import-7]="${TERRAFORM} import ${TERRAFORM_IMPORT7_ARGS}"
DEPLOY_STEPS_ARR[import-8]="${TERRAFORM} import ${TERRAFORM_IMPORT8_ARGS}"
DEPLOY_STEPS_ARR[import-9]="${TERRAFORM} import ${TERRAFORM_IMPORT9_ARGS}"
DEPLOY_STEPS_ARR[import-10]="${TERRAFORM} import ${TERRAFORM_IMPORT10_ARGS}"
DEPLOY_STEPS_ARR[state-rm]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM_ARGS}"
DEPLOY_STEPS_ARR[state-rm-1]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM1_ARGS}"
DEPLOY_STEPS_ARR[state-rm-2]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM2_ARGS}"
DEPLOY_STEPS_ARR[state-rm-3]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM3_ARGS}"
DEPLOY_STEPS_ARR[state-rm-4]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM4_ARGS}"
DEPLOY_STEPS_ARR[state-rm-5]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM5_ARGS}"
DEPLOY_STEPS_ARR[state-rm-6]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM6_ARGS}"
DEPLOY_STEPS_ARR[state-rm-7]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM7_ARGS}"
DEPLOY_STEPS_ARR[state-rm-8]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM8_ARGS}"
DEPLOY_STEPS_ARR[state-rm-9]="${TERRAFORM} state rm ${TERRAFORM_STATE_RM9_ARGS}"
DEPLOY_STEPS_ARR[state-list]="${TERRAFORM} state list"
DEPLOY_STEPS_ARR[state-list-if-exists]="${TERRAFORM} state list"
DEPLOY_STEPS_ARR[show]="${TERRAFORM} show"
DEPLOY_STEPS_ARR[force-unlock]="${TERRAFORM} force-unlock -force ${TERRAFORM_LOCK_ID}"
DEPLOY_STEPS_ARR[refresh]="${TERRAFORM} refresh"

# action wrapper commands (command prefix)
declare -A DEPLOY_STEPS_RUNNER
DEPLOY_STEPS_RUNNER[state-list-if-exists]="exec_allow_failure"

# action output filter commands
declare -A DEPLOY_STEPS_OUTPUT_FILTER
DEPLOY_STEPS_OUTPUT_FILTER[state-list]="sponge"
DEPLOY_STEPS_OUTPUT_FILTER[state-list-if-exists]="sponge"
DEPLOY_STEPS_OUTPUT_FILTER[show]="sponge"
DEPLOY_STEPS_OUTPUT_FILTER[graph]="sponge"
DEPLOY_STEPS_OUTPUT_FILTER[plan]="tf_plan_tee_grep"

export TF_HTTP_ADDRESS="${3:-"${TF_HTTP_ADDRESS}"}"
source ${SCRIPT_DIR}/infra-deploy.env

echo "infra-deploy.sh environment configuration:"
env | grep -E '^(TF_|TERRAFORM_IMPORT|TERRAFORM_STATE_RM|TERRAFORM_LOCK_ID|DEPLOY_STEPS|WORKFLOW_STEPS_)' | \
  sort | \
  awk -F= '{if ($1~/TF_HTTP_PASSWORD|TF_VAR_/){print "  "$1"=..."}else{print "  "$0}}'

STAGE_NAME='argument checking'
if [[ "$(grep backend ${MANIFEST_DIR}/main.tf)" =~ backend[[:space:]]*.http ]]; then
    for i_var_name in TF_HTTP_ADDRESS TF_HTTP_PASSWORD; do
        if [ -z "${!i_var_name}" ]; then
            echo "ERROR: environment variable ${i_var_name} is empty which is not expected at step \"${STAGE_NAME}\"" 1>&2
            exit 1
        fi
    done
fi

STAGE_NAME='at_exit () callback registration'

function at_exit () {
    if [ "${STAGE_NAME}" != "success" ]; then
        echo "ERROR: $(basename $0) failed at step ${STAGE_NAME} processing" 1>&2
        exit 1
    fi
    exit 0
}

function exec_allow_failure () {
    if "$@"; then
      return 0
    fi
    return 0
}

# register callback before we exit
trap at_exit EXIT

STAGE_NAME="enter work-directory ${MANIFEST_DIR}"
if [ -n "${MANIFEST_DIR}" ]; then
    pushd "${MANIFEST_DIR}"
fi

STAGE_NAME='argument checking'
for i_deploy_step in ${DEPLOY_STEPS//,/ }; do
    test -n "${DEPLOY_STEPS_ARR[$i_deploy_step]}"
done

for i_deploy_step in ${DEPLOY_STEPS//,/ }; do
    STAGE_NAME="infrastructure deploy @${i_deploy_step}"
    i_log_file="$(date +%Y%m%dT%H%M%S)-terraform-${i_deploy_step}.log"
    echo -e "\nINFO: Performing step ${i_deploy_step} (${DEPLOY_STEPS_ARR[$i_deploy_step]}, log:${i_log_file})\n"
    ${DEPLOY_STEPS_RUNNER[$i_deploy_step]} ${DEPLOY_STEPS_ARR[$i_deploy_step]} | \
      ${DEPLOY_STEPS_OUTPUT_FILTER[$i_deploy_step]:-"tee"} "${i_log_file}"
done | tee "infra-deploy.log"

if [ -n "${MANIFEST_DIR}" ]; then
    popd
fi

STAGE_NAME='success'
