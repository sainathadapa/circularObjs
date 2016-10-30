# x is a named list of labels
circularObj <- function(spec, className) {
  
  if (is.null(names(spec)) || any(names(spec) == '')) stop('spec should be a named list!')
  
  spec_lengths <- vapply(X = spec, FUN = length, FUN.VALUE = 1L, USE.NAMES = TRUE)
  
  ans <- function(x) {
    
    if (!all(names(spec) %in% names(x))) stop('all elements are not present!')
    
    for (one_el in names(spec)) {
      if (!(x[[one_el]] %in% spec[[one_el]])) stop('one of the input values is not present in the spec!')
    }
    
    x <- x[names(spec)]
    structure(list(
      obj = x,
      spec = spec,
      spec_lengths = spec_lengths
    ), class = c(className, 'circularObj'))
  }
  
  ans
}

library('R.methodsS3')

setMethodS3(name = 'print', class = 'circularObj', function(x, ...) {
  print(x$obj)
  invisible(x$obj)
})


add_or_subtract <- function(e1, e2) {
  transt <- Map(f = function(p, q) which(p == q), p = e1$spec, q = e1$obj)
  
  toadd <- e2
  for (i in seq_along(transt)) {
    transt[[i]] <- transt[[i]] + toadd
    
    if (transt[[i]] <= e1$spec_lengths[i] && transt[[i]] >= 1) break;
    
    toadd <- transt[[i]] %/% e1$spec_lengths[i]
    transt[[i]] <- transt[[i]] %% e1$spec_lengths[i]
    
  }
  
  ans <- e1
  ans$obj <- Map(f = function(p, q) p[q], p = e1$spec, q = transt)
  
  ans
}

setMethodS3(name = '+', class = 'circularObj', definition = add_or_subtract)
setMethodS3(name = '-', class = 'circularObj', definition = function(e1, e2) add_or_subtract(e1, -e2))
