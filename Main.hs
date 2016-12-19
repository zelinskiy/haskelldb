module Main where

import Database.HDBC
import Database.HDBC.Sqlite3
import Control.Monad
import Control.Monad.Trans
import Database.HaskellDB
import Database.HaskellDB.HDBC.SQLite3
import System.Time
import qualified Base.Emp as E

dbpath = "DB.db"


getAllEmps db = query db $ do
  emps <- table E.emp
  restrict $ emps!E.xid .==. (cast "INT" (constant "1"))
  restrict $ emps!E.name `like` (constant "_")
  project $ E.xid << count (emps!E.xid)
 
addEmp :: Int -> String -> Database -> IO ()
addEmp id name db = insert db E.emp $
    E.xid <<- id
  # E.name <<- name

updEmp :: Int -> String -> Database -> IO ()
updEmp id name db = do
  update db
         E.emp
         (\e -> e!E.xid .==. constant id)
         (\e -> E.name << constant name)

withDb :: MonadIO m => (Database -> m a) -> m a
withDb = sqliteConnect dbpath

main = do
  withDb $ updEmp 15 "Kek"
  res <- withDb getAllEmps
  print $ res

