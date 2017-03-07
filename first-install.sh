################################################################################
# First install script
# 
# Input $1: the current install directory
#
# Input $2: the target server:
# 	-> local
#	-> c9: a Cloud9 workspace
#	-> lw: a LiquidWeb Storm VPS
#
# Input $3: defines what we install. 
#	Values: 
#		-> api: parameter $4 will be used if given
#		-> flyer: parameter $4 will be used if given
#		-> all: parameter $4 will not be used.
#		TODO: accept array of tags when $3 is all to specify the tag to install for api and flyer
# 
# Input $4: the tag to deploy the install from.
#
################################################################################
# Parameters check
################################################################################
if [ $1 == "" ]
	then
		exit "The first argument is missing. It must be the folder where the applications needs to be installed."
fi
################################################################################
# Installing the applications
################################################################################
bash installer/backend-install.sh $1 prod all
bash installer/frontend-install.sh $1 prod all

