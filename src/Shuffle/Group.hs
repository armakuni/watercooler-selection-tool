module Shuffle.Group (Group, new, members) where

import Shuffle.Person (Person)

newtype Group = Group [Person]

new :: [Person] -> Group
new = Group

members :: Group -> [Person]
members (Group ms) = ms
