module Main where

import Database.HaskellDB.FieldType
import Database.HaskellDB.DBSpec.DBInfo
import Database.HaskellDB.DBSpec.DBSpecToDBDirect
import Database.HaskellDB.DBSpec.PPHelpers

dbdescr = DBInfo "Base" (DBOptions False mkIdentPreserving) [
    TInfo "emp" [
        CInfo "id" (IntT, False)
      , CInfo "name" (StringT, False)
    ]
  ]

main = dbInfoToModuleFiles "." "Base" dbdescr
