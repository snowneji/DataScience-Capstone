library(data.table)
sum_data = fread('sum_data.csv')


res1 = function(query,data){
        source('n_gram core function.R')
        data = sum_data
        pred_words = ng_pred(data,query)
         
}


res2 = function(pred_data,rec_num){
        source('n_gram core function.R')
        pred_words = pred_data
        pred_words = ng_pred2(pred_words)
        num = min(rec_num,nrow(pred_words))
        pred_words[1:num,]   
}





