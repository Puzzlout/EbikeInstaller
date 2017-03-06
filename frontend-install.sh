echo "Cloning the frontend..."
cd $1

chmod 777 -R frontend/
rm -R frontend/
git clone https://github.com/Puzzlout/TrekToursFlyer.git
mv TrekToursFlyer frontend

################################################################################
# First install script of API
# 
# Input $2: dev or prod
# Input $1: the deploy folder
# Input $3: the target server:
# 	> local
#	> c9: a Cloud9 workspace
#	> lw: a LiquidWeb Storm VPS
################################################################################
cd public/
git pull
last_release=$(git describe --tags)
git checkout tags/$last_release -b v$last_release
echo "Run composer..."
composer install
composer update
echo "IMPORTANT: Require a mysql root user with no password"
php bin/console doctrine:database:create --if-not-exists
php bin/console doctrine:schema:update --force
php bin/console doctrine:schema:update --dump-sql
php bin/console doctrine:schema:update --force
php bin/console lexik:translations:import AppBundle --cache-clear
php bin/console assets:install --env=$1 --symlink
php bin/console assetic:dump --env=$1 --no-debug
#php bin/console cache:warmup --env=$1

