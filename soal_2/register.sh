
Database="data/player.csv"

email_constraint()
{
 if [[ ! "$1" =~ @.*\. ]]; then
    echo "Invalid Email Format"
    exit 1
 fi
}

password_constraint()
{
 if [[ ! "$1" =~ [A-Z] || ! "$1" =~ [a-z] || ! "$1" =~ [0-9] || ${#1} -lt 8 ]]; then
   echo "Invalid Password Format"
   exit 1
 else 
   echo "Password meets all requirement"
 fi
}

read -p "Enter Email Address: " email
email_constraint "$email"

if grep -q "$email," "$Database"; then
    echo "Email is already registered"
    exit 1
fi

read -p "Enter Username: " username

read -sp "Enter Password: " password
password_constraint ".$password"
password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
echo ""

echo "$email,$username,$password_hash" >> "$Database"

echo "Registration success!"
