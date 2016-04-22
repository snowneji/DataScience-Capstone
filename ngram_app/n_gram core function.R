
#m is the sample dataset
#pred_data=sum_data


ng_pred <- function(pred_data, query) {
        library(tau)
        library(stringr)
        library(dplyr)
        library(tm)
        query = tolower(query)
        query = str_trim(gsub( "[^[:alnum:]' -]", "", query ))
        query_len = length(unlist(strsplit(query,' ')))
        require_len = min(3,query_len)
        query = paste(unlist(strsplit(query,' '))[(query_len-require_len+1):query_len],collapse = ' ')
        query = str_trim(query)
        # check if query is in the term,
        # if not, deleting the first element and continue search until matched
        #match_list=names(pred_data)[grepl(paste('^',query,' [a-z]*?$',sep = ''),names(pred_data))]
        reg=paste('^',query,' [a-z]*?$',sep='')
        goodrows=with(pred_data, grepl(reg, pred_data$term, perl=TRUE))
        match_list = sum_data[goodrows]
        while (nrow(match_list)==0 && nchar(query)!=0 ){
                query = paste(unlist(strsplit(query,' '))[-1],collapse = ' ')
                print (query)
                goodrows=with(pred_data, grepl(paste('^',query,' [a-z]*?$',sep=''), pred_data$term, perl=TRUE))
                match_list = sum_data[goodrows]
                print(match_list)
                #best_rec = array(data = 1)
                #names(best_rec) = 'and'
        }
        
        if (nrow(match_list)>0) {
                # rank the picked terms based on colsum, means if appear in more doc, recommend first:
                wt_data = match_list
                #extract the words after query for recommendation
                wt_data$term = sub(paste('.*?',query,sep = ''), "", wt_data$term)
                wt_data$term = gsub('[^[:alpha:]]','',wt_data$term)
                wt_data$term = str_trim(wt_data$term)
                # don't need those 1 character recommendations
                wt_data=wt_data[which(nchar(wt_data$term)>1)]
                ##combine same cols and add nums
                ## then divide by the total


 
                wt_data$sum_data = wt_data$sum_data/sum(wt_data$sum_data)
                wt_data$sum_data = round(wt_data$sum_data,5) 
        }
        
        if (nrow(match_list)==0){
                wt_data = data.frame(term='and',sum_data=1)

        }
        
        wt_data
        
        
}
   
                        
ng_pred2 = function(wt_data){
        

        # based on number of frequency to sort again 
        best_rec = arrange(wt_data,desc(sum_data))
        best_rec = best_rec[which(best_rec$term != ''),]
        best_rec = best_rec[which(best_rec$sum_data!=0),]


        # drop trash recommendations
        if (nrow(best_rec)>1){
                good_names = remove_stopwords(best_rec$term,stopwords('english'))
                if (length(good_names)>0){
                        best_rec = best_rec[which(best_rec$term %in% good_names)]   
                }             
        }
        
        
        if (nrow(best_rec)==0){
                wt_data = data.frame(term='and',sum_data=1)
        }
                                   
        names(best_rec) = c('suggestion','score')
        best_rec
                
              
}


