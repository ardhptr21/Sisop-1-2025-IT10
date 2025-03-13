Database="data/player.csv"

read -p "Enter your email: " email
read -sp "Enter your password: " password
password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
echo ""

username=$(grep "$email," "data/player.csv" | awk 'BEGIN {FS=","} {print $2}')
echo "$email,$username" > session.txt

if grep -qr "$email,.*,$password_hash$" $Database;
then
   bash core_monitor.sh
else
   echo "Invalid email or password."
fi



