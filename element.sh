#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
#check for argument
if [[ ! $1 ]]
then
echo "Please provide an element as an argument."
#if argument is a number
elif [[ $1 =~ ^[0-9]+$ ]]
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number from elements WHERE atomic_number = $1")
    if [[ -z $ATOMIC_NUMBER ]]
    then
    echo -e "\nI could not find that element in the database."
    else
    ELEMENT_DATA=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number = $1")
    echo $ELEMENT_DATA | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_WEIGHT BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
    do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_WEIGHT amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
    fi
#if argument is not a number
else
  GET_SYMBOL=$($PSQL "SELECT symbol FROM elements where symbol = '$1'")
    if [[ -z $GET_SYMBOL ]]
    then
    GET_NAME=$($PSQL "SELECT name from elements where name = '$1'")
      if [[ -z $GET_NAME ]]
      then
      echo "I could not find that element in the database."
      else
      ELEMENT_DATA=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$1'")
      echo $ELEMENT_DATA | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_WEIGHT BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
      do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_WEIGHT amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
      fi
    else
    ELEMENT_DATA=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol = '$1'")
    echo $ELEMENT_DATA | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_WEIGHT BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
    do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_WEIGHT amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
    fi
fi
