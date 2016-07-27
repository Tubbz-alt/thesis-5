-- Adapted from Brady's ICFP 2013 paper

{-# LANGUAGE TypeInType, RebindableSyntax, FlexibleContexts,
             OverloadedStrings, ScopedTypeVariables, TypeApplications,
             AllowAmbiguousTypes, TypeFamilies #-}

module Sec225 where

import Effects
import Effect.File
import Effect.StdIO
import Effect.Exception
import Control.Catchable
import qualified Prelude as P
import Prelude ( IO, not, reverse, (++), ($), Either(..), Bool(..), FilePath
               , mapM_, map, length )
import Data.AChar
import Data.Singletons
import Util.If

type Io = TyCon1 IO

readLines_ :: Eff Io '[FILE_IO (OpenFile Read)] [String]
readLines_ = readAcc []
  where
    readAcc :: [String]
            -> Eff Io '[FILE_IO (OpenFile Read)] [String]
    readAcc acc = do e <- eof
                     if (not e)
                        then do str <- readLine
                                readAcc (str : acc)
                        else return (reverse acc)

readLines :: forall xs prf.
             SingI (prf :: SubList '[FILE_IO (OpenFile Read)] xs)
          => EffM Io xs (UpdateWith '[FILE_IO (OpenFile Read)] xs prf) [String]
readLines = lift @_ @_ @prf readLines_

readFile :: String -> Eff Io '[FILE_IO (), STDIO, EXCEPTION String] [String]
readFile path = catch @(TyCon1 (Eff Io '[FILE_IO (), STDIO, EXCEPTION String]))
                      @_ @[String]
                      (do open path SRead
                          Test SHere (raise ("Cannot open file: " ++ path)) $
                            do lines <- readLines
                               close @_ @Read
                               putStrLn (show (length lines))
                               return lines)
                      (\ err -> do putStrLn ("Failed: " ++ err)
                                   return [])

printFile :: FilePath -> IO ()
printFile filepath
  = run (() :> () :> () :> Empty) (readFile (fromString filepath)) P.>>= \ls ->
    mapM_ P.putStrLn (map toString ls)