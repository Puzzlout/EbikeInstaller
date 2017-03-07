echo "Cloning the backend..."
cd $1                                                                                                              

chmod -R 777 backend/                                                                                                

rm -R backend/
git clone https://github.com/Puzzlout/TrekToursApi.git
mv TrekToursApi backend

################################################################################
# First install script of API
# 
# Input $1: the deploy folder
# Input $2: dev or prod
#
################################################################################
cd backend/
git pull
#last_release=$(git describe --tags)
#git checkout tags/$last_release -b v$last_release
echo "Run composer..."
#cp ../composer.phar composer.phar
composer install
composer update
echo "IMPORTANT: Require a mysql root user with no password"
php bin/console doctrine:database:create --if-not-exists
php bin/console doctrine:schema:update --dump-sql
php bin/console doctrine:schema:update --force
echo "IMPORTANT: Admin user created with user admin, pass admin"
php bin/console fos:user:create admin admin@admin.com admin --super-admin
php bin/console assets:install --env=$2 --symlink
php bin/console cache:warmup --env=$2
cd ..

