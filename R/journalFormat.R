library(knitr)
library(RefManageR)
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE, 
                      results = 'asis',
                      error = TRUE)

Journal <- function(cptid, DOI) {
    Ref <- GetBibEntryWithDOI(DOI)
    #cat(paste0("\n\n### ", cptid, "\n"))
    cat(paste0("\n\n---\n\n**", paste0(strsplit(cptid, split = "-")[[1]][1:3], collapse = "-"), "**, Speaker: ",
               strsplit(cptid, split = "-")[[1]][4], ", "))
    cat(paste0('[<i class="fa fa-file-pdf-o"></i>PDF](ftp://172.21.61.202/cpt%20documents/BookJournal/2017/Journal/',
               cptid, "/", cptid, ".pdf)\n\n"))
    print(Ref, .opts = list(bib.style = "authortitle", max.names = 1, no.print.fields = "url", style = "html"))
    cat(paste0("![](/assets/", cptid, ".png)"))
}


Presentation <- function(cptid) {
    cat(paste0("\n\n---\n\n**", paste0(strsplit(cptid, split = "-")[[1]][1:3], collapse = "-"), "**, Speaker: ",
               strsplit(cptid, split = "-")[[1]][4], ", "))
    cat(paste0('[<i class="fa fa-file-pdf-o"></i>PDF](ftp://172.21.61.202/cpt%20documents/BookJournal/2017/Presentation/',
               cptid, "/", cptid, ".pdf)\n\n"))
    # print(Ref, .opts = list(bib.style = "authortitle", max.names = 1, no.print.fields = "url", style = "html"))
    cat(paste0("![](/assets/", cptid, ".png)"))
}
