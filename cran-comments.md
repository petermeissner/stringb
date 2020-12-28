
# Your message:

You may have seen that when running your package code with current
r-devel, one gets warnings about

  cannot xtfrm data frames

This is because you call order() on a data frame with k rows and 1
column which (currently) returns something of length k.

Now,

? sort says

     Sort (or _order_) a vector or factor (partially) into ascending or
     descending order.  For ordering along more than one variable,
     e.g., for sorting data frames, see ‘order’

where in turn ? order says

     ‘order’ returns a permutation which rearranges its first argument
     into ascending or descending order, breaking ties by further
     arguments.  ‘sort.list’ does the same, using only one argument.
     See the examples for how to use these functions to sort data
     frames, etc.

and then the examples clearly explain to use do.call() for data
frames, ideally also unnaming to avoid name clashes.

Can you please change your package code to no longer call order() on
data frames?


# My Actions

- fixed stringb_arrange() accordingly



## Test environments

- Win10, local (R 3.6.3)
- Ubuntu 18.04 LTS old, devel, release
- WinBuilder devel, release



## Test results 

no errors, no warnings, no notes
