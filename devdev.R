abstracts <- c("Meine Mudder schneided Spack du Spack", "Meine Mudder macht Urlaub auf Sansibar")
pattern <- c("Mudder","Speck","Spack")


find_patterns <- fucntion(string, pattern){
  tmp <-
    lapply(
      pattern,
      function(pattern, string){str_count(abstracts, pattern)},
      string
    )
  tmp <- as.data.frame(t(do.call(rbind, tmp)))
  tmp
}
