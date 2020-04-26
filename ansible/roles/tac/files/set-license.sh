#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

declare tac_install_user="${1?missing tac_install_user}"
declare tac_license_filename="${2?missing tac_license_filename}"
declare tac_config_location="${3?missing tac_config_location parameter}"
declare app_tomcat_port="${4?missing app_tomcat_port  parameter}"
declare tac_webapp_name="${5?missing tac_webapp_name parameter}"
declare tac_admin_user="${6?missing tac_admin_user parameter}"
declare tac_admin_pass="${7?missing tac_admin_pass parameter}"

"${tac_config_location}/MetaServletCaller.sh" \
             -url "http://localhost:${app_tomcat_port}/${tac_webapp_name}" \
             -json-params="{\"actionName\":\"setLicenseKey\",
                 \"authUser\":\"${tac_admin_user}\",
                 \"authPass\":\"${tac_admin_pass}\",
                 \"licenseKeyPath\":\"/home/${tac_install_user}/${tac_license_filename}\"}"
