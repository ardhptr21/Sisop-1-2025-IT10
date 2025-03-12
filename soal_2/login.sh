Database="data/player.csv"

read -p "Enter your email: " email
read -sp "Enter your password: " password
password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
echo ""

username=$(grep "&email," "data/player.csv" | cut -d ',' -f2)
echo "$email,$username" > session.txt

if grep -qr "$email,.*,$password_hash$" $Database;
then
   bash core_monitoring.sh
else
   echo "Invalid email or password."
fi



