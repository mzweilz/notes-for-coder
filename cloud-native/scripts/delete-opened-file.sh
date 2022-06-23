clean-deleted-space()
{
DELETED_FILES=$(cat << EOL $(lsof 2>/dev/null | grep -s deleted | grep -Po "\w+\s+\w+\s+/.*" | awk '{print $1" "$3}' | sort -u | grep -v '^0')
EOL
)
cat << EOL | awk '{sum+=$1} END {print "Will released: "sum/1024/1024" Mb"}'
${DELETED_FILES}
EOL
ONLY_FILES=$(cat << EOL | awk '{print $2}' | grep '^/'
${DELETED_FILES}
EOL
)
cat << EOL
${ONLY_FILES}
EOL
echo "Are you sure to release space of deleted files above?"
echo
select CLEAN in Yes No
do
if [ "$CLEAN" = "Yes" ]
then
for DFILE in ${ONLY_FILES}
do
echo
echo File: $DFILE
FILE_DESC_ADDR=$(find /proc/*/fd -ls 2> /dev/null | grep '(deleted)' | sed 's#\ (deleted)##g' | awk '{print $11" "$13}' | sort -u -k 2 | grep $DFILE | awk '{print $1}')
if [ "$FILE_DESC_ADDR" != "" ] ; then 
echo "executing: truncate -s 0 ${FILE_DESC_ADDR}"
truncate -s 0 ${FILE_DESC_ADDR}
echo done
else
echo "Truncate deleted file $DFILE is impossible, skip"
fi
echo
done
else
echo Nothing to do
fi
break
done
}
clean-deleted-space

