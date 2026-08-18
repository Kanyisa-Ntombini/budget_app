#!/bin/bash

echo Hello World!

PSQL="psql -X --username=user --dbname=budget_app --no-align --tuples-only -c"
echo $($PSQL "TRUNCATE expenses, categories, balances, expenses_categories")

cat money_spent.csv | while IFS="," read DATA AMOUNT NAME CATEGORY
do
  echo $CATEGORY $AMOUNT
  
  # get category id
  CATEGORY_ID=$($PSQL "SELECT category_id FROM categories WHERE category='$CATEGORY'")
  
  if [[ -z $CATEGORY_ID ]]
  then
    # insert category
    INSERT_CATEGORY_RESULT=$($PSQL "INSERT INTO categories(category, budgeted_amount) VALUES('$CATEGORY', '$AMOUNT')")
    if [[ $INSERT_CATEGORY_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted into categories, $CATEGORY"
    fi
    
    # get new category_id
  fi
  
done
