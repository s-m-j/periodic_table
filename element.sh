#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=bikes --tuples-only -c"

if [[ $1 ]]
then
  # if input is not a number
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    SELECTED_ELEMET=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements inner join properties using(atomic_number) inner join types using (type_id) WHERE symbol='$1' or name='$1'")      
  else
    SELECTED_ELEMET=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements inner join properties using(atomic_number)  using (type_id) WHERE atomic_number=$1")
  fi
  if [[ -z $SELECTED_ELEMET ]]
  then
    echo -e "I could not find that element in the database."
  else
    echo "$SELECTED_ELEMET" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
    do
      echo -e "\The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of -$BOILING_POINT_CELSIUS celsius."
    done
  fi
else
  echo -e "\nPlease provide an element as an argument."
fi

