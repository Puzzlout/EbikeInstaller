echo "Cloning the frontend..."
cd $1

chmod 777 -R frontend/
rm -R frontend/
git clone https://github.com/Puzzlout/TrekToursFlyer.git
mv TrekToursFlyer frontend
