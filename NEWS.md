NEWS stringb
==========================================================================


version 0.1.13 [2016-11-01 ...] 
--------------------------------------------------------------------------

* BUGFIXES
    - in contrast to DESCRIPTION specification package would not support R >= 3.0.0 since the strrep() dependecy was only introduced in R 3.2.5
    
* FEATURE

    
* DEVELOPMENT


version 0.1.12 [2016-10-31 ...] 
--------------------------------------------------------------------------

* BUGFIXES

    
* FEATURE
    - CRAN submission
    
* DEVELOPMENT


version 0.1.11 [2016-08-01 ...] 
--------------------------------------------------------------------------

* BUGFIXES

    
* FEATURE
    - text_tokenize_sentences
    
    
* DEVELOPMENT



version 0.1.10 [2016-08-01 ...] 
--------------------------------------------------------------------------

* BUGFIXES
    - text_locate_all() ignores ... (#10)
    - text_tokenize() (#12)
    
    
* FEATURE

    
* DEVELOPMENT



version 0.1.9 [2016-07-29 ...] 
--------------------------------------------------------------------------

* BUGFIXES

    
* FEATURE
    - plot.character()

    
* DEVELOPMENT
    


version 0.1.8 [2016-07-28 ...] 
--------------------------------------------------------------------------

* BUGFIXES

    
* FEATURE
    - text_wrap()
    - text_pad()
    - text_split_n()

    
* DEVELOPMENT
    - test : text_c()
    - test : text_collapse()
    - test : text_which() 
    - test : text_subset() 
    - test : text_filter()
    - test : text_which_value()
    - test : text_grep()
    - test : text_grepv()
    - test : text_grepl()
    - test : text_eval()
    - test : text_to_lower()
    
    

version 0.1.7 [2016-07-26 ...] 
--------------------------------------------------------------------------

* BUGFIXES

    
* FEATURE
    - text_extract_group()
    - text_replace_group()
    - text_locate_group()
    - text_replace_locates()
    - text_extract() and text_extract_all() got invert parameter

    
* DEVELOPMENT
    - helper : drop_non_group_matches()
    - helper : regmatches2()
    - helper : sequenize()
    - helper : de_sequenize()
    


 

version 0.1.6 [2016-07-25 ...] 
--------------------------------------------------------------------------

* BUGFIXES

    
* FEATURE
    - text_sub()
    - text_subset()
    - text_filter()
    - text_c()

    
* DEVELOPMENT
    
    



version 0.1.5 [2016-07-25 ...] 
--------------------------------------------------------------------------

* BUGFIXES
 - text_write : minor fixes

    
* FEATURE
    - text_replace()
    - text_replace_all()
    - text_trim()
    - text_delete()

    
* DEVELOPMENT
    - putting tests in separate files
    
    

version 0.1.4 [2016-07-22 ...] 
--------------------------------------------------------------------------

* BUGFIXES


    
* FEATURE
    - text_collapse() 

    
* DEVELOPMENT
    - text_collapse() : restucture methods / recursive behaviour for lists
    


version 0.1.3 [2016-07-22 ...] 
--------------------------------------------------------------------------

* BUGFIXES


    
* FEATURE
    - text_to_lower()
    - text_to_upper()
    - text_to_title_case()

    
* DEVELOPMENT
    





version 0.1.2 [2016-07-22 ...] 
--------------------------------------------------------------------------

* BUGFIXES


    
* FEATURE
    - text_dup()

    
* DEVELOPMENT
    - adding code coverage 



version 0.1.1 [2016-07-17 ...] 
--------------------------------------------------------------------------

* BUGFIXES


    
* FEATURE
    - text_read() : pass through of options to readLines
    - text_write()
    - text_detect()
    - text_locate()
    - text_locate_all()
    - text_split()
    - text_count


* DEVELOPMENT



version 0.1.0 [2016-07-15 ...]
--------------------------------------------------------------------------

* BUGFIXES


    
* FEATURE


* DEVELOPMENT
    - forking string functions away from diffrprojects package 
    - and cleaning up and restructuring the parent project

