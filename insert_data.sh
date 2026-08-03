#!/bin/bash

echo hello world

PSQL="psql -X --username=user --dbname=budget_app --no-align --tuples-only -c"
cat money_spent.csv | while IFS="," read DATA AMOUNT NAME CATEGORY
do
echo $CATEGORY $AMOUNT
# get category id
CATEGORY_ID=$($PSQL "SELECT category_id FROM category_table WHERE category='$CATEGORY'")
if [[ -z $CATEGORY_ID ]]
then
# insert major
# get new major_id
fi
done
