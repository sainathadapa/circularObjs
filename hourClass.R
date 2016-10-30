hourClass <- function(x) {
  if (x > 12 || x <= 0) stop('hour cannot be more than 12 or less than 0')
  structure(list(x), class = 'hourClass')
}

library('R.methodsS3')

setMethodS3(name = '+', class = 'hourClass', function(x, y) {
  ans <- x[[1]] + y
  if (ans < 12 && ans >= 0) return(ans)
  if (ans >= 12) return(ans - 12)
  if (ans < 0) return(12 + ans)
})

tmp <- hourClass(7)

tmp + 10

