module Lesson04 where

import           Data.List

--
-- Functions as arguments
--

ifEvenInc n = if even n then n + 1 else n
ifEvenDouble n = if even n then n * 2 else n
ifEvenSquare n = if even n then n ^ 2 else n

ifEven f x = if even x then f x else x
--     ^
--   function as argument

inc n = n + 1
double n = n * 2
square n = n ^ 2

ifEvenInc' n = ifEven inc n
ifEvenDouble' n = ifEven double n
ifEvenSquare' n = ifEven square n

--

e1 = ifEven (\x -> x ^ 2) 5 -- 5
e2 = ifEven (\x -> x ^ 2) 6 -- 36

-- QC1

qc1 = ifEven (\x -> x ^ 3) 2 -- 8

-- Example - custom sorting

newOrder =
  [ ("Ian"    , "Curtis")
  , ("Bernard", "Sumner")
  , ("Peter"  , "Hook")
  , ("Stephen", "Morris")
  ]

e3 = sort newOrder -- <sorts by first name>

-- See Q1 for a better way to do this
compareLastNames name1 name2 = if lastName1 > lastName2
  then GT
  else if lastName1 < lastName2 then LT else EQ
 where
  lastName1 = snd name1
  lastName2 = snd name2

e4 = sortBy compareLastNames newOrder -- <sorts by last name>

-- QC2

names' = newOrder ++ [("George", "Morris")]

compareLastNames' name1 name2 | lastName1 > lastName2   = GT
                              | lastName1 < lastName2   = LT
                              | firstName1 > firstName2 = GT
                              | firstName1 < firstName2 = LT
                              | otherwise               = EQ
 where
  lastName1  = snd name1
  lastName2  = snd name2
  firstName1 = fst name1
  firstName2 = fst name2

qc2 = sortBy compareLastNames' names'

--
-- Returning functions
--

addressLetter name location = nameText ++ " - " ++ location
  where nameText = fst name ++ " " ++ snd name

--

-- San Francisco has a new address for last names beginning with "L":
sfOffice name = if lastName < "L"
  then nameText ++ " - PO Box 1234 - San Francisco, CA 94111"
  else nameText ++ " - PO Box 1010 - San Francisco, CA 94109"
 where
  lastName = snd name
  nameText = fst name ++ " " ++ lastName

-- New York wants the name followed by a ':' instead of a '-':
nyOffice name = nameText ++ ": PO Box 789 - New York, NY 10013"
  where nameText = fst name ++ " " ++ snd name

-- Reno only wants the last names:
renoOffice name = nameText ++ " - PO Box 456 - Reno, NV 89523"
  where nameText = snd name

-- Return the correct function for the specified location
getLocationFunction location = case location of
  "ny"   -> nyOffice
  "sf"   -> sfOffice
  "reno" -> renoOffice
  _      -> \name -> fst name ++ " " ++ snd name

-- E.g. addressLetter' ("Bob", "Smith") "ny" == "Bob Smith: PO Box 789 - New York, NY, 10013"
--      addressLetter' ("Joe","Blow") "la" == "Joe Blow"
addressLetter' name location = getLocationFunction location name

-- Q1

compareLastNames'' name1 name2
  | compareLastNames''' == EQ = compare firstName1 firstName2
  | otherwise                 = compareLastNames'''
 where
  lastName1           = snd name1
  lastName2           = snd name2
  firstName1          = fst name1
  firstName2          = fst name2
  compareLastNames''' = compare lastName1 lastName2

-- Q2

dcOffice name = nameText ++ " - PO Box 333 - Washington, DC 20202"
  where nameText = fst name ++ " " ++ snd name ++ " , Esq."

getLocationFunction' location = case location of
  "ny"   -> nyOffice
  "sf"   -> sfOffice
  "reno" -> renoOffice
  "dc"   -> dcOffice
  _      -> \name -> fst name ++ " " ++ snd name

addressLetter'' name location = getLocationFunction' location name
