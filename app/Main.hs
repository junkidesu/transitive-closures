module Main (main) where

import Algorithms.TransitiveClosure.Naive (transitiveClosure)
import Algorithms.TransitiveClosure.Warshall (warshall)
import Data.Matrix (fromLists, prettyMatrix)
import Options.Applicative

data Input = StdIn [[Int]] | InputFile FilePath
  deriving (Read)

data Algorithm = Naive | Warshall

data Options = Options
  { input :: Input
  , algorithm :: Algorithm
  }

stdInParser :: Parser Input
stdInParser =
  StdIn
    <$> option
      auto
      ( long "matrix"
          <> short 'm'
          <> help "The matrix as list of lists"
      )

inputFileParser :: Parser Input
inputFileParser =
  InputFile
    <$> strOption
      ( long "file"
          <> short 'f'
          <> help "The path of the file containing the matrix"
      )

inputParser :: Parser Input
inputParser = stdInParser <|> inputFileParser

algorithmParser :: Parser Algorithm
algorithmParser =
  flag
    Naive
    Naive
    ( long "naive"
        <> help "Whether to use the naive algorithm"
    )
    <|> flag
      Naive
      Warshall
      ( long "warshall"
          <> help "Whether to use Warshall algorithm"
      )

optionsParser :: Parser Options
optionsParser = Options <$> inputParser <*> algorithmParser

main :: IO ()
main = run =<< execParser opts
 where
  opts =
    info
      (optionsParser <**> helper)
      ( fullDesc
          <> progDesc "Find the matrix of the transitive closure of a finite binary relation"
          <> header "transive-closures-exe - CLI tool to find the transitive closure of a finite binary relation"
      )

run :: Options -> IO ()
run opts = case input opts of
  StdIn lists ->
    runAlgorithm (algorithm opts) (fromLists lists)
  InputFile path -> do
    runAlgorithm (algorithm opts) . fromLists =<< (readFile path >>= readIO)
 where
  runAlgorithm Naive = putStrLn . prettyMatrix . transitiveClosure
  runAlgorithm Warshall = putStrLn . prettyMatrix . warshall
