#!/bin/bash

usage(){
    echo -e "Usage: $(basename $0) <module name> <user id> "
    exit 1
}

check_params() {
    # Display help
    if [[ "$@" == "--help" ||  "$@" == "-h" ]]; then
        usage
        exit 0
    fi
    # Check for parameter
    if [[ "$#" -ne 2 ]]; then
        echo "This script needs the module name and user id."
        usage
        exit 1
    fi

}

terraform_init(){
    MODULENAME=$1
    echo "Executing terraform MODULENAME: ${MODULENAME}"
    # Clean up old plans
    rm -f plan.tf
    # Initialise backend
    terraform init \
      -input=false ${MODULENAME}/
    terraform validate ${MODULENAME}/
    # Create the corresponding workspace if it does not exist
    terraform workspace select ${MODULENAME} ${MODULENAME}/ || \
        terraform workspace new ${MODULENAME} ${MODULENAME}/
}
terraform_plan(){
    MODULENAME=$1
    USER_ID=$2

    if [ ${MODULENAME} == "modifyec2permission" ]
    then
        USERID="ec2-${USER_ID}"
    else
        USERID="${USER_ID}"
    fi

    echo "plan terraform MODULENAME: ${MODULENAME}"
    # Create the plan
    terraform plan \
      -var-file=users/${USERID}.tfvars \
      -input=false ${MODULENAME}
}

terraform_deploy(){
    MODULENAME=$1
    USER_ID=$2

    if [ ${MODULENAME} == "modifyec2permission" ]
    then
        USERID="ec2-${USER_ID}"
    else
        USERID="${USER_ID}"
    fi

    echo "deploying terraform MODULENAME: ${MODULENAME}"
    # Create the plan
    terraform plan \
      -out=plan.tf \
      -var-file=users/${USERID}.tfvars \
      -input=false ${MODULENAME}
    # Apply the execution plan
    terraform apply -no-color -input=false plan.tf
}
check_params $1 $2

terraform_init $1 # $1 like "bucketpermission,modifyec2permission"

if [ $? -eq 0 ]
then 

    terraform_plan $1 $2    # $1 like "bucketpermission,modifyec2permission" $2 like userid

    if [ $? -eq 0 ]
    then 
        terraform_deploy $1 $2   # $1 like "bucketpermission,modifyec2permission" $2 like userid
    fi
fi

